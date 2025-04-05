
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/completed_event_model/CompletedEventResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/user_event_profile/volunteer_report_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/mission_report_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';

class VolunteerEventReportScreen extends StatefulWidget {
  const VolunteerEventReportScreen({super.key});

  @override
  State<VolunteerEventReportScreen> createState() => _VolunteerEventReportScreenState();
}

class _VolunteerEventReportScreenState extends State<VolunteerEventReportScreen> {


  final volunteerController = Get.put(VolunteerReportController());

  final queryEditingController = TextEditingController();

  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    volunteerController.retriveAllEventShow();

  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(

        floatingActionButton: FloatingActionButton.extended(onPressed: ()async{

          if(volunteerController.obs.value.state?.isNotEmpty??true){

            await requestPermissions();
            await generateAndDownloadPDF();

          }else{

            Toast.errorToast("No Events yet!!");
          }

        },
          backgroundColor: Colors.amber,
          label: Row(
            children: [

              CustomText(
                textAlign: TextAlign.start,
                text: "Download",
                fontSize:isTablet?6.sp: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                bottom: 5,
              ),
              SizedBox(
                width: 4.w,
              ),
              Icon(Icons.arrow_circle_down_outlined,color: Colors.white,),
            ],
          ),),
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Event Report",
        ),
        body: RefreshIndicator(child: ListView(
          children: [
            Obx(
                    () {

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        SizedBox(
                          height: 8.h,
                        ),


                        SizedBox(
                          height: 12.h,
                        ),

                        ///============ search ======================================
                        CustomTextField(
                          textEditingController:queryEditingController,
                          fillColor: AppColors.neutral02,
                          //  hintText: AppStrings.search,
                          hintText: "Search for event name...",
                          hintStyle: TextStyle(fontSize:isTablet?6.sp: 14.sp),
                          onChanged: (value){
                            setState(() {
                              query = value;
                            });
                            volunteerController.searchMissionReport(query);
                          },

                          suffixIcon: query.isBlank == true || query.isEmpty
                              ? Icon(
                            FluentIcons.search_24_regular,
                            size: 24,
                          )
                              : IconButton(
                              icon: Icon(Icons.close,size: 24,),
                              onPressed: () {
                                setState(() {
                                  query = "";
                                });
                                queryEditingController.clear();
                                FocusScope.of(context).unfocus();

                                volunteerController.searchMissionReport("");

                              }),

                        ),

                        SizedBox(
                          height: 8.h,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Date range",
                          fontSize:isTablet?6.sp: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          bottom: 8.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CustomText(
                                      text: "From",
                                      fontSize:isTablet?6.sp: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                    ),
                                    TextFormField(
                                      controller: volunteerController.eventStartSelectedSearchDateController.value,
                                      textAlign: TextAlign.center,
                                      showCursor: false,
                                      readOnly: true,
                                      onTap: (){

                                        showModalBottomSheet(
                                          context: context,
                                          //background color for modal bottom screen
                                          backgroundColor: Colors.white,
                                          //elevates modal bottom screen
                                          elevation: 10,
                                          // gives rounded corner to modal bottom screen
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          builder: (BuildContext context) {
                                            // UDE : SizedBox instead of Container for whitespaces
                                            return SizedBox(
                                              height: MediaQuery.sizeOf(context).height/3,
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Obx(
                                                        () {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // Title
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              const Text(
                                                                'From date',
                                                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                              ),

                                                              InkWell(
                                                                  onTap: (){
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Icon(Icons.clear,size: 32,))
                                                            ],
                                                          ),

                                                          SizedBox(
                                                            height: 8.h,
                                                          ),

                                                          Row(
                                                            children: [

                                                              Expanded(
                                                                child: TextFormField(
                                                                  textAlign: TextAlign.center,
                                                                  showCursor: false,
                                                                  readOnly: true,
                                                                  onTap: (){

                                                                    volunteerController.frompickYear();
                                                                  },
                                                                  controller: volunteerController.eventStartSearchDateController.value,
                                                                  decoration: InputDecoration(
                                                                    hintText: "YYYY",
                                                                    hintStyle: TextStyle(fontSize: 12.0,),
                                                                    filled: true,
                                                                    fillColor:AppColors.grey_3.withOpacity(0.5),
                                                                    ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                                                    suffixIcon: volunteerController.eventStartSearchDateController.value.text.isNotEmpty
                                                                        ? IconButton(
                                                                      icon: Icon(Icons.clear, color: Colors.black54),
                                                                      onPressed: (){
                                                                        volunteerController.eventStartSearchDateController.value.clear();
                                                                        FocusScope.of(context).unfocus();
                                                                      },
                                                                    ) : IconButton(onPressed: (){
                                                                      // organizerController.eventEndSearchDate();
                                                                    }, icon: Icon(Icons.calendar_month)),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      borderSide: BorderSide.none,
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(0),
                                                                  ),
                                                                  onChanged: (query) {
                                                                    // Handle search query change (e.g., filtering data)

                                                                  },
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Expanded(
                                                                child: InputDecorator(
                                                                  decoration: const InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(4),
                                                                  ),
                                                                  child: DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<String>(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        //  AppStrings.discountType,
                                                                        volunteerController.selectedStartMonthValue.value,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      items: volunteerController.monthItems
                                                                          .toSet() // Ensure unique values
                                                                          .map(
                                                                            (String item) => DropdownMenuItem<String>(
                                                                          value: item,
                                                                          child: Text(
                                                                            item,
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ).toList(),
                                                                      value: volunteerController.dayItems.contains(volunteerController.selectedStartMonthValue.value)
                                                                          ? volunteerController.selectedStartMonthValue.value
                                                                          : null, // Handle invalid selection
                                                                      onChanged: (String? value) {
                                                                        volunteerController.selectedStartMonthValue.value = value!;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Expanded(
                                                                child: InputDecorator(
                                                                  decoration: const InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(4),
                                                                  ),
                                                                  child: DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<String>(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        //  AppStrings.discountType,
                                                                        volunteerController.selectedStartday.value,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      items: volunteerController.dayItems
                                                                          .toSet() // Ensure unique values
                                                                          .map(
                                                                            (String item) => DropdownMenuItem<String>(
                                                                          value: item,
                                                                          child: Text(
                                                                            item,
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ).toList(),
                                                                      value: volunteerController.monthItems.contains(volunteerController.selectedStartday.value)
                                                                          ? volunteerController.selectedStartday.value
                                                                          : null, // Handle invalid selection
                                                                      onChanged: (String? value) {
                                                                        volunteerController.selectedStartday.value = value!;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          SizedBox(
                                                            height: 16.h,
                                                          ),

                                                          CustomButton(
                                                            height: isTablet?70:60,
                                                            onTap: () {

                                                              if(volunteerController.eventStartSearchDateController.value.text.isNotEmpty && volunteerController.selectedStartMonthValue.value=="select month" && volunteerController.selectedStartday.value=="select day"){


                                                                volunteerController.formateDate.value ="${volunteerController.eventStartSearchDateController.value.text}";

                                                                volunteerController.retriveSpecificFromDateEventReportShow(volunteerController.formateDate.value);

                                                                debugPrint("year:${volunteerController.formateDate.value}");

                                                                volunteerController.eventStartSelectedSearchDateController.value.text="${volunteerController.formateDate.value}";
                                                                Navigator.of(context).pop();

                                                              }else{

                                                                if(volunteerController.eventStartSearchDateController.value.text==""){
                                                                  Toast.errorToast("Year is empty!!");
                                                                }else if(volunteerController.selectedStartMonthValue.value=="select month"){
                                                                  Toast.errorToast("Month is empty!!");
                                                                }else if(volunteerController.selectedStartday.value=="select day"){
                                                                  Toast.errorToast("Day is empty!!");
                                                                }else{

                                                                  volunteerController.formateDate.value ="${volunteerController.eventStartSearchDateController.value.text}-${volunteerController.selectedStartMonthValue.value}-${volunteerController.selectedStartday.value}";

                                                                  volunteerController.retriveSpecificFromDateEventReportShow(volunteerController.formateDate.value);
                                                                  debugPrint("dateFormat:${volunteerController.formateDate.value}");

                                                                  volunteerController.eventStartSelectedSearchDateController.value.text="${volunteerController.formateDate.value}";

                                                                  Navigator.of(context).pop();
                                                                }
                                                              }
                                                            },
                                                            title: "Done",
                                                            fontSize: isTablet ? 16 : 14,
                                                          )
                                                        ],
                                                      );
                                                    }
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      decoration: InputDecoration(
                                        hintText: "0000-00-00",
                                        hintStyle: TextStyle(fontSize: 12.0,),
                                        filled: true,
                                        fillColor:AppColors.grey_3.withOpacity(0.5),
                                        ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                        suffixIcon:  IconButton(onPressed: (){
                                          //  organizerController.eventSartSearchDate();
                                        }, icon: Icon(Icons.calendar_month)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      onChanged: (query) {
                                        // Handle search query change (e.g., filtering data)
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 12.h,
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CustomText(
                                      text: "to",
                                      fontSize:isTablet?6.sp: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                    ),
                                    TextFormField(
                                      textAlign: TextAlign.center,
                                      showCursor: false,
                                      readOnly: true,
                                      onTap: (){

                                        showModalBottomSheet(
                                          context: context,
                                          //background color for modal bottom screen
                                          backgroundColor: Colors.white,
                                          //elevates modal bottom screen
                                          elevation: 10,
                                          // gives rounded corner to modal bottom screen
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          builder: (BuildContext context) {
                                            // UDE : SizedBox instead of Container for whitespaces
                                            return SizedBox(
                                              height: MediaQuery.sizeOf(context).height/3,
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Obx(
                                                        () {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                        children: [
                                                          // Title
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              const Text(
                                                                'To date',
                                                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                              ),

                                                              InkWell(
                                                                  onTap: (){
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Icon(Icons.clear,size: 32,))
                                                            ],
                                                          ),

                                                          SizedBox(
                                                            width: 8.h,
                                                          ),

                                                          Row(
                                                            children: [

                                                              Expanded(
                                                                child: TextFormField(
                                                                  textAlign: TextAlign.center,
                                                                  showCursor: false,
                                                                  readOnly: true,
                                                                  onTap: (){

                                                                    volunteerController.topickYear();
                                                                  },
                                                                  controller: volunteerController.eventEndSearchDateController.value,
                                                                  decoration: InputDecoration(
                                                                    hintText: "YYYY",
                                                                    hintStyle: TextStyle(fontSize: 12.0,),
                                                                    filled: true,
                                                                    fillColor:AppColors.grey_3.withOpacity(0.5),
                                                                    ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                                                    suffixIcon: volunteerController.eventEndSearchDateController.value.text.isNotEmpty
                                                                        ? IconButton(
                                                                      icon: Icon(Icons.clear, color: Colors.black54),
                                                                      onPressed: (){
                                                                        volunteerController.eventEndSearchDateController.value.clear();
                                                                        volunteerController.eventEndSelectedSearchDateController.value.clear();
                                                                        FocusScope.of(context).unfocus();
                                                                      },
                                                                    ) : IconButton(onPressed: (){
                                                                      // organizerController.eventEndSearchDate();
                                                                    }, icon: Icon(Icons.calendar_month)),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      borderSide: BorderSide.none,
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(0),
                                                                  ),
                                                                  onChanged: (query) {
                                                                    ///Handle search query change (e.g., filtering data)
                                                                  },
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Expanded(
                                                                child: InputDecorator(
                                                                  decoration: const InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(4),
                                                                  ),
                                                                  child: DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<String>(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        ///AppStrings.discountType,
                                                                        volunteerController.selectedEndingMonthValue.value,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      items: volunteerController.monthItems
                                                                          .toSet() /// Ensure unique values
                                                                          .map(
                                                                            (String item) => DropdownMenuItem<String>(
                                                                          value: item,
                                                                          child: Text(
                                                                            item,
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ).toList(),
                                                                      value: volunteerController.monthEndItems.contains(volunteerController.selectedEndingMonthValue.value)
                                                                          ? volunteerController.selectedEndingMonthValue.value
                                                                          : null, // Handle invalid selection
                                                                      onChanged: (String? value) {
                                                                        volunteerController.selectedEndingMonthValue.value = value!;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Expanded(
                                                                child: InputDecorator(
                                                                  decoration: const InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                                    ),
                                                                    contentPadding: EdgeInsets.all(4),
                                                                  ),
                                                                  child: DropdownButtonHideUnderline(
                                                                    child: DropdownButton2<String>(
                                                                      isExpanded: true,
                                                                      hint: Text(
                                                                        //  AppStrings.discountType,
                                                                        volunteerController.selectedEnding_day.value,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      items: volunteerController.dayEndItems
                                                                          .toSet() // Ensure unique values
                                                                          .map(
                                                                            (String item) => DropdownMenuItem<String>(
                                                                          value: item,
                                                                          child: Text(
                                                                            item,
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ).toList(),
                                                                      value: volunteerController.dayEndItems.contains(volunteerController.selectedEnding_day.value)
                                                                          ? volunteerController.selectedEnding_day.value
                                                                          : null, // Handle invalid selection
                                                                      onChanged: (String? value) {
                                                                        volunteerController.selectedEnding_day.value = value!;
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          CustomButton(
                                                            height: isTablet?70:60,
                                                            onTap: () {

                                                              if(volunteerController.formateDate.isEmpty){

                                                                Toast.errorToast("From year Date is empty!!");

                                                              }else if(volunteerController.eventEndSearchDateController.value.text.isNotEmpty && volunteerController.selectedEndingMonthValue.value=="select month" && volunteerController.selectedEnding_day.value=="select day"){

                                                                volunteerController.formateToDate.value ="${volunteerController.eventEndSearchDateController.value.text}";

                                                                volunteerController.retriveSpecificDateToDateEventReportShow(volunteerController.formateDate.value,volunteerController.formateToDate.value);

                                                                debugPrint("year:${volunteerController.formateDate.value},,${volunteerController.formateToDate.value}");

                                                                volunteerController.eventEndSelectedSearchDateController.value.text="${volunteerController.formateToDate.value}";
                                                                Navigator.of(context).pop();

                                                              }else{


                                                                if(volunteerController.eventEndSearchDateController.value.text==""){
                                                                  Toast.errorToast("Year is empty!!");
                                                                }else if(volunteerController.eventEndSearchDateController.value.text==""){
                                                                  Toast.errorToast("Year is empty!!");
                                                                }else if(volunteerController.selectedEndingMonthValue.value=="select month"){
                                                                  Toast.errorToast("Month is empty!!");
                                                                }else if(volunteerController.selectedEnding_day.value=="select day"){
                                                                  Toast.errorToast("Day is empty!!");
                                                                }else{


                                                                  volunteerController.formateToDate.value ="${volunteerController.eventEndSearchDateController.value.text}-${volunteerController.selectedEndingMonthValue.value}-${volunteerController.selectedEnding_day.value}";

                                                                  volunteerController.retriveSpecificDateToDateEventReportShow(volunteerController.formateDate.value,volunteerController.formateToDate.value);

                                                                  debugPrint("toFormat:${volunteerController.formateDate.value},${volunteerController.formateToDate.value}");

                                                                  volunteerController.eventEndSelectedSearchDateController.value.text="${volunteerController.formateToDate.value}";

                                                                  Navigator.of(context).pop();
                                                                }
                                                              }

                                                            },
                                                            title: "Done",
                                                            fontSize: isTablet ? 16 : 14,
                                                          )
                                                        ],
                                                      );
                                                    }
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      controller:volunteerController.eventEndSelectedSearchDateController.value,
                                      decoration: InputDecoration(
                                        hintText: "0000-00-00",
                                        hintStyle: TextStyle(fontSize: 12.0,),
                                        filled: true,
                                        fillColor:AppColors.grey_3.withOpacity(0.5),
                                        ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                        suffixIcon: IconButton(onPressed: (){
                                          // organizerController.eventEndSearchDate();
                                        }, icon: Icon(Icons.calendar_month)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      onChanged: (query) {
                                        // Handle search query change (e.g., filtering data)
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Events",
                          fontSize:isTablet?6.sp: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        volunteerController.eventShowList.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No event yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        volunteerController.obx((state){

                          return ListView.builder(
                              itemCount: state?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {

                                final model = state?[index];

                                return Card(
                                  color: Colors.white,
                                  elevation: 0.2,
                                  child: ExpansionTile(
                                    shape: Border(),
                                    title: Text("${model?.name}",style: TextStyle(fontSize: isTablet?9.sp:14.sp),),
                                    children: [

                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: AppColors.grey_3.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(15),
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              CustomText(
                                                textAlign: TextAlign.start,
                                                text: "Hours: ${model?.report?.hours != null ? model?.report?.hours?.round() : 0} H",
                                                maxLines: 3,
                                                fontSize:isTablet?6.sp: 14,
                                                fontWeight: FontWeight.w500,
                                              ),

                                              SizedBox(
                                                height: 4.h,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  CustomText(
                                                    textAlign: TextAlign.start,
                                                    text: "Mileage: ${model?.report?.mileage != null ? model?.report?.mileage?.round() : 0} Km",
                                                    maxLines: 3,
                                                    fontSize:isTablet?6.sp: 14,
                                                    fontWeight: FontWeight.w500,
                                                    bottom: 5,
                                                  ),

                                                  FloatingActionButton.small(onPressed: (){

                                                    generateSpecificDownloadPDF(model);
                                                  },
                                                    backgroundColor: Colors.amber,
                                                    child: Icon(Icons.arrow_circle_down_outlined,color: Colors.white,),)
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              });

                        })

                      ],
                    ),
                  );
                }
            )
          ],
        ),  onRefresh: ()async {
          await  volunteerController.retriveAllEventShow();
        },)

      );
    });
  }



  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // You can now use storage
    } else {
      // Handle permission denial
    }
  }

  ///specific
  Future<void> generateSpecificDownloadPDF(CompletedEventResponeModel? model) async {
    final pdf = pw.Document();

    ///Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [


              pw.SizedBox(height: 8.h),
              ///Event List Section Title
              pw.Text(
                "Events",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
              ),

              pw.SizedBox(height: 12.h),

              ///Event List - Generate 3 events

              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                  pw.Text("${model?.name}",style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  pw.Container(
                    padding: const pw.EdgeInsets.only(bottom: 16),
                    alignment: pw.Alignment.centerLeft,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      borderRadius: pw.BorderRadius.circular(15),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Hours: ${model?.report?.hours != null ? model?.report?.hours?.round() : 0} H",
                            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                "Mileage: ${model?.report?.mileage != null ? model?.report?.mileage?.round() : 0} Km",
                                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );

    // Save the generated PDF to a file
    final outputDirectory = await getExternalStorageDirectory();
    final file = File('${outputDirectory!.path}/generated_pdf.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the file for viewing
    OpenFile.open(file.path);
  }


  Future<void> generateAndDownloadPDF() async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [

              pw.SizedBox(height: 8.h),
              ///Event List Section Title
              pw.Text(
                "Events",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
              ),

              pw.SizedBox(height: 12.h),


              ///Event List - Generate 3 events
              for (int i = 0; i < volunteerController.obs.value.state!.length; i++)
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    pw.Text("${volunteerController.obs.value.state?[i].name}",style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 16),
                      alignment: pw.Alignment.centerLeft,
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius: pw.BorderRadius.circular(15),
                      ),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Hours: ${volunteerController.obs.value.state?[i].report?.hours!=null? (volunteerController.obs.value.state?[i].report?.hours?.round()):0} H",
                              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Mileage: ${volunteerController.obs.value.state?[i].report?.mileage !=null? (volunteerController.obs.value.state?[i].report?.mileage?.round()):0} Km",
                                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )

            ],
          );
        },
      ),
    );

    // Save the generated PDF to a file
    final outputDirectory = await getExternalStorageDirectory();
    final file = File('${outputDirectory!.path}/generated_pdf.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the file for viewing
    OpenFile.open(file.path);
  }
}

