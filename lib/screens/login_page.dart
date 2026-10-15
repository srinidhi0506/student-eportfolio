import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_avatar.dart';

// StatefulWidget: this page has changing data (password visibility,
// loading flag), so it needs a State object and setState().
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // Demo credentials (local only - no database).
  static const String _validRoll = '24WH1A05A4';
  static const String _validPassword = '123456';

  // GlobalKey<FormState> lets us call validate() on the whole form.
  final _formKey = GlobalKey<FormState>();
  final _rollController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true; // password visibility toggle
  bool _isLoading = false; // shows spinner on the button

  // ANIMATION: fade-in + slide-up when the page opens.
  late final AnimationController _animController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this, // needs SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 1000),
    );
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12), // starts slightly lower
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward(); // start the animation
  }

  @override
  void dispose() {
    // Always release controllers to avoid memory leaks.
    _animController.dispose();
    _rollController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // 1) Run every validator. If any fails, error text appears under the field.
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700)); // fake loading
    if (!mounted) return; // page may have been closed while waiting

    // 2) Compare with the demo credentials.
    final ok = _rollController.text.trim().toUpperCase() == _validRoll &&
        _passwordController.text == _validPassword;

    if (ok) {
      // pushReplacementNamed removes Login from the stack,
      // so Back will not return to the login screen.
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Login failed: invalid roll number or password'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [scheme.primary, scheme.primary, scheme.primaryContainer],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          // LayoutBuilder gives the available size -> content is centred on
          // big screens and scrolls on small ones (no overflow).
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight - 48),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: FadeTransition(
                        opacity: _fade,
                        child: SlideTransition(
                          position: _slide,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const ProfileAvatar(radius: 52),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.auto_stories,
                                      color: Colors.white, size: 32),
                                  const SizedBox(width: 8),
                                  Text(
                                    'My Portfolio',
                                    style: textTheme.headlineMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Student E-Portfolio',
                                style: textTheme.titleMedium
                                    ?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 24),
                              _buildFormCard(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // ROLL NUMBER FIELD
            TextFormField(
              controller: _rollController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Roll Number',
                prefixIcon: const Icon(Icons.badge_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              // validator returns an error String, or null when input is OK.
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your roll number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // PASSWORD FIELD
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword, // hides the characters
              onFieldSubmitted: (_) => _login(),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  tooltip: 'Show / hide password',
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  // setState rebuilds the field with the new value.
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            CustomButton(
              label: 'Login',
              icon: Icons.login,
              isLoading: _isLoading,
              onPressed: _login,
            ),
            const SizedBox(height: 12),
            Text(
              'Demo login: 24WH1A05A4 / 123456',
              style: textTheme.bodySmall?.copyWith(color: scheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
