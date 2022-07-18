import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key, this.weatherData}) : super(key: key);

  final weatherData;

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  late double temperature;
  late String status;
  late int condition;
  late String cityName;

  final _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  @override
  void dispose() {
    _cityController.dispose();

    super.dispose();
  }

  void updateUI(dynamic weatherData) {
    temperature = weatherData['main']['temp'];
    status = weatherData['weather'][0]['main'];
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Clima App'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'In $cityName it\'s $status and temperature is ${-275 + temperature.toInt()} C°',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: TextFormField(
                      validator: _cityValidator,
                      controller: _cityController,
                      maxLines: 1,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_city, color: Colors.black),
                        labelText: 'Enter city',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _formSubmit,
                    child: const Text('Check'),
                    style: ElevatedButton.styleFrom(primary: Colors.indigo),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _formSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Going to loading page with new city value
      Navigator.pushNamedAndRemoveUntil(
          context, '/clima', ModalRoute.withName('/'),
          arguments: _cityController.text);
    } else {
      // Showing warning when city is not valid
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('City is not valid'),
      ));
    }
  }

  String? _cityValidator(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value!.isEmpty) {
      return 'Name is required.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }
}
