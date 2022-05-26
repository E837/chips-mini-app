import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chips_mini_app/providers/tag.dart';

class TagForm extends StatefulWidget {
  const TagForm({Key? key}) : super(key: key);

  @override
  State<TagForm> createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  final labelController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    final tags = Provider.of<Tags>(context);
    return Padding(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: InputDecoration(
                labelText: 'Tag name',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (labelController.text.isEmpty) {
                  setState(() {
                    _error = 'required';
                  });
                  return;
                }
                tags.addTag(labelController.text);
                Navigator.of(context).pop();
              },
              child: const Text('submit'),
            )
          ],
        ),
      ),
    );
  }
}
