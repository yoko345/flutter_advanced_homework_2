import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'models.dart';
import 'providers.dart';
import 'search_book.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '蔵書一覧',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final keyWord = ref.watch(keyWordProvider);

  void filterController(book, String docId) async {
    await bookRef.doc(docId).update({'filter': false});

    if(keyWord != '') {
      if(book.title.contains(keyWord)) {
        await bookRef.doc(docId).update({'filter': true});
      } else if(book.description.contains(keyWord)) {
        await bookRef.doc(docId).update({'filter': true});
      }
    }

  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('蔵書一覧'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){return const SearchBook();})),
            child: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final AsyncValue<QuerySnapshot> bookDocs = ref.watch(bookStream);
                return bookDocs.when(
                  data: (books) {
                    final docs = books.docs;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          // bookRef.doc(docs[index].id).update({'filter': false});
                          filterController(docs[index].data(), docs[index].id);
                          return BookCard(book: docs[index].data());
                        }
                      ),
                    );
                  },
                  error: (err, stack) => Text('Error: $err'),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}

class BookCard extends ConsumerWidget {
  const BookCard({Key? key, required this.book}) : super(key: key);

  final dynamic book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  debugPrint('発動！！');

    // final keyWord = ref.watch(keyWordProvider);
    // if(keyWord != '') {
    //   if(book.title.contains(keyWord)) {
    //     docId.add(searchId);
    //     // FirebaseFirestore.instance.collection('books').doc(docId).update({'filter': false});
    //     // FirebaseFirestore.instance.collection('books').doc(docId).update({'filter': true});
    //   } else if(book.description.contains(keyWord)) {
    //     docId.add(searchId);
    //     // FirebaseFirestore.instance.collection('books').doc(docId).update({'filter': false});
    //     // FirebaseFirestore.instance.collection('books').doc(docId).update({'filter': true});
    //   }
    // }
    // for(int i = 0; i < docId.length; i++) {
    //   FirebaseFirestore.instance.collection('books').doc(docId[i]).update({'filter': true});
    // debugPrint(docId[i]);
    // }

    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${book.title} - ${book.author}-${book.filter}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(book.description, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
            ],
          ),
        ),
      ),
    );
  }
}
