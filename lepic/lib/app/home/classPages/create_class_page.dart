import 'package:exp/app/home/studentPages/students_page.dart';
import 'package:exp/app/home/model/class.dart';
import 'package:exp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({ Key? key, required this.database}) : super(key: key);
  final Database database;
  
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    //database.readClass();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateClassPage(database: database, key: null,),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _level_controller = TextEditingController();
  final TextEditingController _creator_controller = TextEditingController();
  String get _className => _name_controller.text;
  String get _classLevel => _level_controller.text;
  String get _creatorName => _creator_controller.text;

  // To write class informations to firestore
  Future<void> _save() async {
    final newClass = Classes(className: _className,
        classLevel: _classLevel,
        creatorName: _creatorName,
        studentList: []);
    await widget.database.addClass(newClass);
    Navigator.of(context).pop();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Class'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed:() => _save(),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }
  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        controller: _name_controller,
        decoration: InputDecoration(labelText: 'Class Name'),
      ),
      TextFormField(
        controller: _level_controller,
        decoration: InputDecoration(labelText: 'Class Level'),
      ),
      TextFormField(
        controller: _creator_controller,
        decoration: InputDecoration(labelText: 'Creator Name'),
      ),
      TextButton(onPressed: () => StudentPage.show(context),
          child: Text('Students'),)
    ];
  }
}
