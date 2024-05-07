
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/presentation/screens/edit/edit_screen.dart';

class NotesWidget extends StatefulWidget {
  final NotesModel data;
  final void Function() onDelete;
  final void Function() onShow;
  final void Function() onEdit;
  const NotesWidget({super.key, required this.data, required this.onDelete, required this.onShow, required this.onEdit});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onEdit,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.data.date, style: GoogleFonts.mulish(
                    textStyle: TextStyle(color: Color(0xFFACB8C8), fontSize: 14, fontWeight: FontWeight.w500)
                ),),
                Spacer(),

                IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete, color: Colors.red,)
                ),
              ],
            ),

            Text(widget.data.title, style: GoogleFonts.mulish(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
            ), overflow: TextOverflow.ellipsis, maxLines: 2,),

            Text(widget.data.description, style: GoogleFonts.mulish(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
            ), overflow: TextOverflow.ellipsis, maxLines: 3,),
          ],
        ),
      ),
    );
  }
}


