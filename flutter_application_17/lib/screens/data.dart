import 'package:flutter/material.dart';
import 'package:flutter_application_17/screens/config.dart';
import 'package:flutter_application_17/screens/create.dart';
import 'package:flutter_application_17/screens/doctors.dart';
import 'package:flutter_application_17/screens/each.dart';
import 'package:flutter_application_17/screens/form.dart';
import 'package:flutter_application_17/screens/home.dart';
import 'package:flutter_application_17/screens/patients.dart';
import 'package:http/http.dart' as http;

class Data extends StatelessWidget {
  const Data({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientsInfo(),
    );
  }
}

class PatientsInfo extends StatefulWidget {
  const PatientsInfo({Key? key});

  @override
  _PatientsInfoState createState() => _PatientsInfoState();
}

class _PatientsInfoState extends State<PatientsInfo> {
  Widget mainBody = Container();
  bool isDeleting = false;

  List<Patients> _patientsList = [];

  @override
  void initState() {
    super.initState();
    Users users = Configure.login;
    if (users.email != null) {
      getPatients();
    }
  }

  Future<void> getPatients() async {
    var url = Uri.http(Configure.server, "patients");
    var resp = await http.get(url);
    setState(() {
      _patientsList = patientsFromJson(resp.body);
      mainBody = showPatients();
    });
    return;
  }

  Future<void> removePatients(Patients patient) async {
    var url = Uri.http(Configure.server, "Patients/${patient.id}");
    var resp = await http.delete(url);
    print(resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ข้อมูลผู้ป่วย",
          style: TextStyle(
            fontSize: 25,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 249, 248, 246),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(10.0),
            ),
          ),
        ],
      ),
      body: mainBody,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                String result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
                if (result == "refresh") {
                  getPatients();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 173, 227, 232)), // เปลี่ยนสีปุ่มที่นี่
                minimumSize: MaterialStateProperty.all(
                    Size(120, 40)), // เพิ่มขนาดปุ่มที่นี่
              ),
              child: Text(
                'ย้อนกลับ',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            SizedBox(width: 50), // ระยะห่างระหว่างปุ่ม
            ElevatedButton(
              // ปุ่มที่ 2
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Create()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 176, 224, 232)), // เปลี่ยนสีปุ่มที่นี่
                minimumSize: MaterialStateProperty.all(
                    Size(120, 40)), // เพิ่มขนาดปุ่มที่นี่
              ),
              child: Text(
                "เพิ่มข้อมูลผู้ป่วย",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showPatients() {
    return ListView.builder(
      itemCount: _patientsList.length,
      itemBuilder: (context, index) {
        Patients patients = _patientsList[index];
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromARGB(255, 176, 225, 232),
            child: ListTile(
              title: Text(
                "${patients.id}",
                style: TextStyle(fontSize: 15.0),
              ),
              subtitle: Text(
                "${patients.name},\n${patients.gender},\n${patients.symtoms},\n${patients.doctor}",
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EachPatient(),
                    settings: RouteSettings(arguments: patients),
                  ),
                );
              }, //to show info
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: isDeleting
                        ? null // ปุ่ม "Edit" ไม่ทำงานเมื่อ isDeleting เป็น true
                        : () async {
                            String result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientsForm(),
                                settings: RouteSettings(arguments: patients),
                              ),
                            );
                            if (result == "refresh") {
                              getPatients();
                            }
                          },
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(
                    width: 0.5,
                  ), // ระยะห่างระหว่างไอคอนแก้ไขและไอคอนที่คุณต้องการเพิ่ม
                  IconButton(
                    onPressed: isDeleting
                        ? null // ปุ่ม "Delete" ไม่ทำงานเมื่อ isDeleting เป็น true
                        : () async {
                            bool confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  //title: Text("ยืนยันการลบ"),
                                  content: Text("ต้องการลบข้อมูลใช่หรือไม่?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("ไม่ใช่"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("ใช่"),
                                      onPressed: () async {
                                        await removePatients(patients);
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (confirmDelete == true) {
                              getPatients();
                            }
                          },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
