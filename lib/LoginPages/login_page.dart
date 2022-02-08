// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, avoid_print, duplicate_ignore, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:login_with_amplify/AuthenticationPages/auth_credentials.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;

  final VoidCallback shouldShowSignUp;

  LoginPage(
      {Key? key,
      required this.didProvideCredentials,
      required this.shouldShowSignUp})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      // 3
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
          // 4
          child: Stack(children: [
            // Login Form
            _loginForm(),
            // 6
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              // ignore: deprecated_member_use
              child: FlatButton(
                  onPressed: widget.shouldShowSignUp,
                  child: Text('¿No tienes una cuenta? Regístrate aquí.')),
            )
          ])),
    );
  }

  // 5
  Widget _loginForm() {
    return Center(
      child: Container(
        child: Form(
          //  key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'images/mERP.png',
                  height: 125,
                ),
              ),
              const ListTile(
                title: Text(
                  'By MyappSoftware',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              _emailTextField(),
              const SizedBox(height: 15),
              _passwordTextField(),
              const SizedBox(height: 50),
              _bottonLogin(),
              // const SizedBox(height: 10),
              // Flexible(
              //   child: Text(
              //     'Olvidé mi contraseña',
              //     style: TextStyle(
              //         fontSize: 15,
              //         color: Colors.blueAccent,
              //         fontWeight: FontWeight.w400),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.email,
              size: 30,
            ),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
            focusColor: Colors.amber,
            hintStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
            labelStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: _passwordController,
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
            icon: const Icon(
              Icons.lock_outline,
              size: 30,
            ),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            hintStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
            labelStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye_outlined,
                size: 30,
              ),
              onPressed: () => setState(() => showPassword = !showPassword),
            ),
          ),
          obscureText: showPassword,
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Text('Iniciar Sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        color: Colors.greenAccent,
        onPressed: _login,
      );
    });
  }

  // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials =
        LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);
  }
}
