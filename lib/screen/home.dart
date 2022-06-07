// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      data = data;
    } else {
      data = ModalRoute.of(context)?.settings.arguments as Map;
    }
    print(data);
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.png'.toString();
    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit location',
                    style: TextStyle(color: Colors.green[300]),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  data['location'],
                  style: const TextStyle(
                      fontSize: 28.0, letterSpacing: 2.0, color: Colors.white),
                ),
                const SizedBox(height: 30),
                Text(
                  data['time'],
                  style: const TextStyle(fontSize: 66.9, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
