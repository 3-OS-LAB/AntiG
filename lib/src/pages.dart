import 'package:flutter/material.dart';

import 'app.dart';

void openPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        child: page,
      ),
    ),
  );
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.small = false});

  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 42.0 : 76.0;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [bloodRed, Color(0xFFFF6F75)]),
        borderRadius: BorderRadius.circular(size * .34),
        boxShadow: [BoxShadow(color: bloodRed.withOpacity(.25), blurRadius: 22, offset: const Offset(0, 10))],
      ),
      child: Icon(Icons.favorite_rounded, size: size * .52, color: Colors.white),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: bloodRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child, this.color, this.padding = const EdgeInsets.all(20)});

  final Widget child;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Card(color: color, child: Padding(padding: padding, child: child));
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.title, required this.child, this.actions});

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -90,
            child: Container(
              height: 310,
              width: 310,
              decoration: BoxDecoration(color: bloodRed.withOpacity(.14), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -140,
            left: -120,
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(color: medicalBlue.withOpacity(.09), shape: BoxShape.circle),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const BrandMark(),
                      const SizedBox(height: 34),
                      Text(
                        'Giving life,\nmade human.',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, height: 1.03, letterSpacing: -1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Find a donor, share your gift, and keep your health journey together in one thoughtful place.',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.45, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 44),
                      PrimaryButton(
                        label: 'Get started',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () => app.setStage(AppStage.onboarding),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        width: double.infinity,
                        child: TextButton(onPressed: () => app.setStage(AppStage.auth), child: const Text('I already have an account')),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'For awareness and coordination only. Seek local emergency care when you need it.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const slides = [
    (Icons.volunteer_activism_rounded, bloodRed, 'DONATE WITH CONFIDENCE', 'A small moment.\nA lifetime of impact.', 'Understand your eligibility, find trusted camps and celebrate every donation.'),
    (Icons.emergency_rounded, Color(0xFFF08A24), 'WHEN TIME MATTERS', 'Help travels\nfaster together.', 'Connect with nearby donors, blood banks and emergency resources in a few taps.'),
    (Icons.monitor_heart_rounded, medicalBlue, 'YOUR HEALTH, CLEARLY', 'Your reports,\nmade easier to read.', 'Keep reports organised and understand trends with clear, non-diagnostic summaries.'),
  ];

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final slide = slides[app.onboardingPage];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => app.setStage(AppStage.auth), child: const Text('Skip'))),
                  const Spacer(),
                  Container(
                    height: 172,
                    width: 172,
                    decoration: BoxDecoration(color: slide.$2.withOpacity(.12), shape: BoxShape.circle),
                    child: Icon(slide.$1, size: 76, color: slide.$2),
                  ),
                  const SizedBox(height: 46),
                  Text(slide.$3, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: slide.$2, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
                  const SizedBox(height: 14),
                  Text(slide.$4, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, height: 1.08, letterSpacing: -1)),
                  const SizedBox(height: 16),
                  Text(slide.$5, style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 8,
                        width: index == app.onboardingPage ? 28 : 8,
                        margin: const EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                          color: index == app.onboardingPage ? slide.$2 : Theme.of(context).colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: app.onboardingPage == 2 ? 'Create my account' : 'Continue',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: app.nextOnboarding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'WELCOME BACK',
      title: 'Let’s make a difference today.',
      subtitle: 'Sign in to continue your giving journey.',
      child: Column(
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email address or phone', prefixIcon: Icon(Icons.person_outline_rounded)),
          ),
          const SizedBox(height: 14),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () => openPage(context, const ForgotPasswordScreen()), child: const Text('Forgot password?')),
          ),
          const SizedBox(height: 8),
          PrimaryButton(label: 'Continue securely', icon: Icons.arrow_forward_rounded, onPressed: () => AppScope.of(context).setStage(AppStage.otp)),
          const SizedBox(height: 18),
          const _DividerLabel(label: 'or continue with'),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: OutlinedButton.icon(onPressed: () => AppScope.of(context).setStage(AppStage.otp), icon: const Icon(Icons.g_mobiledata_rounded, size: 26), label: const Text('Google'), style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52)))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton.icon(onPressed: () => AppScope.of(context).setStage(AppStage.otp), icon: const Icon(Icons.apple_rounded), label: const Text('Apple'), style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52)))),
            ],
          ),
          const SizedBox(height: 22),
          TextButton(onPressed: () => openPage(context, const SignupScreen()), child: const Text('New to BloodConnect? Create an account')),
        ],
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'JOIN THE COMMUNITY',
      title: 'Your care can save a life.',
      subtitle: 'It only takes a minute to create your profile.',
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.badge_outlined))),
          const SizedBox(height: 14),
          const TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone number', prefixIcon: Icon(Icons.phone_outlined))),
          const SizedBox(height: 14),
          const TextField(keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.email_outlined))),
          const SizedBox(height: 14),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Create password', prefixIcon: Icon(Icons.lock_outline_rounded))),
          const SizedBox(height: 22),
          PrimaryButton(label: 'Create account', icon: Icons.arrow_forward_rounded, onPressed: () => AppScope.of(context).setStage(AppStage.otp)),
        ],
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'ACCOUNT RECOVERY',
      title: 'Reset your password.',
      subtitle: 'We’ll send a secure reset link to your registered email address.',
      child: Column(
        children: [
          const TextField(keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.email_outlined))),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Send reset link',
            icon: Icons.mark_email_read_outlined,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent — check your inbox.')));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _AuthFrame extends StatelessWidget {
  const _AuthFrame({required this.eyebrow, required this.title, required this.subtitle, required this.child});

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)) : null,
        actions: [IconButton(tooltip: 'Change theme', onPressed: AppScope.of(context).toggleTheme, icon: const Icon(Icons.dark_mode_outlined))],
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 18, 28, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandMark(small: true),
                  const SizedBox(height: 36),
                  Text(eyebrow, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: bloodRed, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                  const SizedBox(height: 12),
                  Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -.5)),
                  const SizedBox(height: 10),
                  Text(subtitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.45, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 34),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(label)),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'ONE MORE STEP',
      title: 'Verify it’s you.',
      subtitle: 'Enter the six-digit code we sent to your phone.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (_) => SizedBox(
                width: 45,
                child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number, maxLength: 1, decoration: const InputDecoration(counterText: '')),
              ),
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(label: 'Verify and continue', icon: Icons.verified_user_outlined, onPressed: () => AppScope.of(context).setStage(AppStage.role)),
          const SizedBox(height: 12),
          TextButton(onPressed: () {}, child: const Text('Resend code in 00:28')),
        ],
      ),
    );
  }
}

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  int selected = 0;
  final roles = const [
    (Icons.volunteer_activism_rounded, 'Donor', 'Give blood, track your impact and join a caring community.'),
    (Icons.search_rounded, 'Recipient', 'Find blood support and coordinate a request with confidence.'),
    (Icons.business_rounded, 'Organisation', 'Represent a hospital, blood bank or community organisation.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'PERSONALISE YOUR EXPERIENCE',
      title: 'How will you use BloodConnect?',
      subtitle: 'You can add more roles to your profile later.',
      child: Column(
        children: [
          ...List.generate(roles.length, (index) {
            final role = roles[index];
            final active = selected == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => selected = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: active ? bloodRed.withOpacity(.10) : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: active ? bloodRed : Theme.of(context).colorScheme.outlineVariant, width: active ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Icon(role.$1, color: active ? bloodRed : medicalBlue),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(role.$2, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(role.$3, style: Theme.of(context).textTheme.bodySmall)])),
                      Icon(active ? Icons.check_circle_rounded : Icons.circle_outlined, color: active ? bloodRed : null),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Continue as ${roles[selected].$2}', icon: Icons.arrow_forward_rounded, onPressed: () => AppScope.of(context).setStage(AppStage.biometric)),
        ],
      ),
    );
  }
}

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthFrame(
      eyebrow: 'QUICK AND PRIVATE',
      title: 'Unlock with a glance.',
      subtitle: 'Use your device biometrics to return to BloodConnect securely.',
      child: Column(
        children: [
          Container(height: 152, width: 152, decoration: BoxDecoration(color: medicalBlue.withOpacity(.1), shape: BoxShape.circle), child: const Icon(Icons.fingerprint_rounded, size: 78, color: medicalBlue)),
          const SizedBox(height: 30),
          PrimaryButton(label: 'Enable biometrics', icon: Icons.fingerprint_rounded, onPressed: () => AppScope.of(context).setStage(AppStage.home)),
          const SizedBox(height: 12),
          TextButton(onPressed: () => AppScope.of(context).setStage(AppStage.home), child: const Text('Not now')),
        ],
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [DashboardScreen(), DiscoverScreen(), EmergencyScreen(), ReportsScreen(), ProfileScreen()];
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.emergency_outlined), selectedIcon: Icon(Icons.emergency_rounded), label: 'Emergency'),
          NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description_rounded), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeScroll extends StatelessWidget {
  const _HomeScroll({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 24), child: child),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return _HomeScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const BrandMark(small: true),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good morning,', style: Theme.of(context).textTheme.bodyMedium), Text('Venkata', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900))])),
              IconButton(tooltip: 'Notifications', onPressed: () => openPage(context, const FeatureScreen(Feature.notifications)), icon: const Badge(child: Icon(Icons.notifications_none_rounded))),
              IconButton(tooltip: 'Toggle dark mode', onPressed: app.toggleTheme, icon: const Icon(Icons.dark_mode_outlined)),
            ],
          ),
          const SizedBox(height: 24),
          _DonationHero(eligible: app.isEligible, booked: app.appointmentBooked),
          const SizedBox(height: 28),
          const _SectionHeader(title: 'Your next good deed'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _QuickAction(icon: Icons.fact_check_outlined, label: 'Check\neligibility', color: healthGreen, onTap: () => openPage(context, const FeatureScreen(Feature.eligibility)))),
              const SizedBox(width: 12),
              Expanded(child: _QuickAction(icon: Icons.calendar_month_outlined, label: 'Book a\ndonation', color: medicalBlue, onTap: () => openPage(context, const FeatureScreen(Feature.appointment)))),
              const SizedBox(width: 12),
              Expanded(child: _QuickAction(icon: Icons.search_rounded, label: 'Find\nblood', color: const Color(0xFFF08A24), onTap: () => openPage(context, const FeatureScreen(Feature.search)))),
            ],
          ),
          const SizedBox(height: 28),
          _SectionHeader(title: 'Your impact', action: 'View history', onTap: () => openPage(context, const FeatureScreen(Feature.history))),
          const SizedBox(height: 12),
          const Row(children: [Expanded(child: _MetricCard(value: '03', label: 'Donations', icon: Icons.favorite_rounded)), SizedBox(width: 12), Expanded(child: _MetricCard(value: '09', label: 'Lives touched', icon: Icons.people_alt_rounded))]),
          const SizedBox(height: 28),
          _SectionHeader(title: 'Nearby this week', action: 'Map', onTap: () => openPage(context, const FeatureScreen(Feature.map))),
          const SizedBox(height: 12),
          const _CampCard(),
        ],
      ),
    );
  }
}

class _DonationHero extends StatelessWidget {
  const _DonationHero({required this.eligible, required this.booked});

  final bool eligible;
  final bool booked;

  @override
  Widget build(BuildContext context) {
    final title = booked ? 'Appointment confirmed' : eligible ? 'Ready to book' : 'Check your eligibility';
    final helper = booked ? 'Saturday, 10:30 AM · City Care Centre' : eligible ? 'You’re all set for your next donation.' : 'Answer three quick questions to get started.';
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFD92D39), Color(0xFF9F1D32)]),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: bloodRed.withOpacity(.28), blurRadius: 24, offset: const Offset(0, 14))],
      ),
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('YOUR DONATION JOURNEY', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.1)), const SizedBox(height: 10), Text(title, style: const TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text(helper, style: const TextStyle(color: Colors.white70, height: 1.35))])),
          const SizedBox(width: 12),
          Container(height: 56, width: 56, decoration: BoxDecoration(color: Colors.white.withOpacity(.15), shape: BoxShape.circle), child: Icon(booked ? Icons.check_circle_rounded : Icons.volunteer_activism_rounded, color: Colors.white)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onTap});

  final String title;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900))),
        if (action != null) TextButton(onPressed: onTap, child: Text(action!)),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: color.withOpacity(.09), borderRadius: BorderRadius.circular(22)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color), const SizedBox(height: 14), Text(label, style: const TextStyle(fontWeight: FontWeight.w800, height: 1.15))]),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.value, required this.label, required this.icon});

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Panel(
      padding: const EdgeInsets.all(18),
      child: Row(children: [Icon(icon, color: bloodRed), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)), Text(label, style: Theme.of(context).textTheme.bodySmall)])]),
    );
  }
}

class _CampCard extends StatelessWidget {
  const _CampCard();

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Row(children: [Container(height: 54, width: 54, decoration: BoxDecoration(color: medicalBlue.withOpacity(.12), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.location_city_rounded, color: medicalBlue)), const SizedBox(width: 15), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('City Care Blood Drive', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 4), Text('1.2 km · Sat, 10 Aug · 9 AM–4 PM')])), const Icon(Icons.chevron_right_rounded)]),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Explore care nearby', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('Find verified support, donation camps and useful health resources.'),
          const SizedBox(height: 22),
          TextField(readOnly: true, onTap: () => openPage(context, const FeatureScreen(Feature.search)), decoration: const InputDecoration(hintText: 'Search blood, camps or hospitals', prefixIcon: Icon(Icons.search_rounded))),
          const SizedBox(height: 22),
          _ExploreTile(icon: Icons.bloodtype_rounded, color: bloodRed, title: 'Find blood support', subtitle: 'Search nearby verified availability.', onTap: () => openPage(context, const FeatureScreen(Feature.search))),
          _ExploreTile(icon: Icons.location_on_outlined, color: medicalBlue, title: 'Donation camps near you', subtitle: 'See upcoming drives and book a time.', onTap: () => openPage(context, const FeatureScreen(Feature.map))),
          _ExploreTile(icon: Icons.health_and_safety_outlined, color: healthGreen, title: 'Am I eligible to donate?', subtitle: 'A private three-question pre-check.', onTap: () => openPage(context, const FeatureScreen(Feature.eligibility))),
          _ExploreTile(icon: Icons.workspace_premium_outlined, color: const Color(0xFFF08A24), title: 'Celebrate your impact', subtitle: '1,240 points · Heartful Helper', onTap: () => openPage(context, const FeatureScreen(Feature.rewards))),
        ],
      ),
    );
  }
}

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return _HomeScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Emergency centre', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('For a medical emergency, contact local emergency services immediately.'),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(color: app.emergencyActive ? bloodRed : bloodRed.withOpacity(.09), borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Icon(Icons.emergency_rounded, color: app.emergencyActive ? Colors.white : bloodRed, size: 62),
                const SizedBox(height: 14),
                Text(app.emergencyActive ? 'SOS request sent' : 'Need urgent blood support?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: app.emergencyActive ? Colors.white : null)),
                const SizedBox(height: 8),
                Text(app.emergencyActive ? 'Nearby partners have been alerted. Keep your phone available.' : 'Send a request to nearby verified partners in a few taps.', textAlign: TextAlign.center, style: TextStyle(color: app.emergencyActive ? Colors.white70 : null)),
                if (!app.emergencyActive) ...[const SizedBox(height: 20), FilledButton(onPressed: () => openPage(context, const FeatureScreen(Feature.sos)), style: FilledButton.styleFrom(backgroundColor: bloodRed, foregroundColor: Colors.white), child: const Text('Start an SOS request'))],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _ExploreTile(icon: Icons.map_outlined, color: medicalBlue, title: 'Nearby support map', subtitle: 'Blood banks, hospitals and potential donor areas.', onTap: () => openPage(context, const FeatureScreen(Feature.map))),
          _ExploreTile(icon: Icons.contact_phone_outlined, color: healthGreen, title: 'Emergency contacts', subtitle: 'Manage people who should be notified first.', onTap: () => openPage(context, const FeatureScreen(Feature.contacts))),
        ],
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text('Health reports', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900))), IconButton(onPressed: () => openPage(context, const FeatureScreen(Feature.trends)), icon: const Icon(Icons.insights_outlined))]),
          const SizedBox(height: 8),
          const Text('Keep your documents together and understand changes over time.'),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => openPage(context, const FeatureScreen(Feature.upload)),
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: medicalBlue.withOpacity(.45), width: 1.5), color: medicalBlue.withOpacity(.05)),
              child: const Row(children: [Icon(Icons.add_circle_outline_rounded, color: medicalBlue, size: 34), SizedBox(width: 15), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Add a health report', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 4), Text('PDF, image, prescription or lab result')])), Icon(Icons.arrow_forward_rounded, color: medicalBlue)]),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(title: 'Recent reports', action: 'See trends', onTap: () => openPage(context, const FeatureScreen(Feature.trends))),
          const SizedBox(height: 12),
          _ReportTile(title: 'Complete Blood Count', date: '28 Jul 2026', status: 'Reviewed', color: healthGreen, onTap: () => openPage(context, const FeatureScreen(Feature.reportDetail))),
          _ReportTile(title: 'Annual Wellness Panel', date: '05 May 2026', status: 'Ready for review', color: medicalBlue, onTap: () => openPage(context, const FeatureScreen(Feature.reportDetail))),
          _ReportTile(title: 'Prescription · Dr. Mehta', date: '15 Feb 2026', status: 'Document', color: const Color(0xFFF08A24), onTap: () => openPage(context, const FeatureScreen(Feature.reportDetail))),
          const SizedBox(height: 12),
          Text('BloodConnect summaries are for information only and are not medical diagnoses. Discuss health decisions with a qualified clinician.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScroll(
      child: Column(
        children: [
          Row(children: [Expanded(child: Text('Your profile', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900))), IconButton(tooltip: 'Edit profile', onPressed: () => openPage(context, const FeatureScreen(Feature.editProfile)), icon: const Icon(Icons.edit_outlined))]),
          const SizedBox(height: 20),
          Panel(
            padding: const EdgeInsets.all(22),
            child: Row(children: [const CircleAvatar(radius: 32, backgroundColor: Color(0xFFFFE5E7), child: Icon(Icons.person_rounded, color: bloodRed, size: 34)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Venkata Sai', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 4), const Text('O+ · Verified donor'), const SizedBox(height: 8), const _StatusPill(label: 'Profile complete', color: healthGreen)]))]),
          ),
          const SizedBox(height: 24),
          _ExploreTile(icon: Icons.workspace_premium_outlined, color: const Color(0xFFF08A24), title: 'Rewards & achievements', subtitle: '1,240 points · Heartful Helper', onTap: () => openPage(context, const FeatureScreen(Feature.rewards))),
          _ExploreTile(icon: Icons.verified_outlined, color: medicalBlue, title: 'Donation certificates', subtitle: 'Download proof of your good work.', onTap: () => openPage(context, const FeatureScreen(Feature.certificates))),
          _ExploreTile(icon: Icons.history_rounded, color: healthGreen, title: 'Donation history', subtitle: 'Review past appointments and records.', onTap: () => openPage(context, const FeatureScreen(Feature.history))),
          _ExploreTile(icon: Icons.settings_outlined, color: Colors.grey, title: 'Settings & privacy', subtitle: 'Notifications, language and appearance.', onTap: () => openPage(context, const FeatureScreen(Feature.settings))),
        ],
      ),
    );
  }
}

class _ExploreTile extends StatelessWidget {
  const _ExploreTile({required this.icon, required this.color, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Panel(
          child: Row(
            children: [
              Container(height: 52, width: 52, decoration: BoxDecoration(color: color.withOpacity(.11), borderRadius: BorderRadius.circular(17)), child: Icon(icon, color: color)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(subtitle, style: Theme.of(context).textTheme.bodySmall)])),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.title, required this.date, required this.status, required this.color, required this.onTap});

  final String title;
  final String date;
  final String status;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Panel(
          child: Row(children: [Container(height: 48, width: 48, decoration: BoxDecoration(color: color.withOpacity(.11), borderRadius: BorderRadius.circular(15)), child: Icon(Icons.description_outlined, color: color)), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(date, style: Theme.of(context).textTheme.bodySmall)])), _StatusPill(label: status, color: color)]),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(.1), borderRadius: BorderRadius.circular(30)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}

enum Feature {
  eligibility,
  appointment,
  history,
  rewards,
  search,
  map,
  sos,
  contacts,
  upload,
  reportDetail,
  trends,
  notifications,
  editProfile,
  certificates,
  settings,
}

class FeatureScreen extends StatefulWidget {
  const FeatureScreen(this.feature, {super.key});

  final Feature feature;

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  int option = 0;
  bool firstSwitch = true;
  bool secondSwitch = true;
  String type = 'O+';

  String get title => switch (widget.feature) {
        Feature.eligibility => 'Eligibility check',
        Feature.appointment => 'Book a donation',
        Feature.history => 'Donation history',
        Feature.rewards => 'Rewards',
        Feature.search => 'Find blood support',
        Feature.map => 'Nearby support',
        Feature.sos => 'Start an SOS request',
        Feature.contacts => 'Emergency contacts',
        Feature.upload => 'Upload report',
        Feature.reportDetail => 'CBC · 28 Jul 2026',
        Feature.trends => 'Health trends',
        Feature.notifications => 'Notifications',
        Feature.editProfile => 'Edit profile',
        Feature.certificates => 'Certificates',
        Feature.settings => 'Settings & privacy',
      };

  @override
  Widget build(BuildContext context) {
    return _Frame(
      title: title,
      actions: widget.feature == Feature.reportDetail ? [IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share_rounded))] : null,
      child: switch (widget.feature) {
        Feature.eligibility => _eligibility(),
        Feature.appointment => _appointment(),
        Feature.history => _history(),
        Feature.rewards => _rewards(),
        Feature.search => _search(),
        Feature.map => _map(),
        Feature.sos => _sos(),
        Feature.contacts => _contacts(),
        Feature.upload => _upload(),
        Feature.reportDetail => _reportDetail(),
        Feature.trends => _trends(),
        Feature.notifications => _notifications(),
        Feature.editProfile => _editProfile(),
        Feature.certificates => _certificates(),
        Feature.settings => _settings(),
      },
    );
  }

  Widget _eligibility() {
    final questions = const [
      'Are you feeling well today, without fever or a current infection?',
      'Are you between 18 and 65 years old?',
      'Has it been at least 12 weeks since your last whole-blood donation?',
    ];
    final last = option == 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('A private pre-check', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('This is not a medical assessment. Staff at the donation centre will confirm eligibility.'),
        const SizedBox(height: 28),
        LinearProgressIndicator(value: (option + 1) / 3, borderRadius: BorderRadius.circular(8)),
        const SizedBox(height: 20),
        Text('QUESTION ${option + 1} OF 3', style: const TextStyle(color: bloodRed, fontWeight: FontWeight.w900, letterSpacing: 1)),
        const SizedBox(height: 12),
        Text(questions[option], style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, height: 1.28)),
        const SizedBox(height: 28),
        _answer('Yes', Icons.check_rounded, healthGreen, () => _advance(last)),
        const SizedBox(height: 12),
        _answer('No / I’m not sure', Icons.help_outline_rounded, const Color(0xFFF08A24), _careAdvice),
        const SizedBox(height: 30),
        PrimaryButton(label: last ? 'See my result' : 'Continue', icon: Icons.arrow_forward_rounded, onPressed: () => _advance(last)),
      ],
    );
  }

  Widget _answer(String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(border: Border.all(color: color.withOpacity(.6)), borderRadius: BorderRadius.circular(18), color: color.withOpacity(.07)),
        child: Row(children: [Icon(icon, color: color), const SizedBox(width: 14), Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800))), Icon(Icons.chevron_right_rounded, color: color)]),
      ),
    );
  }

  void _advance(bool last) {
    if (last) {
      AppScope.of(context).completeEligibility();
      _dialog('You can book a visit', 'Based on this simple pre-check, you may be ready to donate. The final assessment happens at the centre.', healthGreen);
    } else {
      setState(() => option++);
    }
  }

  void _careAdvice() {
    _dialog('Please check with a professional', 'This quick check cannot determine medical eligibility. A healthcare professional at the donation centre can guide you safely.', const Color(0xFFF08A24));
  }

  Widget _appointment() {
    final slots = const [
      ('Saturday, 10 August', '10:30 AM', 'City Care Blood Drive'),
      ('Sunday, 11 August', '09:00 AM', 'Red Cross Community Centre'),
      ('Tuesday, 13 August', '04:15 PM', 'Northside Hospital'),
    ];
    final app = AppScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose a time that feels right.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Your final health screening is always performed at the donation centre.'),
        const SizedBox(height:24),
        ...List.generate(slots.length, (index) {
          final slot = slots[index];
          final selected = index == option;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => setState(() => option = index),
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: selected ? medicalBlue.withOpacity(.1) : Theme.of(context).cardColor, borderRadius: BorderRadius.circular(22), border: Border.all(color: selected ? medicalBlue : Theme.of(context).colorScheme.outlineVariant, width: selected ? 2 : 1)),
                child: Row(children: [Container(height:48, width:48, decoration: BoxDecoration(color: medicalBlue.withOpacity(.12), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.calendar_today_outlined, color: medicalBlue)), const SizedBox(width:14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(slot.$1, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height:3), Text('${slot.$2} · ${slot.$3}', style: Theme.of(context).textTheme.bodySmall)])), Icon(selected ? Icons.check_circle_rounded : Icons.circle_outlined, color: selected ? medicalBlue : null)]),
              ),
            ),
          );
        }),
        const SizedBox(height:8),
        Panel(color: healthGreen.withOpacity(.08), child: const Row(children: [Icon(Icons.tips_and_updates_outlined, color: healthGreen), SizedBox(width:12), Expanded(child: Text('Eat well, stay hydrated and bring a valid ID to your visit.'))])),
        const SizedBox(height:24),
        PrimaryButton(
          label: app.appointmentBooked ? 'Appointment booked' : 'Confirm appointment',
          icon: app.appointmentBooked ? Icons.check_circle_rounded : Icons.calendar_month_rounded,
          onPressed: app.appointmentBooked ? null : () { app.bookAppointment(); setState(() {}); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your donation appointment is confirmed.'))); },
        ),
      ],
    );
  }

  Widget _history() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your generosity, remembered.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height:22),
        const _HistoryItem('12 Jan 2026', 'City Care Centre', 'Whole blood · 450 ml'),
        const _HistoryItem('18 Sep 2025', 'Northside Hospital', 'Whole blood · 450 ml'),
        const _HistoryItem('04 Apr 2025', 'Community Health Camp', 'Whole blood · 450 ml'),
      ],
    );
  }

  Widget _rewards() {
    final points = AppScope.of(context).rewardPoints;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF6A623), Color(0xFFE47B20)]), borderRadius: BorderRadius.circular(28)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 42), const SizedBox(height:16), Text('$points points', style: const TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.w900)), const SizedBox(height:4), const Text('Heartful Helper · Level 3', style: TextStyle(color: Colors.white70)), const SizedBox(height:16), const LinearProgressIndicator(value:.68, color:Colors.white, backgroundColor:Color(0x66FFFFFF)), const SizedBox(height:7), const Text('360 points to reach Life Champion', style: TextStyle(color: Colors.white70, fontSize:12))]),
        ),
        const SizedBox(height:28),
        Text('Badges earned', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height:14),
        const Row(children: [Expanded(child: _Badge(Icons.favorite_rounded, 'First gift', bloodRed)), SizedBox(width:12), Expanded(child: _Badge(Icons.groups_rounded, 'Community', medicalBlue)), SizedBox(width:12), Expanded(child: _Badge(Icons.auto_awesome_rounded, 'Reliable', healthGreen))]),
      ],
    );
  }

  Widget _search() {
    const types = ['O+', 'O−', 'A+', 'A−', 'B+', 'B−', 'AB+', 'AB−'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Search verified availability.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Availability is illustrative in this preview. Confirm directly with the facility.'),
        const SizedBox(height:24),
        DropdownButtonFormField<String>(value:type, decoration: const InputDecoration(labelText:'Blood type', prefixIcon:Icon(Icons.bloodtype_rounded)), items: types.map((item) => DropdownMenuItem(value:item, child:Text(item))).toList(), onChanged:(value) => setState(() => type = value ?? type)),
        const SizedBox(height:14),
        const TextField(decoration: InputDecoration(labelText:'Your area', prefixIcon:Icon(Icons.location_on_outlined), hintText:'e.g. Hyderabad')),
        const SizedBox(height:22),
        PrimaryButton(label:'Search availability', icon:Icons.search_rounded, onPressed:() => setState(() {})),
        const SizedBox(height:26),
        Text('Closest matches for $type', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:12),
        const _AvailabilityCard('City Care Blood Centre', '1.2 km', 'Available', healthGreen),
        const SizedBox(height:12),
        const _AvailabilityCard('Hope Hospital', '3.8 km', 'Call to confirm', Color(0xFFF08A24)),
      ],
    );
  }

  Widget _map() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Support around you', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Map integration is represented by a safe placeholder in Phase 1.'),
        const SizedBox(height:22),
        Container(
          height:300,
          decoration: BoxDecoration(color:medicalBlue.withOpacity(.08), borderRadius:BorderRadius.circular(28), border:Border.all(color:medicalBlue.withOpacity(.22))),
          child: Stack(children: const [Center(child:Icon(Icons.map_outlined, color:medicalBlue, size:84)), _MapPin(top:70, left:85, color:bloodRed, label:'Blood bank'), _MapPin(top:145, right:65, color:healthGreen, label:'Hospital'), _MapPin(bottom:54, left:160, color:medicalBlue, label:'Camp'), Center(child:Icon(Icons.my_location_rounded, color:Colors.black87))]),
        ),
        const SizedBox(height:20),
        const _AvailabilityCard('City Care Blood Centre', '1.2 km', 'Open now', healthGreen),
        const SizedBox(height:12),
        const _AvailabilityCard('Hope Hospital', '3.8 km', 'Open now', healthGreen),
      ],
    );
  }

  Widget _sos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Panel(color:bloodRed.withOpacity(.08), child: const Row(crossAxisAlignment:CrossAxisAlignment.start, children:[Icon(Icons.warning_amber_rounded, color:bloodRed), SizedBox(width:12), Expanded(child:Text('For life-threatening symptoms, call your local emergency number first. This app is not an emergency service.'))])),
        const SizedBox(height:24),
        Text('Coordinate urgent support', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:20),
        DropdownButtonFormField<String>(value:type, decoration:const InputDecoration(labelText:'Blood type needed', prefixIcon:Icon(Icons.bloodtype_rounded)), items:const ['O+', 'O−', 'A+', 'A−', 'B+', 'B−', 'AB+', 'AB−'].map((item) => DropdownMenuItem(value:item, child:Text(item))).toList(), onChanged:(value) => setState(() => type = value ?? type)),
        const SizedBox(height:14),
        const TextField(maxLines:3, decoration:InputDecoration(labelText:'Short note for partners', hintText:'Facility, needed time and other practical details')),
        const SizedBox(height:24),
        PrimaryButton(label:'Send SOS request', icon:Icons.sos_rounded, onPressed:() { AppScope.of(context).activateEmergency(); _dialog('Request sent', 'Nearby verified partners have been notified. Keep your phone reachable and coordinate with the facility.', healthGreen); }),
      ],
    );
  }

  Widget _contacts() {
    return Column(children: [Panel(child:Row(children:[const CircleAvatar(child:Text('SP')), const SizedBox(width:14), const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text('Sravani P.', style:TextStyle(fontWeight:FontWeight.w900)), Text('Primary contact')])), IconButton(onPressed:(){}, icon:const Icon(Icons.phone_outlined))])), const SizedBox(height:12), OutlinedButton.icon(onPressed:(){}, icon:const Icon(Icons.add_rounded), label:const Text('Add emergency contact'))]);
  }

  Widget _upload() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Text('Add a health document', style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Your files stay private. This preview does not upload or store data.'),
        const SizedBox(height:26),
        Container(width:double.infinity, padding:const EdgeInsets.symmetric(vertical:40, horizontal:20), decoration:BoxDecoration(color:medicalBlue.withOpacity(.06), border:Border.all(color:medicalBlue.withOpacity(.35), width:1.5), borderRadius:BorderRadius.circular(25)), child:Column(children:[const Icon(Icons.cloud_upload_outlined, size:54, color:medicalBlue), const SizedBox(height:13), const Text('Select a PDF or image', style:TextStyle(fontWeight:FontWeight.w900)), const SizedBox(height:6), Text('CBC, prescription, scan or lab report', style:Theme.of(context).textTheme.bodySmall), const SizedBox(height:18), OutlinedButton(onPressed:(){}, child:const Text('Choose file'))])),
        const SizedBox(height:22),
        Panel(color:const Color(0xFFFFF2E4), child:const Row(crossAxisAlignment:CrossAxisAlignment.start, children:[Icon(Icons.shield_outlined, color:Color(0xFFF08A24)), SizedBox(width:12), Expanded(child:Text('Any future AI summary is educational, not a diagnosis. Speak with a qualified clinician about your results.'))])),
      ],
    );
  }

  Widget _reportDetail() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Panel(color:healthGreen.withOpacity(.08), child:const Row(crossAxisAlignment:CrossAxisAlignment.start, children:[Icon(Icons.auto_awesome_rounded, color:healthGreen), SizedBox(width:12), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text('Easy-to-read summary', style:TextStyle(fontWeight:FontWeight.w900)), SizedBox(height:6), Text('Most listed values appear within the reference ranges shown in this sample report.')]))])),
        const SizedBox(height:24),
        Text('Highlights', style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:12),
        const _ValueRow('Haemoglobin', '14.2 g/dL', '12.0–15.5', healthGreen),
        const _ValueRow('White blood cells', '7.1 × 10⁹/L', '4.0–11.0', healthGreen),
        const _ValueRow('Platelets', '236 × 10⁹/L', '150–400', healthGreen),
        const SizedBox(height:22),
        Text('What this means', style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Text('This sample view turns basic report values into plain language. It cannot account for your full history, symptoms or clinical context.'),
        const SizedBox(height:24),
        Panel(color:bloodRed.withOpacity(.07), child:const Text('This information is not a medical diagnosis. If you feel unwell or have concerns about a result, contact a qualified healthcare professional.')),
      ],
    );
  }

  Widget _trends() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Text('Your history, in context.', style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Charts show your stored records over time. Interpret trends with your clinician.'),
        const SizedBox(height:24),
        Panel(child:SizedBox(height:220, child:CustomPaint(painter:_TrendPainter(medicalBlue, Theme.of(context).colorScheme.outlineVariant), child:const Padding(padding:EdgeInsets.all(18), child:Align(alignment:Alignment.topLeft, child:Text('Haemoglobin · sample trend', style:TextStyle(fontWeight:FontWeight.w900))))))),
        const SizedBox(height:18),
        const _ValueRow('Latest value', '14.2 g/dL', '28 Jul 2026', healthGreen),
        const _ValueRow('Previous value', '13.8 g/dL', '05 May 2026', healthGreen),
      ],
    );
  }

  Widget _notifications() {
    return const Column(children:[
      _NotificationItem(Icons.calendar_month_outlined, medicalBlue, 'Donation reminder', 'You may be eligible to donate again in 12 days.', 'Today'),
      _NotificationItem(Icons.description_outlined, healthGreen, 'Report ready to review', 'Your CBC summary is ready to view.', '2d ago'),
      _NotificationItem(Icons.workspace_premium_outlined, Color(0xFFF08A24), 'New badge earned', 'You are now a Heartful Helper.', '5d ago'),
    ]);
  }

  Widget _editProfile() {
    return Column(children:[
      const CircleAvatar(radius:42, backgroundColor:Color(0xFFFFE5E7), child:Icon(Icons.person_rounded, color:bloodRed, size:44)),
      TextButton.icon(onPressed:(){}, icon:const Icon(Icons.camera_alt_outlined), label:const Text('Change photo')),
      const SizedBox(height:18),
      const TextField(decoration:InputDecoration(labelText:'Full name')),
      const SizedBox(height:14),
      const TextField(decoration:InputDecoration(labelText:'Phone number')),
      const SizedBox(height:14),
      DropdownButtonFormField<String>(value:'O+', decoration:const InputDecoration(labelText:'Blood group'), items:const ['O+', 'O−', 'A+', 'A−', 'B+', 'B−', 'AB+', 'AB−'].map((item) => DropdownMenuItem(value:item, child:Text(item))).toList(), onChanged:(_){ }),
      const SizedBox(height:24),
      PrimaryButton(label:'Save changes', icon:Icons.check_rounded, onPressed:(){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Profile changes saved.'))); Navigator.of(context).pop(); }),
    ]);
  }

  Widget _certificates() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Text('Proof of your kindness.', style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        const Text('Your donation certificates are ready whenever you need them.'),
        const SizedBox(height:24),
        const _CertificateCard('Community donor', 'January 2026', bloodRed),
        const SizedBox(height:14),
        const _CertificateCard('Three-time life giver', 'January 2026', Color(0xFFF08A24)),
      ],
    );
  }

  Widget _settings() {
    final app = AppScope.of(context);
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Text('Appearance', style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        Panel(padding:const EdgeInsets.symmetric(horizontal:18, vertical:6), child:SwitchListTile(contentPadding:EdgeInsets.zero, title:const Text('Dark appearance', style:TextStyle(fontWeight:FontWeight.w800)), subtitle:const Text('Use a comfortable dark colour scheme'), value:app.themeMode == ThemeMode.dark, onChanged:(_) => app.toggleTheme())),
        const SizedBox(height:24),
        Text('Notifications', style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        Panel(padding:const EdgeInsets.symmetric(horizontal:18, vertical:6), child:Column(children:[
          SwitchListTile(contentPadding:EdgeInsets.zero, title:const Text('Donation reminders', style:TextStyle(fontWeight:FontWeight.w800)), value:firstSwitch, onChanged:(value) => setState(() => firstSwitch = value)),
          const Divider(),
          SwitchListTile(contentPadding:EdgeInsets.zero, title:const Text('Report alerts', style:TextStyle(fontWeight:FontWeight.w800)), value:secondSwitch, onChanged:(value) => setState(() => secondSwitch = value)),
        ])),
        const SizedBox(height:24),
        Text('Privacy', style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w900)),
        const SizedBox(height:8),
        _ExploreTile(icon:Icons.privacy_tip_outlined, color:medicalBlue, title:'Privacy promise', subtitle:'Understand how data will be handled.', onTap:(){}),
        _ExploreTile(icon:Icons.delete_outline_rounded, color:bloodRed, title:'Delete account', subtitle:'Request permanent removal of your profile.', onTap:(){}),
      ],
    );
  }

  void _dialog(String title, String body, Color color) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(Icons.check_circle_rounded, color: color),
        title: Text(title),
        content: Text(body),
        actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Understood'))],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem(this.date, this.place, this.type);

  final String date;
  final String place;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(bottom:12),
      child:Panel(child:Row(crossAxisAlignment:CrossAxisAlignment.start, children:[Container(width:50, height:50, decoration:BoxDecoration(color:bloodRed.withOpacity(.1), borderRadius:BorderRadius.circular(16)), child:const Icon(Icons.favorite_rounded, color:bloodRed)), const SizedBox(width:15), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text(date, style:const TextStyle(fontWeight:FontWeight.w900)), const SizedBox(height:3), Text(place), const SizedBox(height:3), Text(type, style:Theme.of(context).textTheme.bodySmall)])), const _StatusPill(label:'Completed', color:healthGreen)])),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.icon, this.title, this.color);

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Panel(padding:const EdgeInsets.symmetric(vertical:18, horizontal:10), child:Column(children:[Icon(icon, color:color, size:28), const SizedBox(height:8), Text(title, textAlign:TextAlign.center, style:const TextStyle(fontWeight:FontWeight.w800, fontSize:12))]));
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard(this.name, this.distance, this.status, this.color);

  final String name;
  final String distance;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Panel(child:Row(children:[Container(height:48, width:48, decoration:BoxDecoration(color:color.withOpacity(.1), borderRadius:BorderRadius.circular(15)), child:Icon(Icons.local_hospital_outlined, color:color)), const SizedBox(width:14), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text(name, style:const TextStyle(fontWeight:FontWeight.w900)), const SizedBox(height:4), Text(distance, style:Theme.of(context).textTheme.bodySmall)])), _StatusPill(label:status, color:color)]));
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({this.top, this.right, this.bottom, this.left, required this.color, required this.label});

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(top:top, right:right, bottom:bottom, left:left, child:Column(mainAxisSize:MainAxisSize.min, children:[Icon(Icons.location_on_rounded, color:color, size:34), Text(label, style:TextStyle(fontSize:10, fontWeight:FontWeight.w700, color:color))]));
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow(this.name, this.value, this.range, this.color);

  final String name;
  final String value;
  final String range;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(bottom:10),
      child:Panel(padding:const EdgeInsets.symmetric(horizontal:17, vertical:14), child:Row(children:[Expanded(child:Text(name, style:const TextStyle(fontWeight:FontWeight.w800))), Column(crossAxisAlignment:CrossAxisAlignment.end, children:[Text(value, style:TextStyle(fontWeight:FontWeight.w900, color:color)), Text('Ref. $range', style:Theme.of(context).textTheme.bodySmall)])])),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem(this.icon, this.color, this.title, this.body, this.time);

  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(bottom:12),
      child:Panel(child:Row(crossAxisAlignment:CrossAxisAlignment.start, children:[Container(width:44, height:44, decoration:BoxDecoration(color:color.withOpacity(.1), borderRadius:BorderRadius.circular(14)), child:Icon(icon, color:color)), const SizedBox(width:14), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text(title, style:const TextStyle(fontWeight:FontWeight.w900)), const SizedBox(height:4), Text(body)])), Text(time, style:Theme.of(context).textTheme.bodySmall)])),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard(this.title, this.date, this.accent);

  final String title;
  final String date;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(22),
      decoration:BoxDecoration(gradient:LinearGradient(colors:[accent, accent.withOpacity(.72)]), borderRadius:BorderRadius.circular(25)),
      child:Row(children:[const Icon(Icons.workspace_premium_rounded, color:Colors.white, size:42), const SizedBox(width:15), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text(title, style:const TextStyle(color:Colors.white, fontWeight:FontWeight.w900, fontSize:18)), const SizedBox(height:4), Text('Issued $date', style:const TextStyle(color:Colors.white70))])), IconButton(onPressed:() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Download will be available with your verified records.'))), icon:const Icon(Icons.download_rounded, color:Colors.white))]),
    );
  }
}

class _TrendPainter extends CustomPainter {
  _TrendPainter(this.lineColor, this.gridColor);

  final Color lineColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = gridColor..strokeWidth = 1;
    for (var index = 1; index < 4; index++) {
      final y = 42 + (size.height - 62) * index / 4;
      canvas.drawLine(Offset(16, y), Offset(size.width - 16, y), grid);
    }
    final path = Path()
      ..moveTo(24, size.height - 48)
      ..cubicTo(size.width * .26, size.height - 100, size.width * .4, size.height - 78, size.width * .54, size.height - 112)
      ..cubicTo(size.width * .7, size.height - 150, size.width * .82, size.height - 85, size.width - 24, size.height - 135);
    canvas.drawPath(path, Paint()..color = lineColor.withOpacity(.15)..style = PaintingStyle.stroke..strokeWidth = 13..strokeCap = StrokeCap.round);
    canvas.drawPath(path, Paint()..color = lineColor..style = PaintingStyle.stroke..strokeWidth = 4..strokeCap = StrokeCap.round);
    canvas.drawCircle(Offset(size.width - 24, size.height - 135), 6, Paint()..color = lineColor);
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) => oldDelegate.lineColor != lineColor || oldDelegate.gridColor != gridColor;
}
