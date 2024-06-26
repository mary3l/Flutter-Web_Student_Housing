import 'package:flutter/material.dart';
import 'package:flutter_finals_web/widgets/create_housing_form.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Create New Housing',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: CreateHousingForm(),
              );
            },
          );
        },
        child: Text('Create New Housing'),
      ),
    );
  }
}
