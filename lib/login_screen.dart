import 'package:flutter/material.dart';
import 'package:flutter_ble_app/register_screen.dart';

import 'form_button.dart';
import 'input_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName='LoginScreen';


  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const LoginScreen({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<LoginScreen> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    // giriş ekranının başlangıç ​​durumunu (initial state) ayarlar.
    // E-posta, şifre ve hata mesajları sıfırlanır.
    super.initState();
    email = '';
    password = '';

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    //
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'Geçersiz e-posta adresi';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Lütfen bir şifre girin';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        // Form başarıyla gönderildiğinde, email ve password'u üst seviyedeki
        // uygulamaya gönderiyoruz.
        onSubmitted!(email, password);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Hoşgeldiniz,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Devam etmek için oturum açın!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
                  /*
                  InputField içindeki TextField widget'ının
                  içerisindeki metin değiştiğinde çağrılır.
                   */
                });
              },
              labelText: 'Email',
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              onSubmitted: (val) => submit(),
              labelText: 'Şifre',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Parolanızı mı unuttunuz?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Giriş Yap',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .15,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterScreen(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "Ben yeni bir kullanıcıyım, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Üye Ol',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
