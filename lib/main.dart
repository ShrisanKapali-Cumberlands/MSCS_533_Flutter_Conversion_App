import 'package:flutter/material.dart';

void main() {
  runApp(FlutterConversionApp());
}

class FlutterConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Conversion App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // Setting the default values for the conversion application
  String category = 'Distance';
  String fromUnit = 'Miles';
  String toUnit = 'Kilometers';
  double result = 0;

  final _controller = TextEditingController();

  // Define the units for each category
  final units = {
    'Distance': ['Miles', 'Kilometers'],
    'Weight': ['Pounds', 'Kilograms'],
    'Temperature': ['Celsius', 'Fahrenheit'],
    'Time': ['Seconds', 'Minutes', 'Hours'],
    'Volume': ['Liters', 'Gallons'],
  };

  // Function to convert the value based on selected category and units
  void convert() {
    setState(() {
      // If the input is empty, set the value to 0
      double value = double.tryParse(_controller.text) ?? 0;

      // A switch case to handle different categories conversion
      switch (category) {
        // Conversion of Distance
        case 'Distance':
          if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
            result = value * 1.60934;
          } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
            result = value / 1.60934;
          } else {
            result = value;
          }
          break;
        // Conversion of Weight
        case 'Weight':
          if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
            result = value * 0.453592;
          } else if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
            result = value / 0.453592;
          } else {
            result = value;
          }
          break;
        // Conversion of Temperature
        case 'Temperature':
          if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
            result = (value * 9 / 5) + 32;
          } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
            result = (value - 32) * 5 / 9;
          } else {
            result = value;
          }
          break;
        // Conversion of Time
        case 'Time':
          if (fromUnit == 'Seconds' && toUnit == 'Minutes') {
            result = value / 60;
          } else if (fromUnit == 'Minutes' && toUnit == 'Seconds') {
            result = value * 60;
          } else if (fromUnit == 'Minutes' && toUnit == 'Hours') {
            result = value / 60;
          } else if (fromUnit == 'Hours' && toUnit == 'Minutes') {
            result = value * 60;
          } else if (fromUnit == 'Seconds' && toUnit == 'Hours') {
            result = value / 3600;
          } else if (fromUnit == 'Hours' && toUnit == 'Seconds') {
            result = value * 3600;
          } else {
            result = value;
          }
          break;
        // Conversion of Volume
        case 'Volume':
          if (fromUnit == 'Liters' && toUnit == 'Gallons') {
            result = value * 0.264172;
          } else if (fromUnit == 'Gallons' && toUnit == 'Liters') {
            result = value / 0.264172;
          } else {
            result = value;
          }
          break;
        // Default case if no conversion is needed
        default:
          result = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fromUnits = units[category]!;
    final toUnits = units[category]!;

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Conversion App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Convert',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Category Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: category,
                isExpanded: true,
                underline: SizedBox(),
                onChanged: (value) {
                  setState(() {
                    category = value!;
                    fromUnit = units[category]![0];
                    toUnit = units[category]![1];
                    _controller.clear();
                    result = 0;
                  });
                },
                items:
                    units.keys
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
              ),
            ),
            SizedBox(height: 20),
            // Input Field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),

              onChanged: (_) => convert(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      value: fromUnit,
                      isExpanded: true,
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          fromUnit = value!;
                          convert();
                        });
                      },
                      items:
                          fromUnits
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.compare_arrows, size: 32),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      value: toUnit,
                      isExpanded: true,
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          toUnit = value!;
                          convert();
                        });
                      },
                      items:
                          toUnits
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
            // Result Display
            SizedBox(height: 30),
            Text(
              'Result: ${result.toStringAsFixed(2)} $toUnit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
