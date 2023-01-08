import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'providers.dart';


class SearchBook extends ConsumerWidget {
  const SearchBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final genre = ref.watch(genreProvider);
    TextEditingController keyWordEditingController = TextEditingController();
    keyWordEditingController.text = ref.read(keyWordProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('検索条件'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            const Text('検索条件', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text('ジャンル', style: TextStyle(fontSize: 20,),),
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: Genre.any,
                  child: Text('指定なし'),
                ),
                DropdownMenuItem(
                  value: Genre.humanitiesAndThought,
                  child: Text('人文・思想'),
                ),
                DropdownMenuItem(
                  value: Genre.historyAndGeography,
                  child: Text('歴史・地理'),
                ),
                DropdownMenuItem(
                  value: Genre.scienceAndEngineering,
                  child: Text('科学・工学'),
                ),
                DropdownMenuItem(
                  value: Genre.literatureAndCriticism,
                  child: Text('文学・評論'),
                ),
                DropdownMenuItem(
                  value: Genre.artAndArchitecture,
                  child: Text('アート・建築'),
                ),
              ],
              onChanged: (value) {
                ref.read(genreProvider.notifier).state = value!;
                ref.read(keyWordProvider.notifier).state = '';
              },
              value: genre,
            ),
            const SizedBox(height: 10,),
            const Text('フィルター', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: TextField(
                controller: keyWordEditingController,
                onChanged: (value) {
                  ref.read(keyWordProvider.notifier).state = value;
                },
                decoration: const InputDecoration(labelText: 'キーワード', border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(fontSize: 12),),
            ),
          ],
        ),
      ),
    );
  }
}
