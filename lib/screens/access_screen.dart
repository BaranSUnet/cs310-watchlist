import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets.dart';
import 'home_screen.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key, this.signUp = false});
  final bool signUp;

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  final _form = GlobalKey<FormState>();

  Future<void> _continue() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Preview ready'),
        content: const Text('Continue to explore Watchlist.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    if (!mounted || proceed != true) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUp = widget.signUp;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(signUp ? 'Sign up' : 'Watchlist')),
      body: ScreenBody(
        children: [
          const SizedBox(height: gap),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/images/watchlist-mark.png', width: 56),
          ),
          const SizedBox(height: gap),
          Text(
            signUp ? 'Create an account' : 'Welcome to Watchlist',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            signUp
                ? 'Start building your movie list.'
                : 'Discover movies and save your next watch.',
            style: const TextStyle(color: muted),
          ),
          const SizedBox(height: 24),
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) return 'Email is required';
                    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                        .hasMatch(email)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: gap),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    helperText: 'At least 6 characters',
                  ),
                  obscureText: true,
                  onFieldSubmitted: (_) => _continue(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) return 'Use at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _continue,
                  child: Text(signUp ? 'Create account' : 'Log in'),
                ),
                TextButton(
                  onPressed: () {
                    if (signUp) {
                      Navigator.pop(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AccessScreen(signUp: true),
                        ),
                      );
                    }
                  },
                  child: Text(
                    signUp ? 'Already registered? Log in' : 'New here? Sign up',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: gap),
          const Text(
            'Demo form. Use sample credentials.',
            style: TextStyle(color: muted),
          ),
        ],
      ),
    );
  }
}
