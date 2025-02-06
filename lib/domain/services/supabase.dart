import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class supabaseService {
  Future<void> init() async {
    final supabase = await Supabase.initialize(
        url: 'https://vexqzgecnvbcjmxftxlr.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZleHF6Z2VjbnZiY2pteGZ0eGxyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2Njg4OTgsImV4cCI6MjA1NDI0NDg5OH0.2frQQKN2_sfYGeCo2PvBRmW4SY8Ryf04ewul0Qtad7o');
    final client = supabase.client;
    GetIt.I.registerSingleton<SupabaseClient>(client);
  }
}
