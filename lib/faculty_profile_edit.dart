import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Faculty_profile_edit extends StatefulWidget {
  const Faculty_profile_edit({Key? key}) : super(key: key);

  @override
  State<Faculty_profile_edit> createState() => _Faculty_profile_editState();
}

class _Faculty_profile_editState extends State<Faculty_profile_edit> {
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Edit your Profile',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
        ),
      ),
    );
  }

  String imageUrl = '';
  //String? _selectedOption = 'STUDENT';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          // Positioned(
          //     top: -height * .15,
          //     right: -MediaQuery.of(context).size.width * .4,
          //     child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 90),
                  _title(),
                  SizedBox(
                    height: 30,
                  ),
                  imageUrl == ''
                      ? IconButton(
                          onPressed: () async {
                            /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                            /*Step 1:Pick image*/
                            //Install image_picker
                            //Import the corresponding library

                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            print('${file?.path}');

                            if (file == null) return;
                            //Import dart:core
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            /*Step 2: Upload to Firebase storage*/
                            //Install firebase_storage
                            //Import the library

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            //Handle errors/success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(file!.path));
                              //Success: get the download URL
                              String img =
                                  await referenceImageToUpload.getDownloadURL();
                              setState(() {
                                imageUrl = img;
                              });
                            } catch (error) {
                              //Some error occurred
                            }
                          },
                          icon: Icon(Icons.camera_alt))
                      : CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                  SizedBox(height: 50),
                  _entryField('Department'),
                  SizedBox(height: 10),
                  _entryField('Position'),
                  SizedBox(height: 10),
                  _entryField('Clubs'),
                  SizedBox(height: 10),
                  _entryField('Phone No'),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text('Profile Updated Succesfully'),
                              // content: Text('GeeksforGeeks'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Go to Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          'UPDATE',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
