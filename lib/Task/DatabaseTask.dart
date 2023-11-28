import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/student_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final TextEditingController _edtNameController = TextEditingController();
  final TextEditingController _edtAgeController = TextEditingController();
  final TextEditingController _edtSubjectController = TextEditingController();

  List<Student> studentList = [];

  bool updateStudent = false;

  @override
  void initState() {
    super.initState();
    retrieveStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Crud Operation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < studentList.length; i++) studentWidget(studentList[i])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor:Colors.white,
        onPressed: () {
          _edtNameController.text = "";
          _edtAgeController.text = "";
          _edtSubjectController.text = "";
          updateStudent = false;
          studentDialog();
        },
        child: const Icon(Icons.work),
      ),
    );
  }

  void studentDialog({String? key}) {
    String initialName = "";
    String initialAge = "";
    String initialSubject = "";

    if (updateStudent) {
      // If updating, set the initial values from the selected student
      initialName = studentList.firstWhere((student) => student.key == key).studentData!.name!;
      initialAge = studentList.firstWhere((student) => student.key == key).studentData!.age!;
      initialSubject = studentList.firstWhere((student) => student.key == key).studentData!.subject!;
    }

    _edtNameController.text = initialName;
    _edtAgeController.text = initialAge;
    _edtSubjectController.text = initialSubject;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _edtNameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _edtAgeController,
                        decoration: InputDecoration(
                          labelText: "Age",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an age';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _edtSubjectController,
                        decoration: InputDecoration(
                          labelText: "Subject",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subject';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Map<String, dynamic> data = {
                              "name": _edtNameController.text.toString(),
                              "age": _edtAgeController.text.toString(),
                              "subject": _edtSubjectController.text.toString(),
                            };

                            if (updateStudent) {
                              dbRef.child("Students").child(key!).update(data).then((value) {
                                int index = studentList.indexWhere((element) => element.key == key);
                                studentList.removeAt(index);
                                studentList.insert(index, Student(key: key, studentData: StudentData.fromJson(data)));
                                setState(() {});
                                Navigator.of(context).pop();
                              });
                            } else {
                              dbRef.child("Students").push().set(data).then((value) {
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          updateStudent ? "Update Data" : "Save Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void retrieveStudentData() {
    dbRef.child("Students").onChildAdded.listen((data) {
      StudentData studentData = StudentData.fromJson(data.snapshot.value as Map);
      Student student = Student(key: data.snapshot.key, studentData: studentData);
      studentList.add(student);
      setState(() {});
    });
  }

  void deleteStudent(String key) {
    dbRef.child("Students").child(key).remove().then((value) {
      int index = studentList.indexWhere((element) => element.key == key);
      studentList.removeAt(index);
      setState(() {});
    });
  }
  Widget studentWidget(Student student) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          _edtNameController.text = student.studentData!.name!;
          _edtAgeController.text = student.studentData!.age!;
          _edtSubjectController.text = student.studentData!.subject!;
          updateStudent = true;
          studentDialog(key: student.key);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(student.studentData!.name!),
                      Text(student.studentData!.age!),
                      Text(student.studentData!.subject!),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      deleteStudent(student.key!);
                    },
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
