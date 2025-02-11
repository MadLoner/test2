import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test2/domain/services/riverpod/authprovider.dart';
import 'package:test2/presentation/pages/home_page.dart';
import 'package:toastification/toastification.dart';

class Functions {
  static Future<void> checkField(String email, String password,
      BuildContext context, WidgetRef ref) async {
    if ((email.isEmpty && password.isEmpty) ||
        (email.isEmpty || password.isEmpty)) {
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        title: Text('Ошибка'),
        description: Text('Пустые поля'),
        type: ToastificationType.error,
        autoCloseDuration: Duration(seconds: 2),
      );
      return;
    }
    if (EmailValidator.validate(email)) {
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        title: Text('Успешно'),
        description: Text('Электронная почта введена верно'),
        type: ToastificationType.success,
        autoCloseDuration: Duration(seconds: 2),
      );
      ref.read(authProvider.notifier).state = true;
      await Auth(email, password, context);
      ref.read(authProvider.notifier).state = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        title: Text('Ошибка'),
        description: Text('Электронная почта введена неверно'),
        type: ToastificationType.error,
        autoCloseDuration: Duration(seconds: 2),
      );
    }
  }

  static Future<void> Auth(
      String email, String password, BuildContext context) async {
    final supabase = GetIt.I.get<SupabaseClient>();
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final User? user = res.user;
    if (user != null) {
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        title: Text('Успешно'),
        description: Text('Добро пожаловать, ${email}'),
        type: ToastificationType.success,
        autoCloseDuration: Duration(seconds: 2),
      );
    } else {
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        title: Text('Ошибка'),
        description: Text('Пользователь не найден'),
        type: ToastificationType.error,
        autoCloseDuration: Duration(seconds: 2),
      );
    }
  }
}
