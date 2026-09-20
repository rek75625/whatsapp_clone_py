// import 'package:flutter/material.dart';
// import 'package:whatsapp_clone_py/db/sqflite_db/db_helper.dart';

// class ToTest extends StatefulWidget {
//   const ToTest({super.key});

//   @override
//   State<ToTest> createState() => _ToTestState();
// }

// class _ToTestState extends State<ToTest> {
//   List<Map<String, dynamic>> myNotes = [];
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descController = TextEditingController();
//   DBHelper? refDB;
//   @override
//   void initState() {
//     /// This is a lifecycle function/event so we cannot async it
//     super.initState();
//     refDB = DBHelper.getInstance;
//     toGetAllNotes();
//   }

//   void toGetAllNotes() async {
//     myNotes = await refDB!.getAllNotes();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Notes")),
//       body: myNotes.isNotEmpty
//           ? ListView.builder(
//               shrinkWrap: true,
//               itemCount: myNotes.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Text("${myNotes[index][DBHelper.COL_NOTE_SNO]}"),
//                   title: Text(myNotes[index][DBHelper.COL_NOTE_TITLE]),
//                   subtitle: Text(myNotes[index][DBHelper.COL_NOTE_DESC]),
//                   trailing: SizedBox(
//                     width: 50,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             showModalBottomSheet(
//                               context: context,
//                               builder: (context) {
//                                 titleController.text =
//                                     myNotes[index][DBHelper.COL_NOTE_TITLE];
//                                 descController.text =
//                                     myNotes[index][DBHelper.COL_NOTE_DESC];
//                                 return customBottomSheetView(
//                                   context,
//                                   isUpdated: true,
//                                   sno: myNotes[index][DBHelper.COL_NOTE_SNO],
//                                 );
//                               },
//                             );
//                           },
//                           icon: Icon(Icons.edit),
//                         ),
//                         IconButton(
//                           onPressed: () async {
//                             bool isCheck = await refDB!.deleteNote(
//                               sno: myNotes[index][DBHelper.COL_NOTE_SNO],
//                             );
//                             if (isCheck) {
//                               toGetAllNotes();
//                             }
//                           },
//                           icon: Icon(Icons.delete, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             )
//           : Center(child: Text("Notes not found")),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               titleController.clear();
//               descController.clear();
//               return customBottomSheetView(context);
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget customBottomSheetView(
//     BuildContext context, {
//     bool isUpdated = false,
//     int sno = 0,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       width: double.infinity,
//       child: Column(
//         children: [
//           Text(isUpdated ? "Update Note" : "Add Note"),
//           SizedBox(height: 20),
//           TextFormField(controller: titleController),
//           TextFormField(controller: descController),
//           ElevatedButton(
//             onPressed: () async {
//               var title = titleController.text;
//               var desc = descController.text;
//               if (title.isNotEmpty && desc.isNotEmpty) {
//                 bool isCheck = isUpdated
//                     ? await refDB!.updateNote(
//                         myTitle: titleController.text,
//                         myDesc: descController.text,
//                         sno: sno,
//                       )
//                     : await refDB!.addNote(
//                         myTitle: titleController.text,
//                         myDesc: descController.text,
//                       );
//                 if (isCheck) {
//                   toGetAllNotes();
//                 } else if (context.mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         isUpdated ? "No note yet" : "No note add yet",
//                       ),
//                     ),
//                   );
//                 }
//                 titleController.clear();
//                 descController.clear();
//                 await Future.delayed(Duration(milliseconds: 100));
//                 if (context.mounted) {
//                   Navigator.of(context).pop();
//                 }
//               }
//             },
//             child: Text(isUpdated ? "Update" : "Add"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text("Cancel"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/db/sqflite_db/db_helper.dart';

class ToTest extends StatefulWidget {
  const ToTest({super.key});

  @override
  State<ToTest> createState() => _ToTestState();
}

class _ToTestState extends State<ToTest> {
  final DBHelper database = DBHelper.getInstance;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late Future<List<Map<String, dynamic>>> notesFuture;

  @override
  void initState() {
    super.initState();

    notesFuture = _loadNotes();
  }

  Future<List<Map<String, dynamic>>> _loadNotes() {
    return database.getAllNotes();
  }

  void _refreshNotes() {
    setState(() {
      notesFuture = _loadNotes();
    });
  }

  Future<void> _deleteNote(int sno) async {
    final deleted = await database.deleteNote(sno: sno);

    if (deleted) {
      _refreshNotes();
    }
  }

  Future<void> _saveNote({
    required BuildContext sheetContext,
    required bool isUpdate,
    int? sno,
  }) async {
    final title = titleController.text.trim();
    final description = descController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(sheetContext).showSnackBar(
        const SnackBar(content: Text("Please enter title and description")),
      );
      return;
    }

    bool success;

    if (isUpdate) {
      success = await database.updateNote(
        myTitle: title,
        myDesc: description,
        sno: sno!,
      );
    } else {
      success = await database.addNote(myTitle: title, myDesc: description);
    }

    if (!mounted) return;

    if (success) {
      _refreshNotes();

      titleController.clear();
      descController.clear();

      // ignore: use_build_context_synchronously
      Navigator.pop(sheetContext);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(sheetContext).showSnackBar(
        SnackBar(
          content: Text(
            isUpdate ? "Note was not updated" : "Note was not added",
          ),
        ),
      );
    }
  }

  void _openNoteSheet({Map<String, dynamic>? note}) {
    final bool isUpdate = note != null;

    if (isUpdate) {
      titleController.text = note[DBHelper.COL_NOTE_TITLE]?.toString() ?? '';

      descController.text = note[DBHelper.COL_NOTE_DESC]?.toString() ?? '';
    } else {
      titleController.clear();
      descController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return _noteForm(
          sheetContext,
          isUpdate: isUpdate,
          sno: isUpdate ? note[DBHelper.COL_NOTE_SNO] as int : null,
        );
      },
    );
  }

  Widget _noteForm(
    BuildContext sheetContext, {
    required bool isUpdate,
    int? sno,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isUpdate ? "Update Note" : "Add Note",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _saveNote(
                      sheetContext: sheetContext,
                      isUpdate: isUpdate,
                      sno: sno,
                    );
                  },
                  child: Text(isUpdate ? "Update" : "Add"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(Map<String, dynamic> note) {
    final sno = note[DBHelper.COL_NOTE_SNO];
    final title = note[DBHelper.COL_NOTE_TITLE]?.toString() ?? '';
    final description = note[DBHelper.COL_NOTE_DESC]?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(child: Text('$sno')),

        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),

        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Edit",
              onPressed: () {
                _openNoteSheet(note: note);
              },
              icon: const Icon(Icons.edit),
            ),

            IconButton(
              tooltip: "Delete",
              onPressed: () {
                _deleteNote(sno);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notesFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(child: Text("Notes not found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return _buildNoteItem(notes[index]);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openNoteSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();

    super.dispose();
  }
}

class ToTest2 extends StatefulWidget {
  const ToTest2({super.key});

  @override
  State<ToTest2> createState() => _ToTest2State();
}

class _ToTest2State extends State<ToTest2> {
  final DBHelper database = DBHelper.getInstance;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late Future<List<Map<String, dynamic>>> notesFuture;

  @override
  void initState() {
    super.initState();

    notesFuture = _loadNotes();
  }

  Future<List<Map<String, dynamic>>> _loadNotes() {
    return database.getAllNotes();
  }

  void _refreshNotes() {
    setState(() {
      notesFuture = _loadNotes();
    });
  }

  Future<void> _deleteNote(int sno) async {
    final deleted = await database.deleteNote(sno: sno);

    if (deleted) {
      _refreshNotes();
    }
  }

  Future<void> _saveNote({
    required BuildContext sheetContext,
    required bool isUpdate,
    int? sno,
  }) async {
    final title = titleController.text.trim();
    final description = descController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(sheetContext).showSnackBar(
        const SnackBar(content: Text("Please enter title and description")),
      );
      return;
    }

    bool success;

    if (isUpdate) {
      success = await database.updateNote(
        myTitle: title,
        myDesc: description,
        sno: sno!,
      );
    } else {
      success = await database.addNote(myTitle: title, myDesc: description);
    }

    if (!mounted) return;

    if (success) {
      _refreshNotes();

      titleController.clear();
      descController.clear();

      // ignore: use_build_context_synchronously
      Navigator.pop(sheetContext);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(sheetContext).showSnackBar(
        SnackBar(
          content: Text(
            isUpdate ? "Note was not updated" : "Note was not added",
          ),
        ),
      );
    }
  }

  void _openNoteSheet({Map<String, dynamic>? note}) {
    final bool isUpdate = note != null;

    if (isUpdate) {
      titleController.text = note[DBHelper.COL_NOTE_TITLE]?.toString() ?? '';

      descController.text = note[DBHelper.COL_NOTE_DESC]?.toString() ?? '';
    } else {
      titleController.clear();
      descController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return _noteForm(
          sheetContext,
          isUpdate: isUpdate,
          sno: isUpdate ? note[DBHelper.COL_NOTE_SNO] as int : null,
        );
      },
    );
  }

  Widget _noteForm(
    BuildContext sheetContext, {
    required bool isUpdate,
    int? sno,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isUpdate ? "Update Note" : "Add Note",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _saveNote(
                      sheetContext: sheetContext,
                      isUpdate: isUpdate,
                      sno: sno,
                    );
                  },
                  child: Text(isUpdate ? "Update" : "Add"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(Map<String, dynamic> note) {
    final sno = note[DBHelper.COL_NOTE_SNO];
    final title = note[DBHelper.COL_NOTE_TITLE]?.toString() ?? '';
    final description = note[DBHelper.COL_NOTE_DESC]?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(child: Text('$sno')),

        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),

        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Edit",
              onPressed: () {
                _openNoteSheet(note: note);
              },
              icon: const Icon(Icons.edit),
            ),

            IconButton(
              tooltip: "Delete",
              onPressed: () {
                _deleteNote(sno);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notesFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(child: Text("Notes not found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return _buildNoteItem(notes[index]);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openNoteSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();

    super.dispose();
  }
}
