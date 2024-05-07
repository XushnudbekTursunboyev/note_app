

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/presentation/screens/add/bloc/add_bloc.dart';
import 'package:note_app/app/presentation/screens/edit/bloc/edit_bloc.dart';
import 'package:note_app/app/presentation/widgets/input_text_widget.dart';
import 'package:note_app/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  final NotesModel notesModel;

  const EditScreen({super.key, required this.notesModel});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.notesModel.title;
    descriptionController.text = widget.notesModel.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBloc(),
      child: BlocConsumer<EditBloc, EditState>(
        listener: (context, state) {
          if(state is EditSuccessState) {
            stopLoading(context);
            Navigator.of(context).pop();
          }

          if(state is EditLoadingState) {
            startLoading(context);
          }

          if(state is EditErrorState) {
            stopLoading(context);
            showError(state.message, context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Edit note", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              actions: [
                IconButton(onPressed: (){
                  if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                    context.read<EditBloc>().add(ClickEditEvent(NotesModel(widget.notesModel.id, titleController.text, descriptionController.text, "${widget.notesModel.date}", true)));
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
