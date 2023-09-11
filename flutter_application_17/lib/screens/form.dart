import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_17/screens/config.dart';
import 'package:flutter_application_17/screens/data.dart';
import 'package:flutter_application_17/screens/patients.dart';

import 'package:http/http.dart' as http;

class PatientsForm extends StatefulWidget {
  const PatientsForm({super.key});

  @override
  State<PatientsForm> createState() => _PatientsFormState();
}

class _PatientsFormState extends State<PatientsForm> {
  final _formkey = GlobalKey<FormState>();
  late Patients patients;

  Future<void> addNewPatient(patients) async {
    var url = Uri.http(Configure.server, "patients");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patients.toJson()));
    var rs = patientsFromJson("[${resp.body}]");

    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Future<void> updateData(patients) async {
    var url = Uri.http(Configure.server, "patients/${patients.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patients.toJson()));
    var rs = patientsFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      patients = ModalRoute.of(context)!.settings.arguments as Patients;
      print(patients.name);
    } catch (e) {
      patients = Patients();
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("User Form"),
      // ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 185, 227, 233),
              border: Border.all(
                  width: 2.0, color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(maxWidth: 400),
            height: 500,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                      "แก้ไขข้อมูลผู้ป่วย",
                      style: TextStyle(fontSize: 24),
                    ),
                ),
                  SizedBox(
                    height: 30,
                  ),
                fnameInputField(),
                genderFormInput(),
                symInputField(),
                doctorFormInput(),
      
                SizedBox(
                  height: 10,
                ),
                //submitButton(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Row(
          // ใช้ Row เพื่อจัดวางปุ่มในบรรทัดเดียวกัน
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // ปุ่มที่ 1
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Data()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 173, 224, 232)), // เปลี่ยนสีปุ่มที่นี่
                minimumSize: MaterialStateProperty.all(
                    Size(120, 40)), // เพิ่มขนาดปุ่มที่นี่
              ),
              child: Text(
                'ยกเลิก',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            SizedBox(width: 50), // ระยะห่างระหว่างปุ่ม
            ElevatedButton(
              // ปุ่มที่ 2
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            print(patients.toJson().toString());
            if (patients.id == null) {
              await addNewPatient(patients);
            } else {
              await updateData(patients);
            }
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Data(),
            ));
          }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 176, 228, 232)), // เปลี่ยนสีปุ่มที่นี่
                minimumSize: MaterialStateProperty.all(
                    Size(120, 40)), // เพิ่มขนาดปุ่มที่นี่
              ),
              child: Text(
                "บันทึก",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ]
      )));
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: patients.name,
      decoration:
          InputDecoration(labelText: "ชื่อ-สกุล", icon: Icon(Icons.person)),
      onSaved: (newValue) => patients.name = newValue,
    );
  }

  Widget genderFormInput() {
    var initGen = patients.gender ?? "ไม่ระบุ";

    return DropdownButtonFormField(
      value: initGen,
      decoration: InputDecoration(labelText: "เพศ:", icon: Icon(Icons.man)),
      items: Configure.gender.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        patients.gender = value;
      },
      onSaved: (newValue) => patients.gender = newValue,
    );
  }

  Widget symInputField() {
    return TextFormField(
      initialValue: patients.symtoms,
      decoration: InputDecoration(
        labelText: "อาการ:",
        icon: Icon(Icons.message),
      ),
      onSaved: (newValue) => patients.symtoms = newValue,
    );
  }

  Widget doctorFormInput() {
    var initGen = patients.doctor ?? "ไม่ระบุ";

    return DropdownButtonFormField(
      value: initGen,
      decoration: InputDecoration(labelText: "แพทย์ผู้รับผิดชอบ:", icon: Icon(Icons.check_box)),
      items: Configure.doctor.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        patients.doctor = value;
      },
      onSaved: (newValue) => patients.doctor = newValue,
    );
  }

  // Widget submitButton() {
  //   return ElevatedButton(
  //       onPressed: () async {
  //         if (_formkey.currentState!.validate()) {
  //           _formkey.currentState!.save();
  //           print(patients.toJson().toString());
  //           if (patients.id == null) {
  //             await addNewPatient(patients);
  //           } else {
  //             await updateData(patients);
  //           }
  //           Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) => Data(),
  //           ));
  //         }
  //       },
  //       child: Text("Save"));
  // }
}
