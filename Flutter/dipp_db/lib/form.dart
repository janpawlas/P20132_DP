import 'package:dipp_db/mysql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget{
  const MyFormPage({Key? key}) : super(key: key);

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New entry'),
        ),
        body: Center(
          child: Form(  //formulář pro přidání
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () => onSubmit(),
                    child: const Text('Submit'))
              ],
            ),
          ),
        )
    );
  }

  onSubmit() async {
    final stopwatch = Stopwatch()..start();
    var db = Mysql();
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()){
      await db.getConnection().then((conn) async {
        await conn.query('insert into mobile (name) values (?)', [nameController.text]);  //přidání do DB po validaci
      });
      Navigator.pop(context);
    }
    print('doSomething() executed in ${stopwatch.elapsed}');
  }
}