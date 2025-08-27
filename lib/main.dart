import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegeconnect/auth/view/login_screen.dart';
import 'package:collegeconnect/auth/view/signup_screen.dart';
import 'package:collegeconnect/firebase_options.dart';
import 'package:collegeconnect/home/admin_screen.dart';
import 'package:collegeconnect/home/s_admin_screen.dart';
import 'package:collegeconnect/home/student_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (userDoc.exists) {
        String roles = userDoc["role"];
        print('The role is ${roles}');
        if (roles == 'admin') {
          print('Admin');
          return "admin";
        } else if (roles == 's_admin') {
          print('Super Admin change 1');
          return "s_admin";
        } else if (roles == 'student') {
          print('student');
          return "student";
        }
      }

    } catch (e) {
      print("Error fetching user role: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<String?>(
              future: getUserRole(snapshot.data!.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
                if (roleSnapshot.hasData) {
                  if (roleSnapshot.data == "student") {
                    return StudentScreen();
                  } else if(roleSnapshot.data == "s_admin"){
                    return SAdminScreen();
                  }
                   else if(roleSnapshot.data == "admin"){
                    return AdminScreen();
                   }
                }
                print('some error determing the user brooo');
                return LoginScreen();
              },
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
