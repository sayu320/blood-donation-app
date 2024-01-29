import 'package:blood_donation/project1/add.dart';
import 'package:blood_donation/project1/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //creating reference to collection donor from firebase

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId){
    donor.doc(docId).delete();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Blood Donation App',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddUser(),
          ));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      //retrieving data from the backend

      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 194, 193, 193),
                            blurRadius: 10,
                            spreadRadius: 15,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(
                                donorSnap['group'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              donorSnap['name'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              donorSnap['phone'].toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)  => const UpdateDonor(),
                                  settings: RouteSettings(
                                    arguments: {
                                      'name':donorSnap['name'],
                                      'phone':donorSnap['phone'].toString(),
                                      'group':donorSnap['group'],
                                      'id':donorSnap.id,
                                    }
                                  )
                                ));
                              },
                              icon: const Icon(Icons.edit),
                              iconSize: 30,
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                deleteDonor(donorSnap.id);
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 30,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
