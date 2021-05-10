import 'package:flutter/material.dart';
import 'package:person_mm/class/constants.dart';
import 'package:person_mm/class/dbProvider.dart';
import 'package:person_mm/createPerson.dart';
import 'package:person_mm/widget/personItem.dart';

import 'class/model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Person>> personList;

  @override
  void initState() {
    super.initState();
    getPerson();
  }
  void getPerson() {
    print('get person');
    setState(() {
      personList = DBProvider.db.getAllPerson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (BuildContext context) => CreatePerson()))
              .then((value) {
            getPerson();
          });
        },
        tooltip: 'Crete Todo',
        child: Icon(Icons.add),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 150,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Welcome',
                          style: Constants.MAIN_TEXT_STYLE.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
            ),
            Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                    context: context,
                    child: FutureBuilder(
                        future: personList,
                        builder: (BuildContext context, AsyncSnapshot ss) {
                          if (ss.hasData) {
                            return ListView.builder(
                                itemCount: ss.data.length,
                                itemBuilder: (context, index) {
                                  Person p  = ss.data[index];

                                  return PersonItem(
                                    person: p,
                                    callback: getPerson,
                                  );
                                });
                          } else {
                            return Center(
                              child: Text('No Todo abvailable'),
                            );
                          }
                        })))
          ],
        ),
      ),
    );
  }
}
