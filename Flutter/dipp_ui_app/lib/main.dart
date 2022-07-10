import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var genderOptions = ['man', 'woman', 'other'];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            FormBuilder(  //immplementace formuláře a jednotlivých zvolených částí podle návrhu
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'Text',
                    decoration: const InputDecoration(
                      labelText:
                      'Text',
                    ),
                    onChanged: null,
                    keyboardType: TextInputType.text,
                  ),
                  FormBuilderTextField(
                    name: 'Password',
                    decoration: const InputDecoration(
                      labelText:
                      'Password',
                    ),
                    obscureText: true,
                    onChanged: null,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  FormBuilderTextField(
                    name: 'Number',
                    decoration: const InputDecoration(
                      labelText:
                      'Number',
                    ),
                    onChanged: null,
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderDateTimePicker(
                    name: 'time',
                     onChanged: null,
                    inputType: InputType.time,
                    decoration: const InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    // initialValue: DateTime.now(),
                    // enabled: true,
                  ),
                  FormBuilderDateTimePicker(
                    name: 'date',
                    onChanged: null,
                    inputType: InputType.date,
                    decoration: const InputDecoration(
                      labelText: 'Appointment date',
                    ),
                    initialValue: DateTime.now(),
                    // enabled: true,
                  ),
                  FormBuilderRadioGroup(
                      name: 'radioGroup',
                      decoration: const InputDecoration(labelText: 'Radio group'),
                      options: [
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4',
                        'Option 5'
                      ].map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                  ),
                  FormBuilderDropdown(
                    name: 'gender',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: const Text('Select Gender'),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text('$gender'),
                    ))
                        .toList(),
                  ),
                  FormBuilderSwitch(
                    title: const Text('Switch'),
                    name: 'switch',
                  ),
                  FormBuilderCheckbox(
                    name: 'accept_terms',
                    initialValue: false,
                    onChanged: null,
                    title: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final stopwatch = Stopwatch()..start();
                      _formKey.currentState!.save();
                      print(_formKey.currentState!.value);
                      print('doSomething() executed in ${stopwatch.elapsed}');
                    },
                  ),
                ),
                const SizedBox(width: 20),

              ],
            )
          ],
        ),
      ),
      drawer: Drawer( //boční navigační menu
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
