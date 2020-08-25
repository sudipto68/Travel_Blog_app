import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelblogapp/models/postmodel.dart';
import 'package:travelblogapp/screens/blogpostdetails.dart';

import 'homepage.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _imgLinkController = TextEditingController();

  updatePost(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Blog", style: TextStyle(
        fontFamily: 'Galada',
        ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              child: Dialog(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Add New Post"),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Post title",
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _descController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Post Description",
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _imgLinkController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Post image link",
                            ),
                          ),
                          SizedBox(height: 20.0),
                          FlatButton(
                            color: Colors.blue,
                              onPressed: ()async{
                                PostModel postModel = PostModel();
                                postModel.posttitle = _titleController.text;
                                postModel.postdesc = _descController.text;
                                postModel.imglink = _imgLinkController.text;

                                String docID = Firestore.instance.collection("posts").document().documentID;
                                postModel.postid = docID;

                                await Firestore.instance.collection("posts").document(postModel.postid).setData(postModel.toMap());


                              _titleController.clear();
                              _descController.clear();
                              _imgLinkController.clear();
                              Navigator.pop(context);

                              },
                              child: Text("Add Post",style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            );
          },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("posts").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  final postindex = snapshot.data.documents[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlogPostDetails(postindex)),
                        );
                      },
                      child: Expanded(
                        child: Card(
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                child: Image.network(postindex.data['imglink']),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(postindex.data['posttitle'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Galada",
                                          ),
                                        ),
                                        //SizedBox(width: 120.0,),
                                        Row(
                                          children: <Widget>[
                                            Text("বিস্তারিত", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.0),),
                                            SizedBox(width: 3.0,),
                                            Icon(Icons.arrow_forward),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          }
         
      ),
    );
  }
}
