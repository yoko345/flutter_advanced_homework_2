import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providers.dart';
import 'search_book.dart';

enum Genre{
  any,
  humanitiesAndThought,
  historyAndGeography,
  scienceAndEngineering,
  literatureAndCriticism,
  artAndArchitecture,
}

extension GenreString on Genre{
  String get string {
    switch (this) {
      case Genre.any:
        return '指定なし';
      case Genre.humanitiesAndThought:
        return '人文・思想';
      case Genre.historyAndGeography:
        return '歴史・地理';
      case Genre.scienceAndEngineering:
        return '科学・工学';
      case Genre.literatureAndCriticism:
        return '文学・評論';
      case Genre.artAndArchitecture:
        return 'アート・建築';
    }
  }
}

class Book {
  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.filter,
  });

  Book.fromJson(Map<String, Object?>  json)
    :this(
    title: json['title']! as String,
    author: json['author']! as String,
    description: json['description']! as String,
    genre: json['genre']! as String,
    filter: json['filter'] as bool,
  );

  final String title;
  final String author;
  final String description;
  final String genre;
  final bool filter;

  // Book copyWith({String? title, String? author, String? description, String? genre}) {
  //   return Book(
  //     title: title?? this.title,
  //     author: author?? this.author,
  //     description: description?? this.description,
  //     genre: genre?? this.genre,
  //   );
  // }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'genre': genre,
      'filter': filter,
    };
  }
}
