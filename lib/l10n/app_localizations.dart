import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pa'),
    Locale('ps'),
    Locale('sd'),
    Locale('ur')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PSL Translator'**
  String get appName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get languageUrdu;

  /// No description provided for @languageSindhi.
  ///
  /// In en, this message translates to:
  /// **'Sindhi'**
  String get languageSindhi;

  /// No description provided for @languagePunjabi.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get languagePunjabi;

  /// No description provided for @languagePashto.
  ///
  /// In en, this message translates to:
  /// **'Pashto'**
  String get languagePashto;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @speak.
  ///
  /// In en, this message translates to:
  /// **'Speak'**
  String get speak;

  /// No description provided for @sign.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get sign;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learn;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pakistani Sign Language'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Translate speech, recognize signs, and learn through guided video lessons.'**
  String get homeSubtitle;

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'Learn, practice and communicate using Pakistani Sign Language'**
  String get homeTagline;

  /// No description provided for @learningProgress.
  ///
  /// In en, this message translates to:
  /// **'Learning Progress'**
  String get learningProgress;

  /// No description provided for @yourLearningProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Progress'**
  String get yourLearningProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @lessonsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} / {total} Lessons completed'**
  String lessonsCompleted(int count, int total);

  /// No description provided for @weeklyGoal.
  ///
  /// In en, this message translates to:
  /// **'Weekly goal'**
  String get weeklyGoal;

  /// No description provided for @progressMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing to complete this week\'s lessons.'**
  String get progressMessage;

  /// No description provided for @featuredVideo.
  ///
  /// In en, this message translates to:
  /// **'Featured Sign Video'**
  String get featuredVideo;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @speakMode.
  ///
  /// In en, this message translates to:
  /// **'Speak Mode'**
  String get speakMode;

  /// No description provided for @speakModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speech to sign\ntranslation'**
  String get speakModeSubtitle;

  /// No description provided for @signMode.
  ///
  /// In en, this message translates to:
  /// **'Sign Mode'**
  String get signMode;

  /// No description provided for @signModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign to speech\ntranslation'**
  String get signModeSubtitle;

  /// No description provided for @learnMode.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learnMode;

  /// No description provided for @learnModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Master sign language'**
  String get learnModeSubtitle;

  /// No description provided for @quickPractice.
  ///
  /// In en, this message translates to:
  /// **'Quick Practice'**
  String get quickPractice;

  /// No description provided for @quickPracticeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'5-min daily challenge'**
  String get quickPracticeSubtitle;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use this app'**
  String get howToUse;

  /// No description provided for @instructionSpeak.
  ///
  /// In en, this message translates to:
  /// **'Use Speak mode to convert voice to PSL'**
  String get instructionSpeak;

  /// No description provided for @instructionSign.
  ///
  /// In en, this message translates to:
  /// **'Use Sign mode to convert signs to speech'**
  String get instructionSign;

  /// No description provided for @instructionLearn.
  ///
  /// In en, this message translates to:
  /// **'Practice lessons to improve fluency'**
  String get instructionLearn;

  /// No description provided for @speakAction.
  ///
  /// In en, this message translates to:
  /// **'Voice to signs'**
  String get speakAction;

  /// No description provided for @signAction.
  ///
  /// In en, this message translates to:
  /// **'Recognize signs'**
  String get signAction;

  /// No description provided for @learnAction.
  ///
  /// In en, this message translates to:
  /// **'Video lessons'**
  String get learnAction;

  /// No description provided for @practiceAction.
  ///
  /// In en, this message translates to:
  /// **'Build fluency'**
  String get practiceAction;

  /// No description provided for @speakTitle.
  ///
  /// In en, this message translates to:
  /// **'Speak to Sign'**
  String get speakTitle;

  /// No description provided for @speakSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convert spoken or typed language into sign language video output.'**
  String get speakSubtitle;

  /// No description provided for @yourTranslator.
  ///
  /// In en, this message translates to:
  /// **'Your Translator'**
  String get yourTranslator;

  /// No description provided for @yourTranslatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speak and watch me translate to sign language'**
  String get yourTranslatorSubtitle;

  /// No description provided for @howToUseSpeak.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUseSpeak;

  /// No description provided for @howToUseSpeakBody.
  ///
  /// In en, this message translates to:
  /// **'Tap and hold the microphone button to record your speech. Release to translate into sign language.'**
  String get howToUseSpeakBody;

  /// No description provided for @holdToSpeak.
  ///
  /// In en, this message translates to:
  /// **'Hold to speak, release to translate'**
  String get holdToSpeak;

  /// No description provided for @translationResult.
  ///
  /// In en, this message translates to:
  /// **'Translation Result'**
  String get translationResult;

  /// No description provided for @speechTranscribedHere.
  ///
  /// In en, this message translates to:
  /// **'Your speech will be transcribed and translated here...'**
  String get speechTranscribedHere;

  /// No description provided for @slow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slow;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @inputText.
  ///
  /// In en, this message translates to:
  /// **'Input text'**
  String get inputText;

  /// No description provided for @recordVoice.
  ///
  /// In en, this message translates to:
  /// **'Record Voice'**
  String get recordVoice;

  /// No description provided for @stopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop Recording'**
  String get stopRecording;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @generatedText.
  ///
  /// In en, this message translates to:
  /// **'Generated text'**
  String get generatedText;

  /// No description provided for @generatedPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Generated translation will appear here.'**
  String get generatedPlaceholder;

  /// No description provided for @recordingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Listening for speech...'**
  String get recordingPlaceholder;

  /// No description provided for @signOutput.
  ///
  /// In en, this message translates to:
  /// **'Sign language output'**
  String get signOutput;

  /// No description provided for @signTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Recognition'**
  String get signTitle;

  /// No description provided for @signSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the native camera for recognition or watch example videos.'**
  String get signSubtitle;

  /// No description provided for @signToAudioTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign to Audio Translation'**
  String get signToAudioTitle;

  /// No description provided for @signToAudioBody.
  ///
  /// In en, this message translates to:
  /// **'Position yourself in the camera frame and start signing. The translator will convert your signs to audio.'**
  String get signToAudioBody;

  /// No description provided for @positionYourselfHere.
  ///
  /// In en, this message translates to:
  /// **'Position yourself here'**
  String get positionYourselfHere;

  /// No description provided for @cameraReadyStart.
  ///
  /// In en, this message translates to:
  /// **'Camera ready - Start signing'**
  String get cameraReadyStart;

  /// No description provided for @startSigning.
  ///
  /// In en, this message translates to:
  /// **'Start Signing'**
  String get startSigning;

  /// No description provided for @stopAndTranslate.
  ///
  /// In en, this message translates to:
  /// **'Stop &\nTranslate'**
  String get stopAndTranslate;

  /// No description provided for @signTranslatedHere.
  ///
  /// In en, this message translates to:
  /// **'Your sign language will be translated to audio here...'**
  String get signTranslatedHere;

  /// No description provided for @cameraMode.
  ///
  /// In en, this message translates to:
  /// **'Camera Mode'**
  String get cameraMode;

  /// No description provided for @videoMode.
  ///
  /// In en, this message translates to:
  /// **'Video Mode'**
  String get videoMode;

  /// No description provided for @cameraReady.
  ///
  /// In en, this message translates to:
  /// **'Camera preview will appear here.'**
  String get cameraReady;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission was denied.'**
  String get cameraPermissionDenied;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera is unavailable on this device.'**
  String get cameraUnavailable;

  /// No description provided for @detectedSignPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Detected Sign Will Appear Here'**
  String get detectedSignPlaceholder;

  /// No description provided for @startCamera.
  ///
  /// In en, this message translates to:
  /// **'Start Camera'**
  String get startCamera;

  /// No description provided for @stopCamera.
  ///
  /// In en, this message translates to:
  /// **'Stop Camera'**
  String get stopCamera;

  /// No description provided for @exampleVideo.
  ///
  /// In en, this message translates to:
  /// **'Example sign video'**
  String get exampleVideo;

  /// No description provided for @learnTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Sign Language'**
  String get learnTitle;

  /// No description provided for @learnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse categories and practice signs through responsive video lessons.'**
  String get learnSubtitle;

  /// No description provided for @masterSignLanguage.
  ///
  /// In en, this message translates to:
  /// **'Master Sign Language'**
  String get masterSignLanguage;

  /// No description provided for @startLearningToday.
  ///
  /// In en, this message translates to:
  /// **'Start your learning journey today'**
  String get startLearningToday;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @overallCompletion.
  ///
  /// In en, this message translates to:
  /// **'Overall Completion'**
  String get overallCompletion;

  /// No description provided for @completedCount.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED : {done}/{total}'**
  String completedCount(int done, int total);

  /// No description provided for @timeSpent.
  ///
  /// In en, this message translates to:
  /// **'TIME SPENT : {time}'**
  String timeSpent(String time);

  /// No description provided for @lessonsInCategory.
  ///
  /// In en, this message translates to:
  /// **'Lessons in this Category'**
  String get lessonsInCategory;

  /// No description provided for @lessonProgress.
  ///
  /// In en, this message translates to:
  /// **'Lesson {current} of {total}'**
  String lessonProgress(int current, int total);

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @searchLessons.
  ///
  /// In en, this message translates to:
  /// **'Search lessons'**
  String get searchLessons;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @lesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get lesson;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @previousLesson.
  ///
  /// In en, this message translates to:
  /// **'Previous Lesson'**
  String get previousLesson;

  /// No description provided for @nextLesson.
  ///
  /// In en, this message translates to:
  /// **'Next Lesson'**
  String get nextLesson;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @categoryBasics.
  ///
  /// In en, this message translates to:
  /// **'Basics'**
  String get categoryBasics;

  /// No description provided for @categoryDailyLife.
  ///
  /// In en, this message translates to:
  /// **'Daily Life'**
  String get categoryDailyLife;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryPublicServices.
  ///
  /// In en, this message translates to:
  /// **'Public Services'**
  String get categoryPublicServices;

  /// No description provided for @catBasicGreetings.
  ///
  /// In en, this message translates to:
  /// **'Basic Greetings'**
  String get catBasicGreetings;

  /// No description provided for @catBasicGreetingsDuration.
  ///
  /// In en, this message translates to:
  /// **'40 min'**
  String get catBasicGreetingsDuration;

  /// No description provided for @catPslAlphabet.
  ///
  /// In en, this message translates to:
  /// **'PSL Alphabet'**
  String get catPslAlphabet;

  /// No description provided for @catPslAlphabetDuration.
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get catPslAlphabetDuration;

  /// No description provided for @catFamilyPeople.
  ///
  /// In en, this message translates to:
  /// **'Family & People'**
  String get catFamilyPeople;

  /// No description provided for @catFamilyPeopleDuration.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get catFamilyPeopleDuration;

  /// No description provided for @catColorsShapes.
  ///
  /// In en, this message translates to:
  /// **'Colors & Shapes'**
  String get catColorsShapes;

  /// No description provided for @catColorsShapesDuration.
  ///
  /// In en, this message translates to:
  /// **'1.5 hours'**
  String get catColorsShapesDuration;

  /// No description provided for @catNumbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get catNumbers;

  /// No description provided for @catNumbersDuration.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get catNumbersDuration;

  /// No description provided for @catSchoolEducation.
  ///
  /// In en, this message translates to:
  /// **'School & Education'**
  String get catSchoolEducation;

  /// No description provided for @catSchoolEducationDuration.
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get catSchoolEducationDuration;

  /// No description provided for @lessonHelloHi.
  ///
  /// In en, this message translates to:
  /// **'Hello & Hi'**
  String get lessonHelloHi;

  /// No description provided for @lessonHelloHiDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for hello and hi.'**
  String get lessonHelloHiDesc;

  /// No description provided for @lessonThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get lessonThankYou;

  /// No description provided for @lessonThankYouDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for thank you.'**
  String get lessonThankYouDesc;

  /// No description provided for @lessonPlease.
  ///
  /// In en, this message translates to:
  /// **'Please'**
  String get lessonPlease;

  /// No description provided for @lessonPleaseDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for please.'**
  String get lessonPleaseDesc;

  /// No description provided for @lessonSorry.
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get lessonSorry;

  /// No description provided for @lessonSorryDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for sorry.'**
  String get lessonSorryDesc;

  /// No description provided for @lessonGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get lessonGoodMorning;

  /// No description provided for @lessonGoodMorningDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for good morning.'**
  String get lessonGoodMorningDesc;

  /// No description provided for @lessonGoodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get lessonGoodNight;

  /// No description provided for @lessonGoodNightDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for good night.'**
  String get lessonGoodNightDesc;

  /// No description provided for @lessonHowAreYou.
  ///
  /// In en, this message translates to:
  /// **'How Are You?'**
  String get lessonHowAreYou;

  /// No description provided for @lessonHowAreYouDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn to ask how are you in sign.'**
  String get lessonHowAreYouDesc;

  /// No description provided for @lessonGoodbye.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get lessonGoodbye;

  /// No description provided for @lessonGoodbyeDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for goodbye.'**
  String get lessonGoodbyeDesc;

  /// No description provided for @lessonMother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get lessonMother;

  /// No description provided for @lessonMotherDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for mother.'**
  String get lessonMotherDesc;

  /// No description provided for @lessonFather.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get lessonFather;

  /// No description provided for @lessonFatherDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for father.'**
  String get lessonFatherDesc;

  /// No description provided for @lessonSister.
  ///
  /// In en, this message translates to:
  /// **'Sister'**
  String get lessonSister;

  /// No description provided for @lessonSisterDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for sister.'**
  String get lessonSisterDesc;

  /// No description provided for @lessonBrother.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get lessonBrother;

  /// No description provided for @lessonBrotherDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for brother.'**
  String get lessonBrotherDesc;

  /// No description provided for @lessonRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get lessonRed;

  /// No description provided for @lessonRedDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for red.'**
  String get lessonRedDesc;

  /// No description provided for @lessonBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get lessonBlue;

  /// No description provided for @lessonBlueDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for blue.'**
  String get lessonBlueDesc;

  /// No description provided for @lessonGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get lessonGreen;

  /// No description provided for @lessonGreenDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for green.'**
  String get lessonGreenDesc;

  /// No description provided for @lessonCircle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get lessonCircle;

  /// No description provided for @lessonCircleDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for circle.'**
  String get lessonCircleDesc;

  /// No description provided for @lessonSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get lessonSquare;

  /// No description provided for @lessonSquareDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for square.'**
  String get lessonSquareDesc;

  /// No description provided for @lessonTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get lessonTeacher;

  /// No description provided for @lessonTeacherDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for teacher.'**
  String get lessonTeacherDesc;

  /// No description provided for @lessonStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get lessonStudent;

  /// No description provided for @lessonStudentDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for student.'**
  String get lessonStudentDesc;

  /// No description provided for @lessonBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get lessonBook;

  /// No description provided for @lessonBookDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for book.'**
  String get lessonBookDesc;

  /// No description provided for @lessonLetterPrefix.
  ///
  /// In en, this message translates to:
  /// **'Letter'**
  String get lessonLetterPrefix;

  /// No description provided for @lessonLetterDescPrefix.
  ///
  /// In en, this message translates to:
  /// **'Learn sign for letter'**
  String get lessonLetterDescPrefix;

  /// No description provided for @lessonNumberPrefix.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get lessonNumberPrefix;

  /// No description provided for @lessonNumberDescPrefix.
  ///
  /// In en, this message translates to:
  /// **'Learn the sign for'**
  String get lessonNumberDescPrefix;

  /// No description provided for @lessonGreetingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Greetings'**
  String get lessonGreetingsTitle;

  /// No description provided for @lessonGreetingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn hello, thank you, and common daily greetings.'**
  String get lessonGreetingsDescription;

  /// No description provided for @lessonFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Signs'**
  String get lessonFamilyTitle;

  /// No description provided for @lessonFamilyDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice signs for parents, siblings, and relatives.'**
  String get lessonFamilyDescription;

  /// No description provided for @lessonNumbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Numbers 1 to 10'**
  String get lessonNumbersTitle;

  /// No description provided for @lessonNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Build confidence with basic counting signs.'**
  String get lessonNumbersDescription;

  /// No description provided for @lessonSchoolTitle.
  ///
  /// In en, this message translates to:
  /// **'School Vocabulary'**
  String get lessonSchoolTitle;

  /// No description provided for @lessonSchoolDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn classroom, teacher, book, and study signs.'**
  String get lessonSchoolDescription;

  /// No description provided for @lessonEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get lessonEmergencyTitle;

  /// No description provided for @lessonEmergencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice signs for urgent help, safety, and care.'**
  String get lessonEmergencyDescription;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @settingsDefaultAudioLanguage.
  ///
  /// In en, this message translates to:
  /// **'Default Audio Language'**
  String get settingsDefaultAudioLanguage;

  /// No description provided for @settingsDefaultContentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Default Content Language'**
  String get settingsDefaultContentLanguage;

  /// No description provided for @settingsSignLanguageType.
  ///
  /// In en, this message translates to:
  /// **'Sign Language Type'**
  String get settingsSignLanguageType;

  /// No description provided for @settingsSignLanguageValue.
  ///
  /// In en, this message translates to:
  /// **'Pakistani Sign Language'**
  String get settingsSignLanguageValue;

  /// No description provided for @settingsAutoPlayAudio.
  ///
  /// In en, this message translates to:
  /// **'Auto-Play Audio'**
  String get settingsAutoPlayAudio;

  /// No description provided for @settingsOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsOn;

  /// No description provided for @settingsOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsOff;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear the local login token.'**
  String get settingsLogoutSubtitle;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove this account from local storage.'**
  String get settingsDeleteSubtitle;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the current local account and clears your login token.'**
  String get settingsDeleteBody;

  /// No description provided for @settingsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsCancel;

  /// No description provided for @settingsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDelete;

  /// No description provided for @videoError.
  ///
  /// In en, this message translates to:
  /// **'Video could not be loaded.'**
  String get videoError;

  /// No description provided for @fourMin.
  ///
  /// In en, this message translates to:
  /// **'4 min'**
  String get fourMin;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed.'**
  String get loginFailed;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created. Please log in.'**
  String get accountCreated;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue using PSL Translator.'**
  String get loginToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailRequired;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordRequired;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createNewAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @accountStoredLocally.
  ///
  /// In en, this message translates to:
  /// **'Your account is stored locally on this device.'**
  String get accountStoredLocally;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required.'**
  String get usernameRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordLength;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed.'**
  String get registrationFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pa', 'ps', 'sd', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pa':
      return AppLocalizationsPa();
    case 'ps':
      return AppLocalizationsPs();
    case 'sd':
      return AppLocalizationsSd();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
