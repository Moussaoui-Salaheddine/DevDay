import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Notes(),
    //the remove the debug banner
    debugShowCheckedModeBanner: false,
  ));
}

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  //the note list
  static List<String> noteContent = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: noteContent.length,
        itemBuilder: (context, index) {
          Random random = Random();
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(random.nextInt(255),
                  random.nextInt(255), random.nextInt(255), 1.0),
              radius: 30,
              child: Text(
                (index.toString()).substring(0, 1),
                style: TextStyle(fontSize: 28),
              ),
            ),
            title: Text('Note #' + (index + 1).toString()),
            subtitle: Text(noteContent[index]),
            trailing: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  noteContent.remove(noteContent[index]);
                });
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text('My Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Page2();
          }));
        },
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  TextEditingController notescontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //the second page that adds a note
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("create note"),
      ),
      body: Container(
        alignment: Alignment.center,
        //color: Colors.blueAccent,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(30),
        child: Column(
          //Using a column because the textField and the button are aligned vertically
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //The textField to enter your notes
            TextField(
              controller: notescontroller,
              decoration: InputDecoration(labelText: 'enter your note here'),
            ),
            RaisedButton(
              child: Text(
                "save",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              color: Colors.red,
              splashColor: Colors.blue,
              onPressed: () {
                //Test if the text is empty
                if (notescontroller.text.length != 0) {
                  //Add the text to the note list
                  _NotesState.noteContent.add(notescontroller.text);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
      //Exit floating action Button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
