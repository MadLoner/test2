import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test2/data/models/category_model.dart';
import 'package:test2/data/models/favorite_model.dart';
import 'package:test2/data/models/popular_model.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/services/riverpod/authprovider.dart';
import 'package:test2/presentation/pages/home_page.dart';
import 'package:test2/presentation/pages/main_page.dart';
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

    try {
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
            context, MaterialPageRoute(builder: (context) => MainPage()));
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
    } catch (ex) {
      log(ex.toString());
    }
  }

  static Future<List<CategoryModel>> getCategories() async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final categorieslist = await supabase.from('categories').select();
    final categories = (categorieslist as List)
        .map((item) => CategoryModel.fromMap(item))
        .toList();

    return categories.isEmpty ? List.empty() : categories;
  }

  static Future<List<SneakerModel>> getSneakers() async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final sneakerslist = await supabase.from('sneakers').select();
    final sneakers = (sneakerslist as List)
        .map((item) => SneakerModel.fromMap(item))
        .toList();

    return sneakers.isEmpty ? List.empty() : sneakers;
  }

  static Future<void> removeSneakerFavorite(String idSneaker) async {
    final supabase = GetIt.I.get<SupabaseClient>();
    final user = supabase.auth.currentUser!.id;
    log(user);
    final sneakerslist =
        await supabase.from('favorites').select().eq('user', user);
    final sneakers = (sneakerslist as List)
        .map((item) => FavoriteModel.fromMap(item))
        .toList();
    for (var item in sneakers) {
      if (item.sneaker == idSneaker) {
        await supabase.from('favorites').delete().eq('sneaker', idSneaker);
      }
    }
  }

  static Future<List<SneakerModel>> getPopularSneakers() async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final sneakerspopularlist = await supabase.from('popular').select();
    final sneakerspopular = (sneakerspopularlist as List)
        .map((item) => PopularModel.fromMap(item))
        .toList();

    final List<SneakerModel> list = [];

    for (var item in sneakerspopular) {
      final sneakerspopularlist2 =
          await supabase.from('sneakers').select().eq('id', item.sneaker);
      final sneaker = (sneakerspopularlist2 as List)
          .map((item) => SneakerModel.fromMap(item))
          .first;
      list.add(sneaker);
    }

    return list.isEmpty ? List.empty() : list;
  }

  static Future<List<SneakerModel>> getFavoriteSneakers() async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final sneakerlistuser = await supabase
        .from('favorites')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    final sneakerspopular = (sneakerlistuser as List)
        .map((item) => FavoriteModel.fromMap(item))
        .toList();

    final List<SneakerModel> list = [];

    for (var item in sneakerspopular) {
      final sneakerspopularlist2 =
          await supabase.from('sneakers').select().eq('id', item.sneaker);
      final sneaker = (sneakerspopularlist2 as List)
          .map((item) => SneakerModel.fromMap(item))
          .first;
      list.add(sneaker);
    }

    return list.isEmpty ? List.empty() : list;
  }

  static Future<bool> checkIfSneakerFavorite(String id) async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final sneakerlistuser = await supabase
        .from('favorites')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (sneakerlistuser.isNotEmpty) {
      final sneakers = (sneakerlistuser as List)
          .map((item) => FavoriteModel.fromMap(item))
          .toList();
      for (var item in sneakers) {
        if (item.sneaker == id) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<void> setSneakerFavorite(String idSneaker) async {
    int ids = 0;
    final supabase = GetIt.I.get<SupabaseClient>();
    final user = supabase.auth.currentUser!.id;
    final sneakerslist = await supabase.from('favorites').select();
    final sneakers = (sneakerslist as List)
        .map((item) => FavoriteModel.fromMap(item))
        .toList();
    ids = sneakers.length + 1;
    log(ids.toString());
    await supabase
        .from('favorites')
        .insert({'id': ids, 'sneaker': idSneaker, 'user': user});
  }

  static Future<Uint8List> getSneakerImage(String uuidSneaker) async {
    final supabase = GetIt.I.get<SupabaseClient>();

    final sneakerimage =
        await supabase.storage.from('assets').download("$uuidSneaker.png");

    return sneakerimage;
  }

  static Future<List<SneakerModel>> getSneakersCategory(int categoryId) async {
    final supabase = GetIt.I.get<SupabaseClient>();

    log(categoryId.toString());

    final sneakerslist =
        await supabase.from('sneakers').select().eq('category', categoryId);
    final sneakers = (sneakerslist as List)
        .map((item) => SneakerModel.fromMap(item))
        .toList();

    log(sneakers.toString());

    return sneakers.isEmpty ? List.empty() : sneakers;
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
