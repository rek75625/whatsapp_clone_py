import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/db/sqflite_db/db_helper.dart';

class ToTest extends StatefulWidget {
  const ToTest({super.key});

  @override
  State<ToTest> createState() => _ToTestState();
}

class _ToTestState extends State<ToTest> {
  List<Map<String, dynamic>> myNotes = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  DBHelper? refDB;
  @override
  void initState() {
    /// This is a lifecycle function/event so we cannot async it
    super.initState();
    refDB = DBHelper.getInstance;
    toGetAllNotes();
  }

  void toGetAllNotes() async {
    myNotes = await refDB!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: myNotes.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: myNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${myNotes[index][DBHelper.COL_NOTE_SNO]}"),
                  title: Text(myNotes[index][DBHelper.COL_NOTE_SNO]),
                  subtitle: Text(myNotes[index][DBHelper.COL_NOTE_SNO]),
                );
              },
            )
          : Center(child: Text("Notes not found")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                children: [
                  Text("Add Note"),
                  SizedBox(height: 20),
                  TextFormField(controller: titleController),
                  TextFormField(controller: descController),
                  ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        bool isCheck = await refDB!.addNote(
                          myTitle: titleController.text,
                          myDesc: descController.text,
                        );
                        if (isCheck) {
                          toGetAllNotes();
                        } else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No note add yet")),
                          );
                        }
                        titleController.clear();
                        descController.clear();
                        await Future.delayed(Duration(milliseconds: 100));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text("Add Note"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
