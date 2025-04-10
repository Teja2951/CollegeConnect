import 'package:collegeconnect/widgets/add_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SAdminScreen extends StatelessWidget{
  const SAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Super Admin'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          builder: (context) => AddBodyBottomSheet(),
        );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}