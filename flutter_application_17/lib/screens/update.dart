// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_17/screens/config.dart';
// import 'package:flutter_application_17/screens/patients.dart';
// import 'package:http/http.dart' as http;

// class UpdatePatientPage extends StatefulWidget {
//   const UpdatePatientPage({super.key});

//   @override
//   State<UpdatePatientPage> createState() => _UpdatePatientPageState();
// }

// class _UpdatePatientPageState extends State<UpdatePatientPage> {
//   final _formkey = GlobalKey<FormState>();
//   late Patients patient;

//   Future<void> updatePatient(patient) async {
//     var url = Uri.http(Configure.server, "Patients/${patient.id}");
//     var resp = await http.put(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(patient.toJson()),
//     );
//     var rs = patientsFromJson("[${resp.body}]");
//     if (rs.length == 1) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Patient data updated successfully')),
//       );
//       Navigator.pop(context, "refresh");
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update patient data')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     try {
//       patient = ModalRoute.of(context)!.settings.arguments as Patients;
//       print(patient.name);
//     } catch (e) {
//       patient = Patients();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Patient Form"),
//         centerTitle: true,
//         leading: Image.network(
//           'https://cdn-icons-png.flaticon.com/128/2841/2841431.png',
//           width: 50,
//         ),
//         elevation: 5,
//         actions: <Widget>[
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context, "refresh");
//             },
//             child: Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Icon(
//                 Icons.home,
//                 color: Color.fromARGB(255, 0, 53, 96),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: Form(
//           key: _formkey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               nameInputField(),
//               genderFormInput(),
//               symtomsInputField(),
//               doctorInputField(),
//               SizedBox(
//                 height: 10,
//               ),
//               submitButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget nameInputField() {
//     return TextFormField(
//       initialValue: patients.name,
//       decoration: InputDecoration(
//           labelText: "ชื่อผู้ป่วย:",
//           labelStyle: TextStyle(color: Colors.black),
//           icon: Icon(Icons.person)),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "This field is required";
//         }
//         return null;
//       },
//       onSaved: (newValue) => patients.name = newValue,
//     );
//   }

//   Widget genderFormInput() {
//     var initGen = "ไม่ระบุ";
//     try {
//       if (!patients.gender!.isEmpty) {
//         initGen = patients.gender!;
//       }
//     } catch (e) {
//       initGen = "ไม่ระบุ";
//     }

//     return DropdownButtonFormField(
//         decoration: InputDecoration(
//             labelText: "เพศ:",
//             labelStyle: TextStyle(color: Colors.black),
//             icon: Icon(Icons.man)),
//         value: "ไม่ระบุ",
//         items: Configure.gender.map((String val) {
//           return DropdownMenuItem(
//             value: val,
//             child: Text(val),
//           );
//         }).toList(),
//         onChanged: (value) {
//           patients.gender = value;
//         },
//         onSaved: (newValue) => patients.gender = newValue,
//         );
//   }

//   Widget symtomsInputField() {
//     return TextFormField(
//       initialValue: patients.symtoms,
//       decoration: InputDecoration(
//           labelText: "อาการ:",
//           labelStyle: TextStyle(color: Colors.black),
//           icon: Icon(Icons.healing)),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "This field is required";
//         }
//         return null;
//       },
//       onSaved: (newValue) => patients.symtoms = newValue,
//     );
//   }

//   Widget doctorInputField() {
//     var initGen = "นายเเพทย์เฉลิมชัย สุขสันต์";
//     try {
//       if (!patients.doctor!.isEmpty) {
//         initGen = patients.doctor!;
//       }
//     } catch (e) {
//       initGen = "นายเเพทย์เฉลิมชัย สุขสันต์";
//     }

//     return DropdownButtonFormField(
//         decoration: InputDecoration(
//             labelText: "แพทย์ผู้รับผิดชอบ:",
//             labelStyle: TextStyle(color: Colors.black),
//             icon: Icon(Icons.man)),
//         value: "นายเเพทย์เฉลิมชัย สุขสันต์",
//         items: Configure.doctor.map((String val) {
//           return DropdownMenuItem(
//             value: val,
//             child: Text(val),
//           );
//         }).toList(),
//         onChanged: (value) {
//           patients.doctor = value;
//         },
//         onSaved: (newValue) => patients.doctor = newValue!,
//         );
//   }

//   Widget submitButton() {
//     return ElevatedButton(
//       onPressed: () async {
//         if (_formkey.currentState!.validate()) {
//           _formkey.currentState!.save();
//           print(patients.toJson().toString());
//           if (patients.id == null) {
//             await addNewUser(patients);
//           }
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => Data()));
//         }
//       },
//       child: Text("Save"),
//     );
//   }
// }
