import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

Person? Selectedvalue;
class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  @override
  String toString() {
    return '$name ($age)';
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> persons = [
    Person(name: 'John', age: 25),
    Person(name: 'Jane', age: 30),
    Person(name: 'Bob', age: 40),
    Person(name: 'Alice', age: 20),
    Person(name: 'David', age: 50),
    Person(name: 'Eva', age: 35),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Search Demo'),
        ),
        body: Center(
          child: UWDropDownCust(
            items: persons,
            // List of Person objects
            itemAsString: (person) => '${person.name} ${person.age.toString()}',
            onChanged: (Person? selectedPerson) {
              Selectedvalue = selectedPerson;
              //print('Selected person: $selectedPerson');
              print("selected bro: $Selectedvalue");
            },


          ),
        ),
      ),
    );
  }
}

class UWDropDownCust extends StatelessWidget {
  UWDropDownCust({
    this.items,
    this.itemAsString,
    this.onChanged,
    this.labelText,
    this.hintText,
  });

  final List<Person>? items;
  final String Function(dynamic)? itemAsString;
  final void Function(Person?)? onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    InputDecoration l_InputDecoration = InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black54, fontSize: 25),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black54, fontSize: 25),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );

    return DropdownSearch<Person>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: l_InputDecoration,
      ),
      popupProps: PopupProps.menu(
        itemBuilder: _customPopupItemBuilder,
        fit: FlexFit.tight,
        showSearchBox: true,
      ),
      dropdownBuilder: _customDropDownPrograms,
      items: items!,
      itemAsString: itemAsString,
      onChanged: onChanged,
    );
  }

  Widget _customDropDownPrograms(BuildContext context, Person? item) {
    return Container(
      child: (item == null)
          ? const ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Select Country",
                  textAlign: TextAlign.start, style: TextStyle(fontSize: 16, color: Color.fromARGB(235, 158, 158, 158))),
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Wrap(
                      spacing: 8,
                      children: [
                        Text(
                          item!.name,
                          style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _customPopupItemBuilder(BuildContext context, Person? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListTile(
              title: Wrap(
                spacing: 8,
                children: [
                  Text(
                    item!.name.toString(),
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
