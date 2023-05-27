import 'package:flutter/material.dart';
import 'package:red_crescent/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';
import 'package:red_crescent/Widget/AppButtons.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppLoading.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import 'package:red_crescent/Widget/AppSize.dart';
import 'package:red_crescent/Widget/AppText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class HealthGuidelines extends StatefulWidget {
  const HealthGuidelines();

  @override
  State<HealthGuidelines> createState() => _HealthGuidelinesState();
}

class _HealthGuidelinesState extends State<HealthGuidelines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(title: "مركز المساعدة"),
      body: SizedBox(
        height: AppWidget.getHeight(context),
        width: AppWidget.getWidth(context),
        child: Column(children: [
          AppWidget.hSpace(30),
          AppText(
            text: "اختر حالة الطوارئ",
            fontSize: AppSize.title2TextSize,
            fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
            align: TextAlign.left,
          ),
          AppWidget.hSpace(30),

          /// list
          Expanded(child: showEmergencyList()),
          AppWidget.hSpace(20),

          ///send buttom
        ]),
      ),
    );
  }

//======================================================
  Widget showEmergencyList() {
    return ListView.builder(
  
        itemCount: AppConstants.list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: AppColor.darkBlue,
              child: ListTile(
                title: AppText(
                  text: AppConstants.list[index],
                  fontSize: AppSize.title2TextSize,
                  color: AppColor.white,
                ),
                subtitle: SingleChildScrollView(
                  child: Column(
                    children: [
                      Divider(
                        color: AppColor.white,
                      ),
                      AppWidget.hSpace(10),
                      Container(
                        // color: AppColor.black,
                        child: index == 0
                            ? RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            'الوقوف خلف الشخص المصاب لتحقيق التوازن' +
                                                "\n"),
                                    TextSpan(
                                      text:
                                          'وضع إحدى القدمين أمام الاخري قليلا لتحقيق التوازن ' +
                                              "\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            'لف الذراعين حول خصر الشخص المصاب ' +
                                                "\n"),
                                    TextSpan(
                                      text:
                                          'إمالة الشخص المصاب إلى الامام قليلا' +
                                              "\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'عمل قبضة باليد األخرى ثم وضعها فوق منطقة السرة' +
                                              "\n",
                                    ),
                                    TextSpan(
                                      text:
                                          'مسك القبضة باليد األخرى ثم توجيه ضغطة بقوة على البطن بسرعة نحو األعلى' +
                                              "\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'القيام بمعدل 6 إلى 10 ضغطات بطنية حتى يزول الجسم العالق' +
                                              "\n",
                                    ),
                                    TextSpan(
                                      text:
                                          'أما في حال كان الشخص المصاب قد فقد وعيه فقم باإلنعاش' +
                                              "\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : index == 1
                                ? RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                'استرخ على السرير وقم بإراحة عضالت الرقبة والكتفين' +
                                                    "\n"),
                                        TextSpan(
                                          text:
                                              'قم بضم شفتيك جيدا وتنفس بعمق من األنف لمدة ثانيتين' +
                                                  "\n",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                'قم بإخراج الهواء من شفتيك المضمومتين لمدة 4 ثواني' +
                                                    "\n"),
                                        TextSpan(
                                          text:
                                              'ستمر على هذا التمرين لمدة عشر دقائق' +
                                                  "\n",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                : index == 2
                                    ? RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'وفي حال رأيت شخصا آخر يفقد الوعي'
                                                    " "),
                                            TextSpan(
                                              text:
                                                  'اجعله مستلقيا على ظهره . وإذا لم تكن به إصابات وكان يتنفس ، وارفع رجليه فوق مستوى القلب نحو 12 بوصة' +
                                                      ".",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                                text:
                                                    'فك الاحزمة أو الياقات أو غيرها من الملابس الضيقة . وللحد من فرص التعرض لإلغماء مرة اخرى ، لا تجعله ينهض بعد وقت قصير . فإذا لم يستعيد الشخص وعيه في غضون دقيقة واحدة ، فاتصل بالرقم 911 أو رقم الطوارئ المحلي . تحقق من التنفس . إذا لم يكن الشخص يتنفس ، فابدأ في إجراء الانعاش القلبي الرئوي . اتصل على الرقم 911 أو أي رقم طوارئ محلي . استمر في إجراء الانعاش القلبي الرئوي حتى تصل المساعدة أو يستعيد الشخص التنفس . وإذا كان الشخص مصابا جراء السقوط الذي يصاحب الاغماء ، فتعامل مع الصدمات أو الكدمات أو الجروح على النحو المناسب . سيطر على النزيف بالضغط مباشرة على مكانه.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )
                                    : index == 3
                                        ? 
                                        RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                   style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                    text:
                                                        'حماية الشخص المصاب من الضرر' +
                                                            "\n"),
                                                TextSpan(
                                                  text:
                                                      'انزع المجوهرات واألحزمة وغيرها ، خاصة حول المناطق المحترقة على سبيل المثال الرقبة' +
                                                          "\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                   style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                    text:
                                                        ' أخذ مسكن الالم إذا لزم الامر وذلك لتخفيف الالم' +
                                                            "\n"),
                                                TextSpan(
                                                  text:
                                                      'تغطية منطقة الحرق باستخدام ضمادة رطبة أو قطعة قماش نظيفة باردة     ' +
                                                          "\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              
                                                TextSpan(
                                                  text:
                                                      'تغطية الفقاعات المفتوحة بضمادة جافة ومعقمة ' +
                                                          "\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        : index == 4
                                            ? RichText(
                                                text: const TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            'الوقوف خلف الشخص المصاب لتحقيق التوازن' +
                                                                "\n"),
                                                    TextSpan(
                                                      text:
                                                          'وضع إحدى القدمين أمام الاخري قليلا لتحقيق التوازن ' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            'لف الذراعين حول خصر الشخص المصاب ' +
                                                                "\n"),
                                                    TextSpan(
                                                      text:
                                                          'إمالة الشخص المصاب إلى الامام قليلا' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'عمل قبضة باليد األخرى ثم وضعها فوق منطقة السرة' +
                                                              "\n",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'مسك القبضة باليد األخرى ثم توجيه ضغطة بقوة على البطن بسرعة نحو األعلى' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'القيام بمعدل 6 إلى 10 ضغطات بطنية حتى يزول الجسم العالق' +
                                                              "\n",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'أما في حال كان الشخص المصاب قد فقد وعيه فقم باإلنعاش' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : RichText(
                                                text: const TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            'الوقوف خلف الشخص المصاب لتحقيق التوازن' +
                                                                "\n"),
                                                    TextSpan(
                                                      text:
                                                          'وضع إحدى القدمين أمام الاخري قليلا لتحقيق التوازن ' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            'لف الذراعين حول خصر الشخص المصاب ' +
                                                                "\n"),
                                                    TextSpan(
                                                      text:
                                                          'إمالة الشخص المصاب إلى الامام قليلا' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'عمل قبضة باليد األخرى ثم وضعها فوق منطقة السرة' +
                                                              "\n",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'مسك القبضة باليد األخرى ثم توجيه ضغطة بقوة على البطن بسرعة نحو األعلى' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'القيام بمعدل 6 إلى 10 ضغطات بطنية حتى يزول الجسم العالق' +
                                                              "\n",
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'أما في حال كان الشخص المصاب قد فقد وعيه فقم باإلنعاش' +
                                                              "\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
