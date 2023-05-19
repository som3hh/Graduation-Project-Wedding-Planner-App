import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_trace/stack_trace.dart';

class UploadPhotosPage extends StatefulWidget {
  @override
  _UploadPhotosPageState createState() => _UploadPhotosPageState();
}

class _UploadPhotosPageState extends State<UploadPhotosPage> {
  List<File> _uploadedImages = [];
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploadedImages.add(File(pickedFile.path));
      });
      // Upload the image file to Firestore or any other storage service
      // Here, we assume you have a user ID to identify the user
      // You can replace 'userId' with the actual user ID
      _userCollection.doc('userID').update({
        'photos': FieldValue.arrayUnion([pickedFile.path])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _uploadPhoto,
          child: Text('Upload Photos'),
        ),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _userCollection.doc('userID').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final photos = (snapshot.data?.data()
                  as Map<String, dynamic>?)?['photos'] as List<dynamic>?;

              if (photos == null || photos.isEmpty) {
                return Center(
                  child: Text('No photos uploaded yet.'),
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final imageUrl = photos[index].toString();
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
