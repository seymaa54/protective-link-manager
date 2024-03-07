import 'package:flutter/material.dart';

import 'form_button.dart';
import 'input_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  final Function(String? email, String? password, String? name,
      String? lastName, String? phone, String? tc)? onSubmitted;

  const RegisterScreen({this.onSubmitted, Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email, password, confirmPassword, name, lastName, phone, tc;
  String? emailError,
      passwordError,
      nameError,
      lastNameError,
      phoneError,
      tcError;

  Function(String? email, String? password, String? name, String? lastName,
      String? phone, String? tc)? get onSubmitted => widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    name = '';
    lastName = '';
    tc = '';
    phone = '';
    email = '';
    password = '';
    confirmPassword = '';

    emailError = null;
    passwordError = null;
    nameError = null;
    lastNameError = null;
    phoneError = null;
    tcError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      nameError = null;
      lastNameError = null;
      phoneError = null;
      tcError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    RegExp phoneExp = RegExp(r'^[0-9]{10}$');

    bool isValid = true;

    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'Geçersiz e-posta adresi';
      });
      isValid = false;
    }

    if (phone.isEmpty || !phoneExp.hasMatch(phone)) {
      setState(() {
        phoneError = 'Telefon numarası geçersiz';
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = 'Lütfen bir şifre girin';
      });
      isValid = false;
    } else {
      if (password != confirmPassword) {
        setState(() {
          passwordError = 'Parolalar eşleşmiyor';
        });
        isValid = false;
      }
    }

    if (tc.length != 11) {
      setState(() {
        tcError = 'Kimlik Numarası 11 karakter olmalıdır';
      });
      isValid = false;
    } else {
      if (tc.startsWith('0')) {
        setState(() {
          tcError = 'Kimlik Numarası 0 ile başlayamaz';
        });
        isValid = false;
      } else {
        int sum = 0;
        for (int i = 0; i < 10; i++) {
          sum += int.parse(tc[i]);
        }

        int lastDigit = int.parse(tc[10]);
        if (sum % 10 != lastDigit) {
          setState(() {
            tcError = 'Kimlik Numarası Hatalı';
          });
          isValid = false;
        }
      }
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(email, password, name, lastName, tc, phone);
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
              'Hesap Oluştur,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Başlamak için kaydolun!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'İsim',
              errorText: nameError,
              // obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'Soyisim',
              errorText: lastNameError,
              //  obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  tc = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'TC Kimlik Numarası',
              errorText: tcError,
              //  obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
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
                  phone = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'Telefon',
              errorText: phoneError,
              prefixText: '+90',
              // obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              labelText: 'Şifre',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              onSubmitted: (value) => submit(),
              labelText: 'Şifreyi Onayla',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Üye Ol',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .125,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: const TextSpan(
                  text: "Zaten üyeyim, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Kayıt Ol',
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
