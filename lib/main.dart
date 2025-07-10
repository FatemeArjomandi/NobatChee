import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'persentation/screens/add_business_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: AddBusinessScreen(),
      ),
    ),
  );
}