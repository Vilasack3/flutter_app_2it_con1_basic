import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getData() async {
    //make the request
    http.Response response = await http
        .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Vientiane'));
    Map data = jsonDecode(response.body);
    print(data);

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'];
    // print(datetime);

    //Create date time object
    DateTime now = DateTime.parse(datetime);
    now.add(Duration(hours: int.parse(offset)));
    // print(offset);
    // print(now);
  }

  String time = 'Loading...';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(
      location: 'Vientiane',
      flag: 'lao.png',
      url: 'Asia/Vientiane',
    );
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
    setState(() {
      time = instance.time ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text('Loading'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: SpinKitHourGlass(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
