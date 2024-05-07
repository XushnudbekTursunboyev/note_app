import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/presentation/screens/edit/edit_screen.dart';
import 'package:note_app/app/presentation/screens/main/bloc/main_bloc.dart';
import 'package:note_app/app/presentation/widgets/notes_widget.dart';
import 'package:note_app/app/presentation/widgets/search_widget.dart';
import 'package:note_app/app/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
enum SampleItem { itemOne, itemTwo, itemThree }

class _MainScreenState extends State<MainScreen> {

  final bloc = MainBloc();
  final TextEditingController searchController = TextEditingController();
  List<NotesModel> notes = [];
  SampleItem? selectedItem;

  @override
  void initState() {
    bloc.add(MainInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if(state is MainSuccessState) {
            stopLoading(context);
            notes = state.notes;
          }

          if(state is MainLoadingState) {
            startLoading(context);
          }

          if(state is MainErrorState) {
            stopLoading(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            appBar: AppBar(
              title: Text("My notes",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              actions: [
                IconButton(onPressed: () async {
                  await Navigator.of(context).pushNamed('/add');
                  bloc.add(MainInitialEvent());
                }, icon: Icon(Icons.add)),


                PopupMenuButton<SampleItem>(
                  initialValue: selectedItem,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedItem = item;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                     PopupMenuItem<SampleItem>(
                      onTap: () {
                        bloc.add(DeleteAllNotes());
                      },
                      value: SampleItem.itemOne,
                      child: Text('Clear'),
                    ),
                  ],
                ),

              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchWidget(hint: "Search",
                    controller: searchController,
                    onChange: (bool value) {
                      value ? bloc.add(SearchEvent(searchController.text)) :  bloc.add(MainInitialEvent());
                    },),

                  Flexible(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return NotesWidget(data: notes[index],
                            onEdit: () async{
                                print('---------------vclick');
                               await Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(notesModel: notes[index]),));
                               bloc.add(MainInitialEvent());
                            },
                            onShow: () {

                            },
                            onDelete: () {
                                bloc.add(DeleteNote(notes[index].id));
                            },);
                        },))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
