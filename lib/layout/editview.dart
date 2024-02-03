import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/editnews_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class EditView extends StatefulWidget {
  final String id, judul, gambar, date, deskripsi;
  
  EditView(
    {required this.id, 
    required this.judul,
    required this.gambar,
    required this.date,
    required this.deskripsi});
    
  @override
  State<EditView> createState() => _EditViewState(); 
}

class _EditViewState extends State<EditView> {
  final TextEditingController _judul = TextEditingCpntroller();
  final TextEditingController _deskripsi = TextEditingCpntroller();
  final TextEditingController _date = TextEditingCpntroller();
  File? _pickedimage;
  
  void initState() {
    super.initState();
    _judul.text = widget.judul;
    _deskripsi.text = widget.deskripsi;
    _date.text = widget.date
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: text(widget.judul)), 
      body: SingleChildScrollView(
        child: Padding (
          padding: EdgeInsets.all(16), 
          child: Column(
            children: <Widget>[
              TextField(
                controller: _judul, 
                decoration: InputDecoration(labelText: "Masukan Judul"), 
              ), 
              TextField(
                controller: _deskripsi, 
                decoration: InputDecoration(labelText: "Masukan Deskripsi"), 
              ),
              TextField(
                controller: _date, 
                decoration: InputDecoration(labelText: "Masukan Tanggal"), 
                readOnly: true;
                onTap: ()async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2100));
                    
                    if (pickedDate != null) {
                      String formatteddate = 
                        DateFormat('yyyy-mm-dd').format(pickedDate);
                      setState(() {
                        _date.text = formatteddate;
                      });
                    }
                }, 
              ),
              _pickedimage != null 
              ? Image.network(
                widget.gambar,
                widht: double.infinity, 
                fit: BoxFit.cover,
                )
              : const SizedBox.shrink(), 
              _pickedimage != null
                 ? Container (
                     height: 300,
                     child: Image.file(
                       _pickedimage!, 
                       fit: BoxFit.cover, 
                     ))
                 : SizedBox.shrink(), 
              ElevatedButton(
                onPressed: ()async{
                  FilePickerResult? result = 
                    await FilePicker.platform.pickFiles(
                   type: FileType.custom, 
                  allowedExtensions: ['jpg'], 
                );
                if (result != null && result.files.isNotEmpty) {
                  setState(() {
                    _pickedimage = File(result.files.single.path);
                  });
                }
              },
              child: Text("Ambil Gambar")), 
              ElevatedButton(
                onPressed: () async {
                  if ((_pickedimage == null && widget.gambar == "") || _judul.text == "" || _deskripsi.text == "" || _date.text == "") {
                    showDialog(
                      context: context, 
                      builder: (ctx) => AlertDialog(
                        title: Text(" Tidak Ada Gambar "),
                         content: SingleChildScrollView(
                           child: ListBody(
                             children: <Widget>[
                               Text("Silahkan lengkapi data");
                             ], 
                           ), 
                         ), 
                         actions: <Widget>[
                           TextButton(
                             onPressed: () {
                               Navigator.of(context). pop();
                             }, 
                             child: Text("Ok"))
                         ], 
                      ));
                  } else {
                    final id = widget.id;
                    final title = _judul.text;
                    final content = _deskripsi.text;
                    final date = _date.text;
                    final image = _pickedimage;
                    
                    context.read<EditnewsBloc>().add(ClickEdit(
                      id: id
                      title: title, 
                      desc: content, 
                      date: date, 
                      image: image));
                  }
                }, 
                child: Text("Edit News")), 
            
            ], 
          ), 
        ), 
      ), 
    );
  }
}