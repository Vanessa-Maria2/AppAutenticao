import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _emailTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleEmailFocusChange);
    _passwordFocusNode.addListener(_handlePasswordFocusChange);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_handleEmailFocusChange);
    _passwordFocusNode.removeListener(_handlePasswordFocusChange);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _emailTouched = true;
      _passwordTouched = true;
    });

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Preencha todos os campos.');
      return;
    }

    if (!_isValidEmail(email) || password.length < 6) {
      return;
    }

    if (password != confirmPassword) {
      _showMessage('As senhas não conferem.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
    await prefs.setString('userPassword', password);
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;

    _showMessage('Cadastro salvo com sucesso.');
    Navigator.pop(context);
  }

  void _handleEmailFocusChange() {
    if (!_emailFocusNode.hasFocus) {
      setState(() => _emailTouched = true);
    }
  }

  void _handlePasswordFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      setState(() => _passwordTouched = true);
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegex.hasMatch(email);
  }

  String? get _emailErrorText {
    final email = _emailController.text.trim();

    if (!_emailTouched || email.isEmpty || _isValidEmail(email)) {
      return null;
    }

    return 'Digite um e-mail válido.';
  }

  String? get _passwordErrorText {
    final password = _passwordController.text;

    if (!_passwordTouched || password.isEmpty || password.length >= 6) {
      return null;
    }

    return 'A senha precisa ter no mínimo 6 caracteres.';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFEEF2FF),
                  child: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 30,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Criar conta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Preencha seus dados para se cadastrar',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFCBD5E1),
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  onChanged: (_) {
                    if (_emailTouched) setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'exemplo@email.com',
                    errorText: _emailErrorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFCBD5E1),
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) {
                    if (_passwordTouched) setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    errorText: _passwordErrorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFCBD5E1),
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _register(),
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFCBD5E1),
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Já tem uma conta?'),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
