import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;
  WorldTime({this.location, this.flag, this.url, this.time, this.isDaytime});

  Future<void> getTime() async {
    try {
      //make the request
      http.Response response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime1 = data['datetime'].substring(0, 10);
      String datetime2 = data['datetime'].substring(11, 16);
      String datetime = datetime1 + ' ' + datetime2;
      String offset = data['utc_offset'].substring(1, 3);

      //Create date time object
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
