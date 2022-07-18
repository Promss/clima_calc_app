import 'package:flutter/material.dart';
import 'package:navigation_app/apps/clima/services/location.dart';
import 'package:navigation_app/apps/clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Clima extends StatefulWidget {
  const Clima({Key? key, this.city}) : super(key: key);

  final String? city;

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  String? city;

  @override
  void initState() {
    city = widget.city;
    if (city == null) {
      getData();
    } else {
      getData(city: city);
    }
    super.initState();
  }

  void getData({city}) async {
    // Getting current location Longitude and Latitude
    Location location = Location();

    if (city == null) {
      // Get current city coordinates
      await location.getGeolocation();
    } else {
      // Get coordinates of exact city instead
      NetworkHelper cityNetworkHelper = NetworkHelper(
          'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=0ae82b1b7630936c105806748134d37c');
      var coordinate = await cityNetworkHelper.getData();
      try {
        location.latitude = coordinate[0]['lat'];
        location.longitude = coordinate[0]['lon'];
        
      } catch (e) {
        await location.getGeolocation();
      }
    }

    // Getting weather data as JSON and Decode it
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=0ae82b1b7630936c105806748134d37c');

    var data = await networkHelper.getData();

    Navigator.pushNamedAndRemoveUntil(
        context, '/city_page', ModalRoute.withName('/'),
        arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 100,
        ),
      ),
    );
  }
}
