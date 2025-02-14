import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test2/data/models/sneaker_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, SneakerModel>>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<Map<String, SneakerModel>> {
  final Ref ref;
  CartNotifier(this.ref) : super({});

  void addToCart(SneakerModel sneaker) async {
    try {
      state.putIfAbsent(sneaker.id, () => sneaker);
      final supabase = GetIt.I.get<SupabaseClient>();
      final user = supabase.auth.currentUser!.id;
    } catch (e) {
      log(e.toString() as num);
    }
  }
}
