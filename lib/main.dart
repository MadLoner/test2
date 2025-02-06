import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test2/presentation/my_app.dart';
import 'package:test2/domain/services/supabase.dart';

void main() {
  supabaseService().init();
  runApp(ProviderScope(child: const MyApp()));
}
