
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseServices{
  final String uid;
  DatabaseServices({required this.uid});

   Future updateUserDetails(String name, String department, String phone) async{
    return await FirebaseFirestore.instance.collection('teachers').doc(uid).set({
    'name': name,
    'department': department,
    'Phone Numbers': phone,
    });

  }


}