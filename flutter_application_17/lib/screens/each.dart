import 'package:flutter/material.dart';
import 'package:flutter_application_17/screens/data.dart';
import 'package:flutter_application_17/screens/patients.dart';

class EachPatient extends StatelessWidget {
  const EachPatient({super.key});

  @override
  Widget build(BuildContext context) {
    Patients patients = Patients();
    patients = ModalRoute.of(context)!.settings.arguments as Patients;

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
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "ชื่อ-สกุล",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${patients.name}",
                style: TextStyle(fontSize: 16),
              ),
              tileColor: Color.fromARGB(255, 226, 228, 228),
              contentPadding: EdgeInsets.all(5),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text(
                "เพศ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${patients.gender}",
                style: TextStyle(fontSize: 16),
              ),
              tileColor: Color.fromARGB(255, 226, 228, 228),
              contentPadding: EdgeInsets.all(5),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text(
                "อาการ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${patients.symtoms}",
                style: TextStyle(fontSize: 16),
              ),
              tileColor: Color.fromARGB(255, 226, 228, 228),
              contentPadding: EdgeInsets.all(5),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text(
                "แพทย์ผู้รับผิดชอบ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${patients.doctor}",
                style: TextStyle(fontSize: 16),
              ),
              tileColor: Color.fromARGB(255, 226, 228, 228),
              contentPadding: EdgeInsets.all(5),
            ),
            SizedBox(height: 250),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Data(), // เปลี่ยน YourNextPage() เป็นหน้าที่คุณต้องการแสดงหลังจากการตรวจสอบรหัสผ่าน
                              ),
                            );
                          },
                          child: Text("ย้อนกลับ")),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ],
              ),
            
          ],
        ),
      ),
    );
  }
}
