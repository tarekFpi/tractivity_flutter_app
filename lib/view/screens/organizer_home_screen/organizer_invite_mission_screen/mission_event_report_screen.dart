
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';

class MissionEventReportScreen extends StatefulWidget {
  const MissionEventReportScreen({super.key});

  @override
  State<MissionEventReportScreen> createState() => _MissionEventReportScreenState();
}

class _MissionEventReportScreenState extends State<MissionEventReportScreen> {

  final _searchController =TextEditingController();

  final  organizerController = Get.find<OrganizerController>();

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

                    SizedBox(
                      height: 8.h,
                    ),
                    CustomText(
                      text: "Mission Horizons Foundation",
                      fontSize:isTablet?6.sp: 16.sp,
                      color: AppColors.black_80,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),

                    CustomText(
                      text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                      fontSize: 12,
                      color: AppColors.black_02,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      bottom: 4.h,// Add ellipsis at the end if the text overflows.
                    ),

                    const Divider(
                      color: Colors.black54,
                      // height: 16.h,
                    ),

                    CustomText(
                      textAlign: TextAlign.start,
                      text: "Organizers",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      bottom: 8.h,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Row(
                              children: [

                           /*     CustomNetworkImage(
                                  imageUrl: AppConstants.profileImage,
                                  height:isTablet?64.h: 60.h,
                                  width:isTablet?64.w: 60.w,
                                  boxShape: BoxShape.circle,
                                ),*/
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Farhad Hossain",
                                      fontSize:isTablet?6.sp:12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    CustomText(
                                      text: "Student",
                                      fontSize:isTablet?6.sp: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_80,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Row(
                              children: [

                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Jamal Hasan",
                                      fontSize:isTablet?6.sp:12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    CustomText(
                                      text: "worker",
                                      fontSize:isTablet?6.sp: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_80,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
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
                          ),child: CustomText(text: "Hours: 4:30 Hours",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                        ),

                        SizedBox(
                          width: 8.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.neutral02,
                            borderRadius: BorderRadius.circular(10),
                          ),child: CustomText(text: "Millage: 8Km",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'search event..',
                        hintStyle: TextStyle(fontSize: 14.0),
                        filled: true,
                        fillColor:AppColors.grey_3.withOpacity(0.5),
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.black54),
                          onPressed: (){},
                        )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(4),
                      ),
                      onChanged: (query) {
                        // Handle search query change (e.g., filtering data)
                      },
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
                                 showCursor: false,
                                 readOnly: true,
                                 onTap: (){
                                   organizerController.eventSartSearchDate();
                           
                                 },
                                 controller: organizerController.eventStartSearchDateController.value,
                                 decoration: InputDecoration(
                                   hintText: "00/00/0000",
                                   hintStyle: TextStyle(fontSize: 12.0,),
                                   filled: true,
                                   fillColor:AppColors.grey_3.withOpacity(0.5),
                                   ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                   suffixIcon: organizerController.eventStartSearchDateController.value.text.isNotEmpty
                                       ? IconButton(
                                     icon: Icon(Icons.clear, color: Colors.black54),
                                     onPressed: (){
                                       organizerController.eventStartSearchDateController.value.clear();
                                       FocusScope.of(context).unfocus();
                                     },
                                   ) : IconButton(onPressed: (){
                                     organizerController.eventSartSearchDate();
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
                                   organizerController.eventSartSearchDate();
                           
                                 },
                                 controller: organizerController.eventEndSearchDateController.value,
                                 decoration: InputDecoration(
                                   hintText: "00/00/0000",
                                   hintStyle: TextStyle(fontSize: 12.0,),
                                   filled: true,
                                   fillColor:AppColors.grey_3.withOpacity(0.5),
                                   ///prefixIcon: Icon(Icons.search, color: Colors.black54),
                                   suffixIcon: organizerController.eventEndSearchDateController.value.text.isNotEmpty
                                       ? IconButton(
                                     icon: Icon(Icons.clear, color: Colors.black54),
                                     onPressed: (){
                                       organizerController.eventEndSearchDateController.value.clear();
                                       FocusScope.of(context).unfocus();
                                     },
                                   ) : IconButton(onPressed: (){
                                     organizerController.eventEndSearchDate();
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
                    Column(children: List.generate(3, (index) {
                          return Card(
                            color: Colors.white,
                             elevation: 0.2,
                            child: ExpansionTile(
                              shape: Border(),
                              title: Text("Helping Hands",style: TextStyle(fontSize: isTablet?9.sp:14.sp),),

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
                                          text: "Hours 3.5 ",
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
                                              text: "Mileage: 186.9 ",
                                              maxLines: 3,
                                              fontSize:isTablet?6.sp: 14,
                                              fontWeight: FontWeight.w500,
                                              bottom: 5,
                                            ),

                                            FloatingActionButton.small(onPressed: (){},
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
                        })
                    )
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


