import 'package:flutter/material.dart';
import 'package:recipe_finder_app/app.dart';
import 'package:recipe_finder_app/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const RecipeFinderApp());
}
