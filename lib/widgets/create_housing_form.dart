import 'package:flutter/material.dart';
import 'package:flutter_finals_web/models/housing.dart';
import 'package:flutter_finals_web/services/create/housing.dart';

class CreateHousingForm extends StatefulWidget {
  @override
  _CreateHousingFormState createState() => _CreateHousingFormState();
}

class _CreateHousingFormState extends State<CreateHousingForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  bool _isPetsAllowed = false;
  bool _isVisible = false;
  bool _isVisitorsAllowed = false;
  int _pricing = 0;
  int _contactMobile = 0;
  String _contactEmail = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.5, // Set the width of the container
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
                maxLines: 3,
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Pets Allowed'),
                value: _isPetsAllowed,
                onChanged: (value) {
                  setState(() {
                    _isPetsAllowed = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Visible'),
                value: _isVisible,
                onChanged: (value) {
                  setState(() {
                    _isVisible = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Visitors Allowed'),
                value: _isVisitorsAllowed,
                onChanged: (value) {
                  setState(() {
                    _isVisitorsAllowed = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pricing'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field empty please enter pricing';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Accepts nunbers only';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pricing = int.tryParse(value!)!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Mobile'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field empty please enter contact mobile';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Accepts nunbers only';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactMobile = int.tryParse(value!)!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field empty please enter contact email';
                  }
                  if (!value.contains('@')) {
                    return 'Accepts email with "@" only';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactEmail = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newHousing = HousingModel(
                      description: _description,
                      isPetsAllowed: _isPetsAllowed,
                      isVisible: _isVisible,
                      isVisitorsAllowed: _isVisitorsAllowed,
                      name: _name,
                      pricing: _pricing,
                      contactMobile: _contactMobile,
                      contactEmail: _contactEmail,
                    );

                    CreateHousingService createHousingService =
                        CreateHousingService();
                    createHousingService.addHousing(newHousing);
                    _formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('New housing added'),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateHousingForm(),
  ));
}