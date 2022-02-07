import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/themes/tema.dart';


class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticias( this.noticias );

  @override
  Widget build(BuildContext context) {
   
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index){
        return _Noticias(noticias: this.noticias[index], index: index);
      }
    );
  }
}

class _Noticias extends StatelessWidget {
  
    final Article noticias;
    final int index;

  const _Noticias({required this.noticias, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
      
        _TartejaTpBar(noticias, index),

        _TarjetaTitulo( noticias),

        _TarjetaImagen(noticias),

        _TarjetaBody(noticias),

        _TarjetaBotones(),

        SizedBox(height: 10,),
        Divider()
      
      ]
    );
  }
}


class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[

        RawMaterialButton(
          onPressed: () {},
          fillColor: miTema.colorScheme.secondary,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star_border),
        ),
       
        SizedBox(width: 10,),

        RawMaterialButton(
          onPressed: () {},
          fillColor:  Colors.blue,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.more),
        )

        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticias;
  const _TarjetaBody(this.noticias);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Text((noticias.description != null) ? noticias.description : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  
  final noticias;
  
  const _TarjetaImagen( this.noticias );



  @override
  Widget build(BuildContext context) {
    
  
    return Container(
    margin: EdgeInsets.symmetric(vertical: 15) ,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
        child: Container(
          // El codigo comentado es el cambio de condicon ternaria para poder mostrar la imagen de que no hay imagen
          // por el codigo el imageErrorBuilder, ya que la condicion no me estaba mostrando la imagen.
          child:
            /* (noticias.urlToImage != null)? */
              FadeInImage(
              imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/img/no-image.png'),),
              placeholder:AssetImage('assets/img/giphy.gif') ,
              image: NetworkImage('${noticias.urlToImage}'),
              fit: BoxFit.cover,
          )
          /*: Image(image: AssetImage('assets/img/no-image.png'),) */
        ),
      ),
    );
  }
}


class _TarjetaTitulo extends StatelessWidget {
  
  final Article noticias;
  const _TarjetaTitulo( this.noticias );

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal:15),
      child: Text(noticias.title, style: TextStyle(fontSize: 20, fontWeight:FontWeight.w500 ),),
    );
  }
}


class _TartejaTpBar extends StatelessWidget {
  
  final Article noticias;
  final int index;
  
  const _TartejaTpBar(this.noticias, this.index,);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget> [
          Text('${index + 1}. ', style: TextStyle(color:miTema.colorScheme.secondary ),),
          Text('${noticias.source.name }. ', ),
        ],
      ),

    );
  }
}