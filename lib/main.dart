import 'package:flutter/material.dart';
import 'package:test2/presentation/my_app.dart';
import 'package:test2/presentation/services/supabase.dart';

void main() {
  supabaseService().init();
  runApp(const MyApp());
}
