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
                  title: Text(myNotes[index][DBHelper.COL_NOTE_TITLE]),
                  subtitle: Text(myNotes[index][DBHelper.COL_NOTE_DESC]),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                titleController.text =
                                    myNotes[index][DBHelper.COL_NOTE_TITLE];
                                descController.text =
                                    myNotes[index][DBHelper.COL_NOTE_DESC];
                                return customBottomSheetView(
                                  context,
                                  isUpdated: true,
                                  sno: myNotes[index][DBHelper.COL_NOTE_SNO],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool isCheck = await refDB!.deleteNote(
                              sno: myNotes[index][DBHelper.COL_NOTE_SNO],
                            );
                            if (isCheck) {
                              toGetAllNotes();
                            }
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: Text("Notes not found")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descController.clear();
              return customBottomSheetView(context);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget customBottomSheetView(
    BuildContext context, {
    bool isUpdated = false,
    int sno = 0,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Text(isUpdated ? "Update Note" : "Add Note"),
          SizedBox(height: 20),
          TextFormField(controller: titleController),
          TextFormField(controller: descController),
          ElevatedButton(
            onPressed: () async {
              var title = titleController.text;
              var desc = descController.text;
              if (title.isNotEmpty && desc.isNotEmpty) {
                bool isCheck = isUpdated
                    ? await refDB!.updateNote(
                        myTitle: titleController.text,
                        myDesc: descController.text,
                        sno: sno,
                      )
                    : await refDB!.addNote(
                        myTitle: titleController.text,
                        myDesc: descController.text,
                      );
                if (isCheck) {
                  toGetAllNotes();
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isUpdated ? "No note yet" : "No note add yet",
                      ),
                    ),
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
            child: Text(isUpdated ? "Update" : "Add"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
