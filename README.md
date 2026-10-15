# 🎓 Student E-Portfolio

A modern, responsive **Student E-Portfolio mobile app** built with **Flutter** and **Dart**. A student logs in and then browses academic details, certifications, extra-curricular activities and an animated achievements showcase with a video.


![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![Material 3](https://img.shields.io/badge/Material-3-3949AB)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey)

---

## ✨ Features

| Screen | What it does |
|---|---|
| **Login** | Profile photo, logo, validated Roll Number + Password form, show/hide password, SnackBar on failure, fade + slide-in animation |
| **Academic Details** | Profile header (Hero animation), academic `Table`, 10th / 12th / CGPA, REST API quote card |
| **Certifications & Skills** | Responsive grid of `CertificateCard`s (1 / 2 / 3 columns) with a *View Certificate* image dialog |
| **Extra-Curricular** | `ListView` of activity cards with icon, description and year |
| **Achievements** | `PageView` carousel with scale transition, animated page indicators, previous/next buttons and a **Watch My Achievements** video player |
| **Logout** | Confirmation dialog, then clears the navigation stack so Back cannot return to the dashboard |

**Also included:** Material 3 theming from one seed colour, responsive layout (bottom `NavigationBar` on phones, `NavigationRail` on wide screens), friendly error handling when the API or a file is unavailable, and widget tests.

## 🖼️ Screenshots

Add your screenshots to `docs/screenshots/` and link them here, for example:

| Login | Academics | Certificates | Achievements |
|---|---|---|---|
| ![Login](docs/screenshots/login.png) | ![Academics](docs/screenshots/academics.png) | ![Certificates](docs/screenshots/certificates.png) | ![Achievements](docs/screenshots/achievements.png) |

## 🧰 Tech Stack

- **Flutter** (Material 3) and **Dart** (null safety)
- [`http`](https://pub.dev/packages/http) for the REST API call
- [`video_player`](https://pub.dev/packages/video_player) for the achievements video
- State management with plain `setState()` (no extra libraries)

## 📚 Syllabus Concepts Demonstrated

| Outcome | Concepts | Where |
|---|---|---|
| **C506.1** | Dart basics, widgets, Text / Image / Container, Row / Column / Stack | all screens |
| **C506.2** | Responsive UI, Navigator, named routes | `main.dart`, `dashboard_page.dart` |
| **C506.3** | Forms, validation, error handling, animations | `login_page.dart`, `fade_slide_in.dart`, achievements tab |
| **C506.4** | REST API (`http.get`, `jsonDecode`, `FutureBuilder`, `async/await`), debugging-friendly code, testing | `quote_card.dart`, `test/` |

### Animations used
- `FadeTransition` + `SlideTransition` on the login page and video button (`AnimationController`)
- `TweenAnimationBuilder` for staggered card entrance (`FadeSlideIn`)
- `AnimatedSwitcher` for tab changes
- `AnimatedContainer` for carousel page dots
- `PageView` + `AnimatedBuilder` scale transition
- `Hero` for the profile photo (login → dashboard)

## 📁 Project Structure

```
student-eportfolio/
├── assets/
│   ├── images/        profile, certificates, badge, achievement images
│   └── videos/        achievements.mp4
├── lib/
│   ├── main.dart              # MaterialApp, theme, named routes
│   ├── models/                # Student, Certificate, Achievement, Activity
│   ├── data/                  # Editable lists: certificates, activities, achievements
│   ├── screens/               # login_page, dashboard_page, video_page
│   └── widgets/               # Reusable UI: CertificateCard, ActivityCard,
│                              # AchievementCard, AcademicTable, CustomButton,
│                              # AppCard, ProfileAvatar, FadeSlideIn, QuoteCard
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── VIVA_GUIDE.md
```

**Navigation flow:** `/login` → (`pushReplacementNamed`) → `/dashboard` → `/video`; Logout → (`pushNamedAndRemoveUntil`) → `/login`.

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.22 or newer recommended)
- Android Studio or VS Code with the Flutter plugin
- An emulator or a physical device

### Run the app

```bash
git clone https://github.com/srinidhi0506/student-eportfolio.git
cd student-eportfolio
flutter pub get
flutter run
```

> If the `android/` or `ios/` folders are missing, run `flutter create .` once inside the project folder, then `flutter run`.

### 🔑 Demo credentials

| Roll Number | Password |
|---|---|
| `24WH1A05A4` | `123456` |

Login is local only. There is no backend or database.

### Run the tests

```bash
flutter test
```

Tests check that the login page shows *My Portfolio*, the Roll Number and Password fields, the Login button, and the validation messages for empty input.

### Android internet permission
The quote card uses the internet. Debug builds work out of the box. For **release** builds add this line to `android/app/src/main/AndroidManifest.xml`, above `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## 🛠️ Customising the Portfolio

| To change… | Edit |
|---|---|
| Name, roll no, CGPA, 10th / 12th % | `lib/models/student.dart` |
| Certificates | `lib/data/certificates.dart` |
| Extra-curricular activities | `lib/data/activities.dart` |
| Achievement slides | `lib/data/achievements.dart` |
| Demo login credentials | `_validRoll` / `_validPassword` in `lib/screens/login_page.dart` |
| Theme colour | `seedColor` in `lib/main.dart` |

**Adding images/video:**
- Profile photo: replace `assets/images/profile.jpg`
- Certificate / achievement images: put them in `assets/images/` and reference them with `imagePath: 'assets/images/<file>.jpg'` in the matching data file
- Achievement video: replace `assets/videos/achievements.mp4`

After adding new assets, stop the app and run `flutter run` again, because hot reload does not pick up new assets.

## 🌐 REST API

The Academic tab shows a random quote from the free [DummyJSON](https://dummyjson.com/quotes/random) API:

```
GET https://dummyjson.com/quotes/random
→ { "id": 1, "quote": "...", "author": "..." }
```

If the request fails or times out, only that card shows a friendly error message with a refresh button. The rest of the app keeps working.

## 📖 Viva Guide

`VIVA_GUIDE.md` contains a plain-language explanation of every concept used (Stateless/Stateful widgets, Navigator, named routes, Form validation, FutureBuilder, PageView, animations, Material 3) and 20 likely viva questions with answers based on this project.

## 🗺️ Possible Improvements

- Persist login state with `shared_preferences`
- Dark theme toggle
- Load portfolio data from a JSON file or API
- Open certificate verification links with `url_launcher`

## 👩‍💻 Author

**Srinidhi Bhonagiri**
B.Tech CSE, III Year, BVRIT Hyderabad College of Engineering for Women
GitHub: [@srinidhi0506](https://github.com/srinidhi0506)

## 📄 License

This project was created for academic purposes. Add a license of your choice (for example MIT) if you want others to reuse it.
