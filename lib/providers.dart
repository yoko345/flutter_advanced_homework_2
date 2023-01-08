import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';


final genreProvider = StateProvider<Genre>((ref) => Genre.any);
final keyWordProvider = StateProvider<String>((ref) => '');

final CollectionReference<Book> bookRef = FirebaseFirestore.instance.collection('books').withConverter<Book>(
  fromFirestore: (snapshots, _) => Book.fromJson(snapshots.data()!),
  toFirestore: (book, _) => book.toJson(),
);

final bookStream = StreamProvider<QuerySnapshot>((ref) {
  final genre = ref.watch(genreProvider);

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

});
