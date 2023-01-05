import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import 'search_book.dart';



final genreProvider = StateProvider<Genre>((ref) => Genre.any);
final keyWordProvider = StateProvider<String>((ref) => '');

final CollectionReference<Book> bookRef = FirebaseFirestore.instance.collection('books').withConverter<Book>(
  fromFirestore: (snapshots, _) => Book.fromJson(snapshots.data()!),
  toFirestore: (book, _) => book.toJson(),
);

final bookStream = StreamProvider<QuerySnapshot>((ref) {
  final genre = ref.watch(genreProvider);
  final keyWord = ref.watch(keyWordProvider);

  if(keyWord  == '') {
    if(genre == Genre.humanitiesAndThought) {
      return bookRef.where('genre', isEqualTo: '人文・思想').snapshots();
    } else if(genre == Genre.historyAndGeography) {
      return bookRef.where('genre', isEqualTo: '歴史・地理').snapshots();
    } else if(genre == Genre.scienceAndEngineering) {
      return bookRef.where('genre', isEqualTo: '科学・工学').snapshots();
    } else if(genre == Genre.literatureAndCriticism) {
      return bookRef.where('genre', isEqualTo: '文学・評論').snapshots();
    } else if(genre == Genre.artAndArchitecture) {
      return bookRef.where('genre', isEqualTo: 'アート・建築').snapshots();
    } else {
      return bookRef.snapshots();
    }
  } else {
    // if(genre == Genre.humanitiesAndThought) {
    //   return bookRef.where('genre', isEqualTo: '人文・思想').where('filter', isEqualTo: true).snapshots();
    // } else if(genre == Genre.historyAndGeography) {
    //   return bookRef.where('genre', isEqualTo: '歴史・地理').where('filter', isEqualTo: true).snapshots();
    // } else if(genre == Genre.scienceAndEngineering) {
    //   return bookRef.where('genre', isEqualTo: '科学・工学').where('filter', isEqualTo: true).snapshots();
    // } else if(genre == Genre.literatureAndCriticism) {
    //   return bookRef.where('genre', isEqualTo: '文学・評論').where('filter', isEqualTo: true).snapshots();
    // } else if(genre == Genre.artAndArchitecture) {
    //   return bookRef.where('genre', isEqualTo: 'アート・建築').where('filter', isEqualTo: true).snapshots();
    // } else {
    //   return bookRef.where('filter', isEqualTo: true).snapshots();
    // }
    // return bookRef.where('filter', isEqualTo: true).snapshots();
   return bookRef.snapshots();
    // return bookRef.where('genre', isEqualTo: '文学・評論').where('filter', isEqualTo: false).snapshots();
  }

  // if(genre == Genre.humanitiesAndThought) {
  //   if(keyWord == '') {
  //     return bookRef.where('genre', isEqualTo: '人文・思想').snapshots();
  //   } else {
  //     return bookRef.where('genre', isEqualTo: '人文・思想').where('filter', isEqualTo: true).snapshots();
  //   }
  // } else if(genre == Genre.historyAndGeography) {
  //   if(keyWord == '') {
  //     return bookRef.where('genre', isEqualTo: '歴史・地理').snapshots();
  //   } else {
  //     return bookRef.where('genre', isEqualTo: '歴史・地理').where('filter', isEqualTo: true).snapshots();
  //   }
  // } else if(genre == Genre.scienceAndEngineering) {
  //   if(keyWord == '') {
  //     return bookRef.where('genre', isEqualTo: '科学・工学').snapshots();
  //   } else {
  //     return bookRef.where('genre', isEqualTo: '科学・工学').where('filter', isEqualTo: true).snapshots();
  //   }
  // } else if(genre == Genre.literatureAndCriticism) {
  //   if(keyWord == '') {
  //     return bookRef.where('genre', isEqualTo: '文学・評論').snapshots();
  //   } else {
  //     return bookRef.where('genre', isEqualTo: '文学・評論').where('filter', isEqualTo: true).snapshots();
  //   }
  // } else if(genre == Genre.artAndArchitecture) {
  //   if(keyWord == '') {
  //     return bookRef.where('genre', isEqualTo: 'アート・建築').snapshots();
  //   } else {
  //     return bookRef.where('genre', isEqualTo: 'アート・建築').where('filter', isEqualTo: true).snapshots();
  //   }
  // } else {
  //   if(keyWord == '') {
  //     return bookRef.snapshots();
  //   } else {
  //     return bookRef.where('filter', isEqualTo: true).snapshots();
  //   }
  // }
});
