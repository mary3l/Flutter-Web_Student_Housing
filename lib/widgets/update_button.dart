import 'package:flutter/material.dart';
import 'package:flutter_finals_web/widgets/update_housing_form.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UpdateButton({Key? key, required this.onPressed}) : super(key: key);

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
                title: Text('Update Housing'),
                content: UpdateHousingForm(),
              );
            },
          );
        },
        child: Text('Update Housing'),
      ),
    );
  }
}
