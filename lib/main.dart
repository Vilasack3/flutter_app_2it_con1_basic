import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'screen/choose_location.dart';
import 'screen/loading.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/location': (context) => const ChooseLocation(),
      },
    ));
