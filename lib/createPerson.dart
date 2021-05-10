import 'package:flutter/material.dart';
import 'package:person_mm/class/dbProvider.dart';

import 'class/model.dart';

class CreatePerson extends StatefulWidget {
  final Person person;
  CreatePerson({Key key, this.person}) : super(key: key);

  @override
  _CreatePersonState createState() => _CreatePersonState();
}

class _CreatePersonState extends State<CreatePerson> {
  bool isEditMode = false;
  bool isSubmitted = false;
  TextEditingController nameController;
  TextEditingController addressController;
  TextEditingController telephoneNumberController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    telephoneNumberController = TextEditingController();

    if (widget.person != null) {
      isEditMode = true;
      nameController.text = widget.person.name;
      addressController.text = widget.person.address;
      telephoneNumberController.text = widget.person.telephoneNumber;
    }
  }
  void onSubmitted() async {
    setState(() {
      isSubmitted = true;
    });

    if (isEditMode) {
      widget.person.name = nameController.text ?? "";
      widget.person.address = addressController.text ?? "";
      widget.person.telephoneNumber = telephoneNumberController.text ?? "";
      await DBProvider.db.updatePerson(widget.person);
    } else {
      Person person = Person(id : 0, name: nameController.text ?? "", address: addressController.text ?? "", telephoneNumber: telephoneNumberController.text ?? "");
      await DBProvider.db.newPerson(person);
    }
  }

  void onTextChanged(String s) {
    setState(() {
      isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(isEditMode ? widget.person.name : 'Create Person'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints.expand(),
        child: Column ( children: [
          TextField(
            controller: nameController,
            onChanged: onTextChanged,
            decoration: InputDecoration(
              hintText: 'Full Name'
            ),
          ),
          TextField(
            controller: addressController,
            onChanged: onTextChanged,
            decoration: InputDecoration(
              hintText: 'Address'
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: onTextChanged,
            controller: telephoneNumberController,
            decoration: InputDecoration(
              hintText: 'Telephone Number'
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row (mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(onPressed: isSubmitted ? null : onSubmitted, child: Text('Submit'))
            ],),
          )
        ],),
      ),
    );
  }
}
