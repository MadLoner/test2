import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/functions/Authorization.dart';
import 'package:test2/presentation/widgets/mybutton.dart';
import 'package:test2/presentation/widgets/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 121, right: 20, left: 20),
              child: Column(
                children: [
                  Text(
                    'Привет!',
                    style: TextStyle(
                        fontFamily: 'New Peninim MT',
                        fontSize: 32,
                        color: MyColors.textColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      'Заполните Свои Данные Или Продолжите Через Социальные Медиа',
                      style: TextStyle(
                          fontFamily: 'New Peninim MT',
                          fontSize: 16,
                          color: MyColors.subtextdarkolor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'New Peninim MT',
                            fontSize: 16,
                            color: MyColors.subtextdarkolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextInput(
                      controller: emailcontroller,
                      isPassword: false,
                      hint: 'xyz@gmail.com'),
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Пароль',
                        style: TextStyle(
                            fontFamily: 'New Peninim MT',
                            fontSize: 16,
                            color: MyColors.subtextdarkolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextInput(
                      controller: passwordcontroller,
                      isPassword: true,
                      hint: '••••••••'),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Восстановить',
                        style: TextStyle(
                            fontFamily: 'New Peninim MT',
                            fontSize: 12,
                            color: MyColors.subtextdarkolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  MyButton(
                      onTap: () => Functions.checkField(emailcontroller.text,
                          passwordcontroller.text, context),
                      title: 'Войти',
                      color: MyColors.accentColor),
                  SizedBox(
                    height: 209,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Вы впервые? ',
                        style: TextStyle(
                            fontFamily: 'New Peninim MT',
                            fontSize: 16,
                            color: MyColors.hintColor),
                      ),
                      GestureDetector(
                        child: Text(
                          'Создать пользователя',
                          style: TextStyle(
                              fontFamily: 'New Peninim MT',
                              fontSize: 16,
                              color: MyColors.textColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
