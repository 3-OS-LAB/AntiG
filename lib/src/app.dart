import 'package:flutter/material.dart';

import 'pages.dart';

const bloodRed = Color(0xFFD92D39);
const medicalBlue = Color(0xFF1769AA);
const healthGreen = Color(0xFF287D4D);

class AppController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  AppStage stage = AppStage.welcome;
  int onboardingPage = 0;
  bool isEligible = false;
  bool appointmentBooked = false;
  bool emergencyActive = false;
  int rewardPoints = 1240;

  void setStage(AppStage value) {
    stage = value;
    notifyListeners();
  }

  void nextOnboarding() {
    if (onboardingPage < 2) {
      onboardingPage++;
    } else {
      stage = AppStage.auth;
    }
    notifyListeners();
  }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void completeEligibility() {
    isEligible = true;
    notifyListeners();
  }

  void bookAppointment() {
    appointmentBooked = true;
    rewardPoints += 60;
    notifyListeners();
  }

  void activateEmergency() {
    emergencyActive = true;
    notifyListeners();
  }
}

enum AppStage { welcome, onboarding, auth, otp, role, biometric, home }

class AppScope extends InheritedNotifier<AppController> {
  const AppScope({super.key, required AppController controller, required super.child})
      : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope must be above this widget.');
    return scope!.notifier!;
  }
}

class BloodConnectApp extends StatefulWidget {
  const BloodConnectApp({super.key});

  @override
  State<BloodConnectApp> createState() => _BloodConnectAppState();
}

class _BloodConnectAppState extends State<BloodConnectApp> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => AppScope(
        controller: _controller,
        child: MaterialApp(
          title: 'BloodConnect',
          debugShowCheckedModeBanner: false,
          themeMode: _controller.themeMode,
          theme: appTheme(Brightness.light),
          darkTheme: appTheme(Brightness.dark),
          home: const EntryPoint(),
        ),
      ),
    );
  }
}

ThemeData appTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: bloodRed,
    brightness: brightness,
    primary: isDark ? const Color(0xFFFF6B74) : bloodRed,
    secondary: isDark ? const Color(0xFF70B8FF) : medicalBlue,
    tertiary: isDark ? const Color(0xFF80D6A1) : healthGreen,
    surface: isDark ? const Color(0xFF131316) : const Color(0xFFFFFBFC),
  );
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: scheme.onSurface,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
    ),
    cardTheme: CardThemeData(
      color: isDark ? const Color(0xFF202024) : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? const Color(0xFF202024) : const Color(0xFFF6F3F4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 74,
      indicatorColor: scheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    switch (AppScope.of(context).stage) {
      case AppStage.welcome:
        return const WelcomeScreen();
      case AppStage.onboarding:
        return const OnboardingScreen();
      case AppStage.auth:
        return const LoginScreen();
      case AppStage.otp:
        return const OtpScreen();
      case AppStage.role:
        return const RoleScreen();
      case AppStage.biometric:
        return const BiometricScreen();
      case AppStage.home:
        return const HomeShell();
    }
  }
}
