

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/presentation/screens/add/bloc/add_bloc.dart';
import 'package:note_app/app/presentation/widgets/input_text_widget.dart';
import 'package:note_app/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AddBloc(),
  child: BlocConsumer<AddBloc, AddState>(
  listener: (context, state) {
    if(state is AddSuccessState) {
      stopLoading(context);
      Navigator.of(context).pop();
    }

    if(state is AddLoadingState) {
      startLoading(context);
    }

    if(state is AddErrorState) {
      stopLoading(context);
      showError(state.message, context);
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add new note", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
          actions: [
            IconButton(onPressed: (){
              if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                context.read<AddBloc>().add(ClickAddEvent(NotesModel(Uuid().v4(), titleController.text, descriptionController.text, "${DateTime.now().toLocal().toString().split(' ')[0]}", true)));
              }else{
                showError('Fill in the fields', context);
              }
            }, icon: Icon(Icons.check))
          ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            InputText(label: 'Title', hint: "Enter title", controller: titleController, maxLines: 1),
            SizedBox(height: 16,),
            InputText(label: 'Description', hint: "Enter description", controller: descriptionController, maxLines: 10),
          ],
        ),
      ),
    );
  },
),
);
  }
}
