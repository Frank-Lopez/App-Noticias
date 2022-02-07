import 'package:flutter/material.dart';
import 'package:noticias/src/pages/tabs_pages.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/themes/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  NewsService() )
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: TabsPages()
      ),
    );
  }
}