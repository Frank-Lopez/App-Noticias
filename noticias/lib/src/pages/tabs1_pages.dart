import 'package:flutter/material.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1page extends StatefulWidget {
   
  const Tab1page({Key? key}) : super(key: key);

  @override
  State<Tab1page> createState() => _Tab1pageState();
}

class _Tab1pageState extends State<Tab1page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

  final headlines = Provider.of<NewsService>(context).headlines ;

      /* ListaNoticias(headlines) */

    return  Scaffold(
      body: (headlines.length == 0)
      ?Center(child:  CircularProgressIndicator(),)
      :ListaNoticias(headlines)
    );
  }

  @override
  bool get wantKeepAlive => true;
}