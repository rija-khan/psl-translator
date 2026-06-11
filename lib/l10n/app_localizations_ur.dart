// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'پی ایس ایل مترجم';

  @override
  String get language => 'زبان';

  @override
  String get languageEnglish => 'انگریزی';

  @override
  String get languageUrdu => 'اردو';

  @override
  String get languageSindhi => 'سندھی';

  @override
  String get languagePunjabi => 'پنجابی';

  @override
  String get languagePashto => 'پشتو';

  @override
  String get home => 'ہوم';

  @override
  String get speak => 'بولیں';

  @override
  String get sign => 'اشارہ';

  @override
  String get learn => 'سیکھیں';

  @override
  String get practice => 'مشق';

  @override
  String get settings => 'ترتیبات';

  @override
  String get homeTitle => 'پاکستانی اشاروں کی زبان';

  @override
  String get homeSubtitle =>
      'آواز کا ترجمہ کریں، اشارے پہچانیں، اور ویڈیو اسباق سے سیکھیں۔';

  @override
  String get homeTagline =>
      'پاکستانی اشاروں کی زبان کا استعمال کرتے ہوئے سیکھیں، مشق کریں اور بات چیت کریں';

  @override
  String get learningProgress => 'سیکھنے کی پیش رفت';

  @override
  String get yourLearningProgress => 'آپ کی سیکھنے کی پیش رفت';

  @override
  String get completed => 'مکمل';

  @override
  String lessonsCompleted(int count, int total) {
    return '$count / $total اسباق مکمل';
  }

  @override
  String get weeklyGoal => 'ہفتہ وار ہدف';

  @override
  String get progressMessage =>
      'اس ہفتے کے اسباق مکمل کرنے کے لیے مشق جاری رکھیں۔';

  @override
  String get featuredVideo => 'نمایاں اشارہ ویڈیو';

  @override
  String get quickActions => 'فوری اعمال';

  @override
  String get speakMode => 'اسپیک موڈ';

  @override
  String get speakModeSubtitle => 'آواز سے اشارے میں\nترجمہ';

  @override
  String get signMode => 'سائن موڈ';

  @override
  String get signModeSubtitle => 'اشارے سے آواز میں\nترجمہ';

  @override
  String get learnMode => 'سیکھیں';

  @override
  String get learnModeSubtitle => 'اشاروں کی زبان پر عبور حاصل کریں';

  @override
  String get quickPractice => 'فوری مشق';

  @override
  String get quickPracticeSubtitle => '5 منٹ کا روزانہ چیلنج';

  @override
  String get howToUse => 'اس ایپ کو کیسے استعمال کریں';

  @override
  String get instructionSpeak =>
      'آواز کو PSL میں تبدیل کرنے کے لیے اسپیک موڈ استعمال کریں';

  @override
  String get instructionSign =>
      'اشاروں کو آواز میں تبدیل کرنے کے لیے سائن موڈ استعمال کریں';

  @override
  String get instructionLearn => 'روانی بڑھانے کے لیے اسباق کی مشق کریں';

  @override
  String get speakAction => 'آواز سے اشارے';

  @override
  String get signAction => 'اشارے پہچانیں';

  @override
  String get learnAction => 'ویڈیو اسباق';

  @override
  String get practiceAction => 'روانی بڑھائیں';

  @override
  String get speakTitle => 'بول کر اشارہ بنائیں';

  @override
  String get speakSubtitle =>
      'بولی یا لکھی ہوئی زبان کو اشاروں کی ویڈیو میں بدلیں۔';

  @override
  String get yourTranslator => 'آپ کا مترجم';

  @override
  String get yourTranslatorSubtitle =>
      'بولیں اور مجھے اشاروں کی زبان میں ترجمہ کرتے ہوئے دیکھیں';

  @override
  String get howToUseSpeak => 'استعمال کا طریقہ';

  @override
  String get howToUseSpeakBody =>
      'اپنی آواز ریکارڈ کرنے کے لیے مائیکروفون بٹن کو تھپتھپائیں اور تھامیں۔ اشاروں کی زبان میں ترجمہ کرنے کے لیے چھوڑ دیں۔';

  @override
  String get holdToSpeak => 'بولنے کے لیے پکڑیں، ترجمہ کے لیے چھوڑ دیں';

  @override
  String get translationResult => 'ترجمہ کا نتیجہ';

  @override
  String get speechTranscribedHere =>
      'آپ کی تقریر یہاں نقل اور ترجمہ کی جائے گی...';

  @override
  String get slow => 'آہستہ';

  @override
  String get normal => 'نارمل';

  @override
  String get fast => 'تیز';

  @override
  String get inputText => 'متن درج کریں';

  @override
  String get recordVoice => 'آواز ریکارڈ کریں';

  @override
  String get stopRecording => 'ریکارڈنگ روکیں';

  @override
  String get convert => 'تبدیل کریں';

  @override
  String get generatedText => 'تیار شدہ متن';

  @override
  String get generatedPlaceholder => 'ترجمہ یہاں ظاہر ہوگا۔';

  @override
  String get recordingPlaceholder => 'آواز سنی جا رہی ہے...';

  @override
  String get signOutput => 'اشاروں کا نتیجہ';

  @override
  String get signTitle => 'اشاروں کی شناخت';

  @override
  String get signSubtitle =>
      'شناخت کے لیے native کیمرہ استعمال کریں یا مثال ویڈیوز دیکھیں۔';

  @override
  String get signToAudioTitle => 'اشارے سے آڈیو ترجمہ';

  @override
  String get signToAudioBody =>
      'اپنے آپ کو کیمرے کے فریم میں رکھیں اور اشارہ کرنا شروع کریں۔ مترجم آپ کے اشاروں کو آڈیو میں تبدیل کر دے گا۔';

  @override
  String get positionYourselfHere => 'اپنے آپ کو یہاں رکھیں';

  @override
  String get cameraReadyStart => 'کیمرہ تیار ہے - اشارہ کرنا شروع کریں';

  @override
  String get startSigning => 'اشارہ کرنا شروع کریں';

  @override
  String get stopAndTranslate => 'روکیں اور\nترجمہ کریں';

  @override
  String get signTranslatedHere =>
      'آپ کی اشاروں کی زبان کا آڈیو میں یہاں ترجمہ کیا جائے گا...';

  @override
  String get cameraMode => 'کیمرہ موڈ';

  @override
  String get videoMode => 'ویڈیو موڈ';

  @override
  String get cameraReady => 'کیمرہ پری ویو یہاں ظاہر ہوگا۔';

  @override
  String get cameraPermissionDenied => 'کیمرہ اجازت نہیں دی گئی۔';

  @override
  String get cameraUnavailable => 'اس ڈیوائس پر کیمرہ دستیاب نہیں۔';

  @override
  String get detectedSignPlaceholder => 'شناخت شدہ اشارہ یہاں ظاہر ہوگا';

  @override
  String get startCamera => 'کیمرہ شروع کریں';

  @override
  String get stopCamera => 'کیمرہ روکیں';

  @override
  String get exampleVideo => 'مثالی اشارہ ویڈیو';

  @override
  String get learnTitle => 'اشاروں کی زبان سیکھیں';

  @override
  String get learnSubtitle =>
      'زمروں کو دیکھیں اور responsive ویڈیو اسباق سے مشق کریں۔';

  @override
  String get masterSignLanguage => 'اشاروں کی زبان پر عبور حاصل کریں';

  @override
  String get startLearningToday => 'آج ہی اپنا سیکھنے کا سفر شروع کریں';

  @override
  String get yourProgress => 'آپ کی پیش رفت';

  @override
  String get overallCompletion => 'مجموعی تکمیل';

  @override
  String completedCount(int done, int total) {
    return 'مکمل : $done/$total';
  }

  @override
  String timeSpent(String time) {
    return 'صرف کیا گیا وقت : $time';
  }

  @override
  String get lessonsInCategory => 'اس زمرے کے اسباق';

  @override
  String lessonProgress(int current, int total) {
    return 'Lesson $current of $total';
  }

  @override
  String percentComplete(int percent) {
    return '$percent% مکمل';
  }

  @override
  String get previous => 'پچھلا';

  @override
  String get next => 'اگلا';

  @override
  String get done => 'ہو گیا';

  @override
  String get searchLessons => 'اسباق تلاش کریں';

  @override
  String get categories => 'زمرے';

  @override
  String get all => 'سب';

  @override
  String get lesson => 'سبق';

  @override
  String get difficulty => 'درجہ';

  @override
  String get category => 'زمرہ';

  @override
  String get previousLesson => 'پچھلا سبق';

  @override
  String get nextLesson => 'اگلا سبق';

  @override
  String get beginner => 'ابتدائی';

  @override
  String get intermediate => 'درمیانی';

  @override
  String get categoryBasics => 'بنیادی باتیں';

  @override
  String get categoryDailyLife => 'روزمرہ زندگی';

  @override
  String get categoryEducation => 'تعلیم';

  @override
  String get categoryPublicServices => 'عوامی خدمات';

  @override
  String get catBasicGreetings => 'بنیادی سلام دعا';

  @override
  String get catBasicGreetingsDuration => '40 منٹ';

  @override
  String get catPslAlphabet => 'پی ایس ایل حروف تہجی';

  @override
  String get catPslAlphabetDuration => '2 گھنٹے';

  @override
  String get catFamilyPeople => 'خاندان اور لوگ';

  @override
  String get catFamilyPeopleDuration => '1 گھنٹہ';

  @override
  String get catColorsShapes => 'رنگ اور اشکال';

  @override
  String get catColorsShapesDuration => '1.5 گھنٹے';

  @override
  String get catNumbers => 'نمبر';

  @override
  String get catNumbersDuration => '1 گھنٹہ';

  @override
  String get catSchoolEducation => 'اسکول اور تعلیم';

  @override
  String get catSchoolEducationDuration => '2 گھنٹے';

  @override
  String get lessonHelloHi => 'ہیلو اور ہائے';

  @override
  String get lessonHelloHiDesc => 'ہیلو اور ہائے کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonThankYou => 'شکریہ';

  @override
  String get lessonThankYouDesc => 'شکریہ کا اشارہ سیکھیں۔';

  @override
  String get lessonPlease => 'براہ کرم';

  @override
  String get lessonPleaseDesc => 'براہ کرم کا اشارہ سیکھیں۔';

  @override
  String get lessonSorry => 'معذرت';

  @override
  String get lessonSorryDesc => 'معذرت کا اشارہ سیکھیں۔';

  @override
  String get lessonGoodMorning => 'صبح بخیر';

  @override
  String get lessonGoodMorningDesc => 'صبح بخیر کا اشارہ سیکھیں۔';

  @override
  String get lessonGoodNight => 'شب بخیر';

  @override
  String get lessonGoodNightDesc => 'شب بخیر کا اشارہ سیکھیں۔';

  @override
  String get lessonHowAreYou => 'آپ کیسے ہیں؟';

  @override
  String get lessonHowAreYouDesc => 'اشاروں میں \'آپ کیسے ہیں\' پوچھنا سیکھیں۔';

  @override
  String get lessonGoodbye => 'خدا حافظ';

  @override
  String get lessonGoodbyeDesc => 'خدا حافظ کا اشارہ سیکھیں۔';

  @override
  String get lessonMother => 'ماں';

  @override
  String get lessonMotherDesc => 'ماں کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonFather => 'باپ';

  @override
  String get lessonFatherDesc => 'باپ کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonSister => 'بہن';

  @override
  String get lessonSisterDesc => 'بہن کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonBrother => 'بھائی';

  @override
  String get lessonBrotherDesc => 'بھائی کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonRed => 'سرخ';

  @override
  String get lessonRedDesc => 'سرخ کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonBlue => 'نیلا';

  @override
  String get lessonBlueDesc => 'نیلے کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonGreen => 'سبز';

  @override
  String get lessonGreenDesc => 'سبز کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonCircle => 'دائرہ';

  @override
  String get lessonCircleDesc => 'دائرے کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonSquare => 'مربع';

  @override
  String get lessonSquareDesc => 'مربع کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonTeacher => 'استاد';

  @override
  String get lessonTeacherDesc => 'استاد کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonStudent => 'طالب علم';

  @override
  String get lessonStudentDesc => 'طالب علم کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonBook => 'کتاب';

  @override
  String get lessonBookDesc => 'کتاب کے لیے اشارہ سیکھیں۔';

  @override
  String get lessonLetterPrefix => 'حرف';

  @override
  String get lessonLetterDescPrefix => 'اس حرف کے لیے اشارہ سیکھیں';

  @override
  String get lessonNumberPrefix => 'نمبر';

  @override
  String get lessonNumberDescPrefix => 'اس کے لیے اشارہ سیکھیں';

  @override
  String get lessonGreetingsTitle => 'سلام دعا';

  @override
  String get lessonGreetingsDescription =>
      'ہیلو، شکریہ، اور عام روزمرہ سلام سیکھیں۔';

  @override
  String get lessonFamilyTitle => 'خاندانی اشارے';

  @override
  String get lessonFamilyDescription =>
      'والدین، بہن بھائی، اور رشتہ داروں کے اشاروں کی مشق کریں۔';

  @override
  String get lessonNumbersTitle => 'نمبر 1 تا 10';

  @override
  String get lessonNumbersDescription =>
      'بنیادی گنتی کے اشاروں میں اعتماد پیدا کریں۔';

  @override
  String get lessonSchoolTitle => 'اسکول الفاظ';

  @override
  String get lessonSchoolDescription =>
      'کلاس روم، استاد، کتاب، اور پڑھائی کے اشارے سیکھیں۔';

  @override
  String get lessonEmergencyTitle => 'ہنگامی مدد';

  @override
  String get lessonEmergencyDescription =>
      'فوری مدد، حفاظت، اور دیکھ بھال کے اشاروں کی مشق کریں۔';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get settingsLabel => 'ترتیبات';

  @override
  String get settingsDefaultAudioLanguage => 'ڈیفالٹ آڈیو زبان';

  @override
  String get settingsDefaultContentLanguage => 'ڈیفالٹ مواد کی زبان';

  @override
  String get settingsSignLanguageType => 'اشاروں کی زبان کی قسم';

  @override
  String get settingsSignLanguageValue => 'پاکستانی اشاروں کی زبان';

  @override
  String get settingsAutoPlayAudio => 'آٹو پلے آڈیو';

  @override
  String get settingsOn => 'آن';

  @override
  String get settingsOff => 'آف';

  @override
  String get settingsAccount => 'اکاؤنٹ';

  @override
  String get settingsLogout => 'لاگ آؤٹ';

  @override
  String get settingsLogoutSubtitle => 'مقامی لاگ ان ٹوکن صاف کریں۔';

  @override
  String get settingsDeleteAccount => 'اکاؤنٹ حذف کریں';

  @override
  String get settingsDeleteSubtitle => 'اس اکاؤنٹ کو مقامی اسٹوریج سے ہٹا دیں۔';

  @override
  String get settingsDeleteTitle => 'اکاؤنٹ حذف کریں؟';

  @override
  String get settingsDeleteBody =>
      'یہ موجودہ مقامی اکاؤنٹ کو ہٹاتا ہے اور آپ کا لاگ ان ٹوکن صاف کرتا ہے۔';

  @override
  String get settingsCancel => 'منسوخ کریں';

  @override
  String get settingsDelete => 'حذف کریں';

  @override
  String get videoError => 'ویڈیو لوڈ نہیں ہو سکی۔';

  @override
  String get fourMin => '4 منٹ';

  @override
  String get loginFailed => 'لاگ ان ناکام ہو گیا۔';

  @override
  String get accountCreated => 'اکاؤنٹ بن گیا۔ براہ کرم لاگ ان کریں۔';

  @override
  String get welcomeBack => 'خوش آمدید';

  @override
  String get loginToContinue =>
      'PSL Translator استعمال کرنے کے لیے لاگ ان کریں۔';

  @override
  String get email => 'ای میل';

  @override
  String get emailRequired => 'ای میل درکار ہے۔';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get passwordRequired => 'پاس ورڈ درکار ہے۔';

  @override
  String get login => 'لاگ ان کریں';

  @override
  String get createNewAccount => 'نیا اکاؤنٹ بنائیں';

  @override
  String get register => 'رجسٹر کریں';

  @override
  String get createAccount => 'اکاؤنٹ بنائیں';

  @override
  String get accountStoredLocally =>
      'آپ کا اکاؤنٹ اس ڈیوائس پر مقامی طور پر محفوظ ہے۔';

  @override
  String get username => 'صارف نام';

  @override
  String get usernameRequired => 'صارف کا نام درکار ہے۔';

  @override
  String get invalidEmail => 'درست ای میل درج کریں۔';

  @override
  String get passwordLength => 'پاس ورڈ کم از کم 6 ہندسوں کا ہونا چاہیے۔';

  @override
  String get registrationFailed => 'رجسٹریشن ناکام ہو گئی۔';
}
