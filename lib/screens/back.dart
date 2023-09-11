// //import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_14/screens/config.dart';
// import 'package:flutter_application_14/screens/home.dart';
// import 'package:flutter_application_14/screens/users.dart';
// import 'package:http/http.dart' as http;

// class Home extends StatefulWidget {
//   static const routeName = "/";
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Widget mainBody = Container();

//   List<Users> _userList = [];
//   Future<void> getUsers() async{
//     var url = Uri.http(Configure.server, "user");
//     var resp = await http.get(url);
//     setState(() {
//       _userList = usersFromJson(resp.body);
//       mainBody = showUsers();
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Users user = Configure.login;
//     if (user.id != null) {
//       getUsers();
//       //mainBody = showUsers();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       drawer: SideMenu(),
//       body: mainBody,
//     );
//   }
// }

// Widget showUsers() {
//   return ListView.builder(
//     itemCount: 10,
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text("line"),
//       );
//     },
//   );
// }
