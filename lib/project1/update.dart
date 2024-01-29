import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String selectedGroup = 'O+';
  
  //to add data into ui/database

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();  
  TextEditingController donorPhone = TextEditingController();   
   
   void updateDonor(docId){
    final data = {
      'name':donorName.text,
      'phone':donorPhone.text,
      'group':selectedGroup
    };
    donor.doc(docId).update(data);
   } 

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];
   
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Donors',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  label: const Text('Donor Name')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  label: const Text('Phone Number')),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: selectedGroup,
                decoration:
                    const InputDecoration(label: Text('Select Blood Group')),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedGroup = val as String;
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                updateDonor(docId);
                Navigator.pop(context);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
