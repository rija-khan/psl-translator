import 'package:flutter_test/flutter_test.dart';
import 'package:psl_translator/app.dart';

void main() {
  testWidgets('renders PSL Translator shell', (tester) async {
    await tester.pumpWidget(const PslTranslatorApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('PSL Translator'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Speak'), findsOneWidget);
    expect(find.text('Sign'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
  });
}
