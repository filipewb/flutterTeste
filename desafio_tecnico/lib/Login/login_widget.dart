import 'package:desafio_tecnico/home/home_screen.dart';
import 'package:desafio_tecnico/widgets/privacy_policy_link.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (password.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A senha deve ter pelo menos dois caracteres'),
          ),
        );
        return;
      }

      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A senha não pode conter caracteres especiais'),
          ),
        );
        return;
      }

      if (username.length > 20 || password.length > 20) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Os campos não podem ter mais de 20 caracteres'),
          ),
        );
        return;
      }

      if (username.endsWith(' ') || password.endsWith(' ')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Os campos não podem terminar com espaço'),
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome de usuário';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Usuário',
                      hintText: '',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      helperText: '',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: '',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      helperText: '',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 40,
                    width: 30,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Entrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 10,
            bottom: 30,
            left: 0,
            right: 0,
            child: PrivacyPolicyLink(),
          ),
        ],
      ),
    );
  }
}
