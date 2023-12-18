//import 'dart:js_interop';

//import 'dart:js_interop';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
final dio = Dio();



void main() => runApp(const FormExampleApp());

class FormExampleApp extends StatelessWidget {
  const FormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        appBar: AppBar(

          title: const Text('Weather App'),
          
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          ),
        body: const Center(
          child: FormExample(),
        ),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic city;
  String theCity="";

  @override
  void initState() {
    super.initState();
    //theCity="";
    //getCity(theCity?);
    //city;
  }

  Future<void> getCity(String dato) async {

   try{
     var response = await Dio().get('https://backenweather.vercel.app/api/$dato');
    //print(response);
    response;
    city=response.data;
    //theCity=city.name;
    print(city);
    theCity=city.name;
    print(theCity);
    //return city['name'].toString();
   }catch(e){
    //print(e);
   }
    //setState(() {});
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter a city name',

            ),
            validator: (String? value) {
              if (value == null || value.isEmpty || value.length >30 || value.contains(RegExp(r'\d')) )  {
                return 'Please enter a valid text';
              }
              
              getCity(value);
              //print(city2);
              return "";
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              
              child: const Text('Submit'),
            ),
          ), 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              city?['name'].toString()??'no data' 
            ),
          ), 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              city?['sys']?['country'].toString()??'no data' 
            ),
          ),
          Padding(
            
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            
            child: Text(
              city?['weather'].toString()??'no data' 
            ),
          ), 
          Padding(
            
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            
            child: Text(
              city?['main']?['temp'].toString()??'no data' 
            ),
          ),
          Padding(
            
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            
            child: Text(
              ' °K' 
            ),
          ),  
        ],
      ),
    );
  }
}