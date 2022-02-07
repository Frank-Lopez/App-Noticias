
import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_models.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/themes/tema.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Taps2Page extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return  SafeArea(
      child: Scaffold(
        body: Column(
           children: <Widget> [

            _ListaCategorias(),

            if(!newsService.isLoading)
            Expanded(
            child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada!)
            
            ),
            
            if( newsService.isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Colors.cyan,),
            )
            ),

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

          final  cName = categories[index].name;

          return Container(
            child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryBuntton(categories[index]),
                SizedBox(height: 5,),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
            ),
          );
        }
        
        ),
    );
  }
}

class _CategoryBuntton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryBuntton( this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (){
       final newsService = Provider.of<NewsService>(context, listen: false);
       newsService.SelectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration( 
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == categoria.name)
          ?miTema.colorScheme.secondary
          :Colors.black54,
        ),
      ),
    );
  }
}