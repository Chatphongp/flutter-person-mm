import 'package:flutter/material.dart';
import 'package:person_mm/class/constants.dart';
import 'package:person_mm/class/model.dart';

import '../createPerson.dart';

class PersonItem extends StatefulWidget {
  final Person person;
  final Function callback;
  PersonItem({Key key, this.person, this.callback}) : super(key: key);

  @override
  _PersonItemState createState() => _PersonItemState();
}

class _PersonItemState extends State<PersonItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (BuildContext context) => CreatePerson(person: widget.person,)))
              .then((value) {
                widget.callback();
          });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.deepPurple[400],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple[100],
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.person.name,
                  style: Constants.MAIN_TEXT_STYLE.copyWith(fontSize: 16),
                ),
                Text(
                  widget.person.telephoneNumber,
                  style: TextStyle(color: Colors.deepPurple[100]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
