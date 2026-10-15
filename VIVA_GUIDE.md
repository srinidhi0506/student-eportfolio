# Student E-Portfolio – Guide, Viva Explanation & Questions

## 1. Architecture (how login connects to dashboard)
main.dart -> MaterialApp with named routes (/login, /dashboard, /video).
LoginPage validates the Form -> checks local credentials -> Navigator.pushReplacementNamed(context, '/dashboard').
DashboardPage keeps `_selectedIndex` (setState) and shows one of 5 tabs using NavigationBar.
Data lives in `data/` (lists), shapes in `models/`, reusable UI in `widgets/`, pages in `screens/`.

## 2. Where to put your files
| What | Path | Notes |
|---|---|---|
| Profile photo | assets/images/profile.jpg | Square-ish JPG, same file name |
| Certificate images | assets/images/certificate1.jpg, certificate2.jpg | Referenced by `imagePath` in lib/data/certificates.dart |
| Achievement images | assets/images/achievement1.jpg, achievement2.jpg | Referenced in lib/data/achievements.dart |
| Achievement video | assets/videos/achievements.mp4 | Replace the 3-second placeholder (keep it small, < 20 MB) |

To add MORE images: copy them into assets/images/ and add an entry in the data file with `imagePath: 'assets/images/yourfile.jpg'`.
pubspec.yaml already declares the folders (`assets/images/` and `assets/videos/`), so new files in those folders work after a restart (`flutter run` again, hot reload is not enough for new assets).

## 3. Replace sample information
- Name, roll no, CGPA, 10th %, etc.: lib/models/student.dart (`currentStudent`)
- Certificates: lib/data/certificates.dart
- Activities: lib/data/activities.dart
- Achievements slides: lib/data/achievements.dart
- Demo login credentials: `_validRoll` and `_validPassword` at the top of lib/screens/login_page.dart
- App colour: `seedColor` in lib/main.dart

## 4. Android internet permission (for the Quote API in release builds)
In android/app/src/main/AndroidManifest.xml add above `<application`:
    <uses-permission android:name="android.permission.INTERNET"/>
(Debug builds already have it.)

## 5. Simple explanations
- **Flutter**: Google's UI toolkit to build apps for Android, iOS, web and desktop from one codebase. Everything is a widget.
- **Dart**: the programming language of Flutter; object-oriented, null-safe, supports async/await.
- **StatelessWidget**: a widget whose data never changes after it is built (e.g. AppCard). **StatefulWidget**: has a State object whose data changes (e.g. LoginPage, DashboardPage).
- **Navigator**: manages a stack of screens; push adds a screen, pop removes one.
- **Named routes**: screens registered with string names in `routes:` (e.g. '/dashboard') and opened by `Navigator.pushNamed`.
- **setState()**: tells Flutter that data changed so it rebuilds the widget.
- **MediaQuery**: gives screen information (width, height). We use it to decide NavigationBar vs NavigationRail.
- **Form / FormState**: Form groups input fields; `GlobalKey<FormState>` lets us call `validate()` on all of them at once.
- **Validation**: checking input is correct before using it. `validator` returns an error message or null.
- **FutureBuilder**: builds UI depending on a Future's state (waiting, error, data). Used in QuoteCard.
- **REST API**: a web service we call with HTTP (GET) that returns JSON data.
- **async/await**: lets code wait for slow work (network) without freezing the UI.
- **PageView**: a scrollable list where each child fills a page; swipe to change pages (our achievements carousel).
- **Animation**: changing a property over time. Implicit: AnimatedContainer, TweenAnimationBuilder, AnimatedSwitcher. Explicit: AnimationController + FadeTransition/SlideTransition. Hero animates a widget between two screens.
- **Reusable widgets**: write once, use many times; less code, consistent design, easier to fix.
- **Material 3**: Google's latest design system (`useMaterial3: true`): rounded shapes, NavigationBar, colour from a seed colour.

## 6. Animations used (where)
1. Login fade + slide: AnimationController + FadeTransition + SlideTransition (login_page.dart)
2. Staggered cards: FadeSlideIn using TweenAnimationBuilder (widgets/fade_slide_in.dart)
3. Tab change: AnimatedSwitcher (dashboard_page.dart)
4. Carousel: PageView + scale transition via AnimatedBuilder
5. Dots: AnimatedContainer
6. Profile photo: Hero (widgets/profile_avatar.dart)
7. Video button: FadeTransition + SlideTransition

## 7. Twenty viva questions
1. **Why Flutter?** One codebase for many platforms, fast UI, hot reload.
2. **What is a widget?** Basic building block of UI; the whole screen is a tree of widgets.
3. **Difference between Stateless and Stateful?** Stateless never changes; Stateful can change using setState.
4. **Where did you use setState?** Password visibility, loading flag, selected tab, carousel page, quote refresh.
5. **How does login work?** Form validate() -> compare with local credentials -> pushReplacementNamed('/dashboard') or SnackBar on failure.
6. **Why pushReplacementNamed for login?** It removes the login page from the stack so Back doesn't return to it.
7. **Why pushNamedAndRemoveUntil for logout?** It clears the stack so the user can't go back to the dashboard.
8. **What is GlobalKey<FormState>?** A key giving access to the Form's state, to call validate().
9. **What validations did you add?** Roll number not empty; password not empty and at least 6 characters.
10. **TextField vs TextFormField?** TextFormField works inside a Form and supports validator.
11. **How is the password hidden?** `obscureText: true`, toggled by a suffix IconButton with setState.
12. **How is the app responsive?** MediaQuery, LayoutBuilder, Expanded, Wrap with computed widths, SingleChildScrollView, ConstrainedBox maxWidth.
13. **Where did you use LayoutBuilder?** Login page and certificates tab (1/2/3 columns).
14. **What is a ThemeData / ColorScheme?** Central place for colours and styles; fromSeed makes a palette from one colour.
15. **What does PageView do?** Shows swipeable pages; PageController controls it (animateToPage, viewportFraction).
16. **Explain the REST call.** http.get() -> Future<Response> -> check statusCode 200 -> jsonDecode() -> Map -> shown in FutureBuilder.
17. **What if the API fails?** FutureBuilder hasError -> friendly message; rest of the app works.
18. **What is Hero animation?** Same tag on two screens; Flutter animates the widget between them (profile photo).
19. **Why do you dispose controllers?** To free memory and stop animations when the screen closes.
20. **What does your test check?** That the login page shows "My Portfolio", the fields and the Login button, and that empty input shows validation errors (flutter test).
