import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Information',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const UserInfoScreen(),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // ignore: prefer_final_fields, unused_field
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person),
  ];
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _address = '';
  String _gender = 'Male';
  DateTime _dob = DateTime.now();
  double _weight = 0.0;
  double _height = 0.0;

  Widget _userInformationWidget = Container();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Calculate age
      int age = DateTime.now().year - _dob.year;

      // Calculate BMI
      double bmi = _weight / ((_height / 100) * (_height / 100));

      // Define threshold value for BMI
      double threshold = 25.0;

      // Comment based on BMI
      String comment = bmi >= threshold
          ? 'You are overweight.'
          : bmi < 18.5
              ? 'You are underweight.'
              : 'You have a healthy weight.';

      // Display user information below the submit button
      setState(() {
        _userInformationWidget = Center(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.white30,
                  width: 5.0,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$_username' " 's information",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                Text('Name: $_username'),
                Text('Address: $_address'),
                Text('Gender: $_gender'),
                Text('Date of Birth: ${DateFormat('dd/MM/yyyy').format(_dob)}'),
                Text('Weight: $_weight Kgs'),
                Text('Height: $_height CMs'),
                Text('Age: $age'),
                Text('BMI: ${bmi.toStringAsFixed(2)}'),
                Text('Comment: $comment'),
              ],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 151, 202, 226),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.black,
        title: const Text('BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal,
                Color.fromARGB(255, 26, 152, 210),
                Colors.teal,
                Color.fromARGB(255, 26, 152, 210)
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  labelText: 'Name',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  labelText: 'Address',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(
                    30), // Set the desired background color
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors
                                .blue, // Set the desired color for unselected radio buttons
                          ),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              const Text(
                                'Male',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors
                                .blue, // Set the desired color for unselected radio buttons
                          ),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                              const Text(
                                'Female',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'Date of Birth',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 300,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _dob,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dob = pickedDate;
                          });
                        }
                      },
                      child: const Text(
                        'Select Date',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  labelText: 'Weight (in Kgs)',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = double.parse(value!);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  labelText: 'Height (in CMs)',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter height.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _height = double.parse(value!);
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ),
              _userInformationWidget,
            ],
          ),
        ),
      ),
    );
  }
}
