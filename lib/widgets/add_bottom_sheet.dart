import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBodyBottomSheet extends StatefulWidget {
  @override
  State<AddBodyBottomSheet> createState() => _AddBodyBottomSheetState();
}

class _AddBodyBottomSheetState extends State<AddBodyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  Future<void> createBody() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();

    try {
      await FirebaseFirestore.instance.collection('bodies').add({
        'name': name,
        'description': desc,
        'admin':[],

      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student Body Created Successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Create New Student Body", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Body Name'),
                validator: (val) => val == null || val.isEmpty ? 'Enter body name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text("Create"),
                      onPressed: createBody,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
