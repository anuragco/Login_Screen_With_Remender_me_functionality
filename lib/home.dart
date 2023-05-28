import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DropdownDatePickerExample(),
    );
  }
}

class DropdownDatePickerExample extends StatefulWidget {
  @override
  _DropdownDatePickerExampleState createState() =>
      _DropdownDatePickerExampleState();
}

class _DropdownDatePickerExampleState extends State<DropdownDatePickerExample> {
  String dropdownValue1 = 'Delhi';
  DateTime? selectedDate;
  String dropdownValue3 = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue1,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue1 = newValue!;
                  if (dropdownValue1 == 'Mumbai') {
                    dropdownValue3 = '19 Celsius';
                  } else {
                    dropdownValue3 = '';
                  }
                });
              },
              items: <String>[
                'Mumbai',
                'Delhi',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            if (selectedDate != null)
              Text(
                'Selected Date: ${selectedDate!.toIso8601String().split('T')[0]}',
                style: TextStyle(fontSize: 16),
              ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),

            SizedBox(width: 80),
            if (dropdownValue3.isNotEmpty)
              DropdownButton<String>(
                value: dropdownValue3,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue3 = newValue!;
                  });
                },
                items: <String>[
                  '19 Celsius',
                  '23 Celsius',
                  '28 Celsius',
                  '34 Celsius',
                  '38 Celsius',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            SizedBox(width: 100.0),
            ElevatedButton(
              onPressed: () {
                // Perform submit action with the selected values and date
                print('Selected values:');
                print('Dropdown 1: $dropdownValue1');
                if (selectedDate != null) {
                  print('Selected date: ${selectedDate!.toIso8601String().split('T')[0]}');
                }
                print('Dropdown 3: $dropdownValue3');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
