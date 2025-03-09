
import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/mission_report_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';

class MissionEventReportScreen extends StatefulWidget {
  const MissionEventReportScreen({super.key});

  @override
  State<MissionEventReportScreen> createState() => _MissionEventReportScreenState();
}

class _MissionEventReportScreenState extends State<MissionEventReportScreen> {

  final _searchController =TextEditingController();

  final  organizerController = Get.find<OrganizerController>();

  String missionId="";

  String missionDescription="";

  final administratorController = Get.put(AdministratiorController());

  final missionReportController = Get.put(MissionToReportController());


  final queryEditingController = TextEditingController();

  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["missionId"]!=null){

      missionId = Get.arguments[0]["missionId"];

      missionReportController.retriveAllEventByMissionShow(missionId);
    }

  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(

        floatingActionButton: FloatingActionButton.extended(onPressed: ()async{

            await requestPermissions();

            await generateAndDownloadPDF();
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
          titleName: "Mission Report",
        ),
        body: SingleChildScrollView(
          child: Obx(
           () {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      textAlign: TextAlign.start,
                      text: "Organizations",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      bottom: 5,
                    ),

                    ListView.builder(
                        itemCount: administratorController.missionDetailsShowList.value.connectedOrganizations?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          final connectedOrganizations =administratorController.missionDetailsShowList.value.connectedOrganizations?[index];

                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "${connectedOrganizations?.name}",
                                fontSize:isTablet?6.sp: 16.sp,
                                color: AppColors.black_80,
                                fontWeight: FontWeight.w600,
                                bottom: 6.h,
                                textAlign: TextAlign.start,
                              ),

                              CustomText(
                                text: "${connectedOrganizations?.description}",
                                fontSize: 12,
                                color: AppColors.black_02,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                bottom: 4.h,// Add ellipsis at the end if the text overflows.
                              ),
                            ],
                          );
                        }),

                    SizedBox(
                      height: 12.h,
                    ),
                    const Divider(
                      color: Colors.black54,
                      // height: 16.h,
                    ),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: "Mission",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      bottom: 5,
                    ),
                    CustomText(
                      text: "${administratorController.missionDetailsShowList.value.name}",
                      fontSize:isTablet?6.sp: 16.sp,
                      color: AppColors.black_80,
                      fontWeight: FontWeight.w600,
                    ),


                    const SizedBox(
                      height: 12,
                    ),

                    const Divider(
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.neutral02,
                            borderRadius: BorderRadius.circular(10),
                          ),child: CustomText(text: "Hours: ${administratorController.missionDetailsShowList.value.report?.hours}",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                        ),

                        SizedBox(
                          width: 8.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.neutral02,
                            borderRadius: BorderRadius.circular(10),
                          ),child: CustomText(text: "Millage: ${administratorController.missionDetailsShowList.value.report?.mileage}",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                        ),
                      ],
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
                        missionReportController.searchMissionReport(query);
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

                            missionReportController.searchMissionReport("");

                          }),

                    ),

                    SizedBox(
                      height: 12.h,
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
                                 textAlign: TextAlign.center,
                                 ///showCursor: false,
                                ///readOnly: true,
                                 onTap: (){
                                   ///missionReportController.eventSartSearchDate();
                                 },
                                 controller: missionReportController.eventStartSearchDateController.value,
                                 decoration: InputDecoration(
                                   hintText: "0000-00-00",
                                   hintStyle: TextStyle(fontSize: 12.0,),
                                   filled: true,
                                   fillColor:AppColors.grey_3.withOpacity(0.5),
                                   ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                   suffixIcon: missionReportController.eventStartSearchDateController.value.text.isNotEmpty
                                       ? IconButton(
                                     icon: Icon(Icons.clear, color: Colors.black54),
                                     onPressed: (){
                                       missionReportController.eventStartSearchDateController.value.clear();
                                     //  missionReportController.filterDateToDateMissionReport("","");
                                       FocusScope.of(context).unfocus();
                                     },
                                   ) : IconButton(onPressed: (){
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
                                // showCursor: false,
                               //  readOnly: true,
                                 onTap: (){

                           
                                 },
                                 controller: missionReportController.eventEndSearchDateController.value,
                                 decoration: InputDecoration(
                                   hintText: "0000-00-00",
                                   hintStyle: TextStyle(fontSize: 12.0,),
                                   filled: true,
                                   fillColor:AppColors.grey_3.withOpacity(0.5),
                                   ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                   suffixIcon: missionReportController.eventEndSearchDateController.value.text.isNotEmpty
                                       ? IconButton(
                                     icon: Icon(Icons.clear, color: Colors.black54),
                                     onPressed: (){
                                       missionReportController.eventEndSearchDateController.value.clear();
                                       FocusScope.of(context).unfocus();
                                       //missionReportController.filterDateToDateMissionReport("","");
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

                                  /*   if(missionReportController.eventStartSearchDateController.value.text=="" && missionReportController.eventEndSearchDateController.value.text==""){
                                       Toast.errorToast("please two date select!!..");
                                     }else{
                                     }*/

                                       missionReportController.filterDateToDateMissionReport(missionReportController.eventStartSearchDateController.value.text,
                                       missionReportController.eventEndSearchDateController.value.text);


                                 },
                               ),
                             ],
                           ),
                         )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    CustomText(
                      textAlign: TextAlign.start,
                      text: "Events",
                      fontSize:isTablet?6.sp: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      bottom: 8.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                   missionReportController.obx((state){
                     return  ListView.builder(
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
                                           text: "Hours: ${model?.report?.hours}",
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
                                               text: "Mileage: ${model?.report?.mileage}",
                                               maxLines: 3,
                                               fontSize:isTablet?6.sp: 14,
                                               fontWeight: FontWeight.w500,
                                               bottom: 5,
                                             ),

                                             FloatingActionButton.small(onPressed: (){

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
          ),
        ),

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

              pw.Row(
                children: [
                  pw.SizedBox(width: 10),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Farhad Hossain",
                        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "Student",
                        style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                      ),
                    ],
                  ),
                ],
              ),

            /*  pw.ListView.builder(
                  itemCount: administratorController.missionDetailsShowList.value.connectedOrganizations?.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {

                    final connectedOrganizations =administratorController.missionDetailsShowList.value.connectedOrganizations?[index];

                    return  pw.Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${connectedOrganizations?.name}",
                          fontSize:isTablet?6.sp: 16.sp,
                          color: AppColors.black_80,
                          fontWeight: FontWeight.w600,
                          bottom: 6.h,
                          textAlign: TextAlign.start,
                        ),

                        CustomText(
                          text: "${connectedOrganizations?.description}",
                          fontSize: 12,
                          color: AppColors.black_02,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          bottom: 4.h,// Add ellipsis at the end if the text overflows.
                        ),
                      ],
                    );
                  }),*/
              // Mission Horizons Foundation Section
              pw.SizedBox(height: 8),
              pw.Text(
                "Mission Horizons Foundation",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
              ),
              pw.Text(
                "Empowering communities worldwide through education, healthcare, and sustainable development initiatives.",
                style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                maxLines: 3,
                overflow: pw.TextOverflow.clip,
              ),
              pw.Divider(),

              // Organizer Section
              pw.Text(
                "Organizers",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
              ),

              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.SizedBox(width: 10),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Jamal Hasan",
                        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "Worker",
                        style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Divider(),

              pw.SizedBox(height: 12),
              pw.Row(
                children: [
                  pw.Container(
                    padding:pw.EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(Colors.white60.value),
                      borderRadius:  pw.BorderRadius.circular(10),
                    ),child:pw.Text(
                    "Hours: 4:30 Hours",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
                  ),
                  ),

                  pw.SizedBox(
                    width: 8.h,
                  ),
                  pw.Container(
                    padding:  pw.EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    decoration:  pw.BoxDecoration(
                      color:  PdfColor.fromInt(Colors.white60.value),
                      borderRadius:  pw.BorderRadius.circular(10),
                    ),child:pw.Text(
                    "Millage: 8Km",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
                  ),
                  ),
                ],
              ),

              pw.SizedBox(height: 8.h),

              pw.Container(
                padding: pw.EdgeInsets.all(8),
                height: 30.h,
               // width: 150.w,
                alignment: pw.Alignment.centerLeft,
                decoration: pw.BoxDecoration(
                   color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(15),
                ),
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                  child: pw.Text(
                    textAlign: pw.TextAlign.start,
                    "Report for February 19, 2024 - March 25, 2025",
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
              ),

              pw.SizedBox(height: 8.h),
              ///Event List Section Title
              pw.Text(
                "Events",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue),
              ),

              pw.SizedBox(height: 12.h),

              // Event List - Generate 3 events
              for (int i = 0; i < 3; i++)
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    pw.Text("Power of One",style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
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
                              "Hours 3.5",
                              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Mileage: 186.9",
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


/*class PDFGenerator extends StatelessWidget {

  Future<void> generateAndDownloadPDF() async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // Search Bar section (No direct representation in PDF, but adding text equivalent)
              pw.Row(
                children: [
                  pw.Container(
                    width: 200,
                    child: pw.Text('Search for date:'),
                  ),

                ],
              ),
              pw.SizedBox(height: 12),

              // Mission Horizons Foundation section
              pw.Text(
                "Mission Horizons Foundation",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "Empowering communities worldwide through education, healthcare, and sustainable development initiatives.",
                style: pw.TextStyle(fontSize: 12),
                maxLines: 3,
                overflow: pw.TextOverflow.clip,
              ),
              pw.Divider(),
              pw.Text("Organizer", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),

              // Organizer details (Farhad Hossain)
              pw.Row(
                children: [
                  pw.Container(
                    width: 150,
                    child: pw.Text('Farhad Hossain'),
                  ),
                  pw.Text("Student", style: pw.TextStyle(fontSize: 12)),
                ],
              ),
              pw.SizedBox(height: 12),

              // Another Organizer details (Jamal Hasan)
              pw.Row(
                children: [
                  pw.Container(
                    width: 150,
                    child: pw.Text('Jamal Hasan'),
                  ),
                  pw.Text("Worker", style: pw.TextStyle(fontSize: 12)),
                ],
              ),
              pw.Divider(),
              pw.SizedBox(height: 8),

              // Working time and mileage
              pw.Text("Working Time: 18:30 Hours  Mileage: 18:30 Hours",
                  style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 12),

              // Event List section
              pw.Text("Event List", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),

              // Event List - generate 3 events as an example
              for (int i = 0; i < 3; i++)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 20.0),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(width: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Cox’s Bazar Beach Helping People",
                            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                            maxLines: 3,
                            overflow: pw.TextOverflow.clip,
                          ),
                          pw.Row(
                            children: [
                              pw.Icon(pw.IconData(0xe0c8,), size: 20),
                              pw.Text("Cox’s Bazar, Bangladesh", style: pw.TextStyle(fontSize: 12)),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Row(
                            children: [
                              pw.SizedBox(width: 10),
                              pw.Text("Mehedi", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                              pw.Text("Leader", style: pw.TextStyle(fontSize: 14, color: PdfColors.blue)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate PDF')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await requestPermissions();
            await generateAndDownloadPDF();
          },
          child: Text('Generate PDF'),
        ),
      ),
    );
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
    } else {
      // Handle permission denial
    }
  }
}*/


