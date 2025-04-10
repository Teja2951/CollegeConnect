import 'package:collegeconnect/widgets/add_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BodyTile extends StatelessWidget {
  final String bodyId;
  final String name;
  final String description;

  const BodyTile({
    required this.bodyId,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.person_add_alt_1),
                  label: Text("Add Admins"),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => AddAdminsScreen(bodyId: bodyId, bodyName: name),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey[700]),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (ctx) => AddBodyBottomSheet()
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
