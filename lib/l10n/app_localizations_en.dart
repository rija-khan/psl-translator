// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PSL Translator';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageSindhi => 'Sindhi';

  @override
  String get languagePunjabi => 'Punjabi';

  @override
  String get languagePashto => 'Pashto';

  @override
  String get home => 'Home';

  @override
  String get speak => 'Speak';

  @override
  String get sign => 'Sign';

  @override
  String get learn => 'Learn';

  @override
  String get practice => 'Practice';

  @override
  String get settings => 'Settings';

  @override
  String get homeTitle => 'Pakistani Sign Language';

  @override
  String get homeSubtitle =>
      'Translate speech, recognize signs, and learn through guided video lessons.';

  @override
  String get homeTagline =>
      'Learn, practice and communicate using Pakistani Sign Language';

  @override
  String get learningProgress => 'Learning Progress';

  @override
  String get yourLearningProgress => 'Your Learning Progress';

  @override
  String get completed => 'Completed';

  @override
  String lessonsCompleted(int count, int total) {
    return '$count / $total Lessons completed';
  }

  @override
  String get weeklyGoal => 'Weekly goal';

  @override
  String get progressMessage =>
      'Keep practicing to complete this week\'s lessons.';

  @override
  String get featuredVideo => 'Featured Sign Video';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get speakMode => 'Speak Mode';

  @override
  String get speakModeSubtitle => 'Speech to sign\ntranslation';

  @override
  String get signMode => 'Sign Mode';

  @override
  String get signModeSubtitle => 'Sign to speech\ntranslation';

  @override
  String get learnMode => 'Learn';

  @override
  String get learnModeSubtitle => 'Master sign language';

  @override
  String get quickPractice => 'Quick Practice';

  @override
  String get quickPracticeSubtitle => '5-min daily challenge';

  @override
  String get howToUse => 'How to use this app';

  @override
  String get instructionSpeak => 'Use Speak mode to convert voice to PSL';

  @override
  String get instructionSign => 'Use Sign mode to convert signs to speech';

  @override
  String get instructionLearn => 'Practice lessons to improve fluency';

  @override
  String get speakAction => 'Voice to signs';

  @override
  String get signAction => 'Recognize signs';

  @override
  String get learnAction => 'Video lessons';

  @override
  String get practiceAction => 'Build fluency';

  @override
  String get speakTitle => 'Speak to Sign';

  @override
  String get speakSubtitle =>
      'Convert spoken or typed language into sign language video output.';

  @override
  String get yourTranslator => 'Your Translator';

  @override
  String get yourTranslatorSubtitle =>
      'Speak and watch me translate to sign language';

  @override
  String get howToUseSpeak => 'How to use';

  @override
  String get howToUseSpeakBody =>
      'Tap and hold the microphone button to record your speech. Release to translate into sign language.';

  @override
  String get holdToSpeak => 'Hold to speak, release to translate';

  @override
  String get translationResult => 'Translation Result';

  @override
  String get speechTranscribedHere =>
      'Your speech will be transcribed and translated here...';

  @override
  String get slow => 'Slow';

  @override
  String get normal => 'Normal';

  @override
  String get fast => 'Fast';

  @override
  String get inputText => 'Input text';

  @override
  String get recordVoice => 'Record Voice';

  @override
  String get stopRecording => 'Stop Recording';

  @override
  String get convert => 'Convert';

  @override
  String get generatedText => 'Generated text';

  @override
  String get generatedPlaceholder => 'Generated translation will appear here.';

  @override
  String get recordingPlaceholder => 'Listening for speech...';

  @override
  String get signOutput => 'Sign language output';

  @override
  String get signTitle => 'Sign Recognition';

  @override
  String get signSubtitle =>
      'Use the native camera for recognition or watch example videos.';

  @override
  String get signToAudioTitle => 'Sign to Audio Translation';

  @override
  String get signToAudioBody =>
      'Position yourself in the camera frame and start signing. The translator will convert your signs to audio.';

  @override
  String get positionYourselfHere => 'Position yourself here';

  @override
  String get cameraReadyStart => 'Camera ready - Start signing';

  @override
  String get startSigning => 'Start Signing';

  @override
  String get stopAndTranslate => 'Stop &\nTranslate';

  @override
  String get signTranslatedHere =>
      'Your sign language will be translated to audio here...';

  @override
  String get cameraMode => 'Camera Mode';

  @override
  String get videoMode => 'Video Mode';

  @override
  String get cameraReady => 'Camera preview will appear here.';

  @override
  String get cameraPermissionDenied => 'Camera permission was denied.';

  @override
  String get cameraUnavailable => 'Camera is unavailable on this device.';

  @override
  String get detectedSignPlaceholder => 'Detected Sign Will Appear Here';

  @override
  String get startCamera => 'Start Camera';

  @override
  String get stopCamera => 'Stop Camera';

  @override
  String get exampleVideo => 'Example sign video';

  @override
  String get learnTitle => 'Learn Sign Language';

  @override
  String get learnSubtitle =>
      'Browse categories and practice signs through responsive video lessons.';

  @override
  String get masterSignLanguage => 'Master Sign Language';

  @override
  String get startLearningToday => 'Start your learning journey today';

  @override
  String get yourProgress => 'Your Progress';

  @override
  String get overallCompletion => 'Overall Completion';

  @override
  String completedCount(int done, int total) {
    return 'COMPLETED : $done/$total';
  }

  @override
  String timeSpent(String time) {
    return 'TIME SPENT : $time';
  }

  @override
  String get lessonsInCategory => 'Lessons in this Category';

  @override
  String lessonProgress(int current, int total) {
    return 'Lesson $current of $total';
  }

  @override
  String percentComplete(int percent) {
    return '$percent% complete';
  }

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get searchLessons => 'Search lessons';

  @override
  String get categories => 'Categories';

  @override
  String get all => 'All';

  @override
  String get lesson => 'Lesson';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get category => 'Category';

  @override
  String get previousLesson => 'Previous Lesson';

  @override
  String get nextLesson => 'Next Lesson';

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get categoryBasics => 'Basics';

  @override
  String get categoryDailyLife => 'Daily Life';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryPublicServices => 'Public Services';

  @override
  String get catBasicGreetings => 'Basic Greetings';

  @override
  String get catBasicGreetingsDuration => '40 min';

  @override
  String get catPslAlphabet => 'PSL Alphabet';

  @override
  String get catPslAlphabetDuration => '2 hours';

  @override
  String get catFamilyPeople => 'Family & People';

  @override
  String get catFamilyPeopleDuration => '1 hour';

  @override
  String get catColorsShapes => 'Colors & Shapes';

  @override
  String get catColorsShapesDuration => '1.5 hours';

  @override
  String get catNumbers => 'Numbers';

  @override
  String get catNumbersDuration => '1 hour';

  @override
  String get catSchoolEducation => 'School & Education';

  @override
  String get catSchoolEducationDuration => '2 hours';

  @override
  String get lessonHelloHi => 'Hello & Hi';

  @override
  String get lessonHelloHiDesc => 'Learn the sign for hello and hi.';

  @override
  String get lessonThankYou => 'Thank You';

  @override
  String get lessonThankYouDesc => 'Learn the sign for thank you.';

  @override
  String get lessonPlease => 'Please';

  @override
  String get lessonPleaseDesc => 'Learn the sign for please.';

  @override
  String get lessonSorry => 'Sorry';

  @override
  String get lessonSorryDesc => 'Learn the sign for sorry.';

  @override
  String get lessonGoodMorning => 'Good Morning';

  @override
  String get lessonGoodMorningDesc => 'Learn the sign for good morning.';

  @override
  String get lessonGoodNight => 'Good Night';

  @override
  String get lessonGoodNightDesc => 'Learn the sign for good night.';

  @override
  String get lessonHowAreYou => 'How Are You?';

  @override
  String get lessonHowAreYouDesc => 'Learn to ask how are you in sign.';

  @override
  String get lessonGoodbye => 'Goodbye';

  @override
  String get lessonGoodbyeDesc => 'Learn the sign for goodbye.';

  @override
  String get lessonMother => 'Mother';

  @override
  String get lessonMotherDesc => 'Learn the sign for mother.';

  @override
  String get lessonFather => 'Father';

  @override
  String get lessonFatherDesc => 'Learn the sign for father.';

  @override
  String get lessonSister => 'Sister';

  @override
  String get lessonSisterDesc => 'Learn the sign for sister.';

  @override
  String get lessonBrother => 'Brother';

  @override
  String get lessonBrotherDesc => 'Learn the sign for brother.';

  @override
  String get lessonRed => 'Red';

  @override
  String get lessonRedDesc => 'Learn the sign for red.';

  @override
  String get lessonBlue => 'Blue';

  @override
  String get lessonBlueDesc => 'Learn the sign for blue.';

  @override
  String get lessonGreen => 'Green';

  @override
  String get lessonGreenDesc => 'Learn the sign for green.';

  @override
  String get lessonCircle => 'Circle';

  @override
  String get lessonCircleDesc => 'Learn the sign for circle.';

  @override
  String get lessonSquare => 'Square';

  @override
  String get lessonSquareDesc => 'Learn the sign for square.';

  @override
  String get lessonTeacher => 'Teacher';

  @override
  String get lessonTeacherDesc => 'Learn the sign for teacher.';

  @override
  String get lessonStudent => 'Student';

  @override
  String get lessonStudentDesc => 'Learn the sign for student.';

  @override
  String get lessonBook => 'Book';

  @override
  String get lessonBookDesc => 'Learn the sign for book.';

  @override
  String get lessonLetterPrefix => 'Letter';

  @override
  String get lessonLetterDescPrefix => 'Learn sign for letter';

  @override
  String get lessonNumberPrefix => 'Number';

  @override
  String get lessonNumberDescPrefix => 'Learn the sign for';

  @override
  String get lessonGreetingsTitle => 'Greetings';

  @override
  String get lessonGreetingsDescription =>
      'Learn hello, thank you, and common daily greetings.';

  @override
  String get lessonFamilyTitle => 'Family Signs';

  @override
  String get lessonFamilyDescription =>
      'Practice signs for parents, siblings, and relatives.';

  @override
  String get lessonNumbersTitle => 'Numbers 1 to 10';

  @override
  String get lessonNumbersDescription =>
      'Build confidence with basic counting signs.';

  @override
  String get lessonSchoolTitle => 'School Vocabulary';

  @override
  String get lessonSchoolDescription =>
      'Learn classroom, teacher, book, and study signs.';

  @override
  String get lessonEmergencyTitle => 'Emergency Help';

  @override
  String get lessonEmergencyDescription =>
      'Practice signs for urgent help, safety, and care.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get settingsDefaultAudioLanguage => 'Default Audio Language';

  @override
  String get settingsDefaultContentLanguage => 'Default Content Language';

  @override
  String get settingsSignLanguageType => 'Sign Language Type';

  @override
  String get settingsSignLanguageValue => 'Pakistani Sign Language';

  @override
  String get settingsAutoPlayAudio => 'Auto-Play Audio';

  @override
  String get settingsOn => 'On';

  @override
  String get settingsOff => 'Off';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get settingsLogoutSubtitle => 'Clear the local login token.';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteSubtitle =>
      'Remove this account from local storage.';

  @override
  String get settingsDeleteTitle => 'Delete account?';

  @override
  String get settingsDeleteBody =>
      'This removes the current local account and clears your login token.';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsDelete => 'Delete';

  @override
  String get videoError => 'Video could not be loaded.';

  @override
  String get fourMin => '4 min';

  @override
  String get loginFailed => 'Login failed.';

  @override
  String get accountCreated => 'Account created. Please log in.';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginToContinue => 'Log in to continue using PSL Translator.';

  @override
  String get email => 'Email';

  @override
  String get emailRequired => 'Email is required.';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required.';

  @override
  String get login => 'Login';

  @override
  String get createNewAccount => 'Create a new account';

  @override
  String get register => 'Register';

  @override
  String get createAccount => 'Create account';

  @override
  String get accountStoredLocally =>
      'Your account is stored locally on this device.';

  @override
  String get username => 'Username';

  @override
  String get usernameRequired => 'Username is required.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get passwordLength => 'Password must be at least 6 characters.';

  @override
  String get registrationFailed => 'Registration failed.';
}
