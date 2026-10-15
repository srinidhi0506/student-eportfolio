import 'package:flutter_test/flutter_test.dart';
import 'package:student_eportfolio/main.dart';

void main() {
  testWidgets('Login page shows title, fields and button', (tester) async {
    // Use a tall virtual screen so nothing is off-screen.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle(); // wait for the fade-in animation

    expect(find.text('My Portfolio'), findsOneWidget);
    expect(find.text('Student E-Portfolio'), findsOneWidget);
    expect(find.text('Roll Number'), findsWidgets);
    expect(find.text('Password'), findsWidgets);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Empty login shows validation messages', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter your roll number'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
