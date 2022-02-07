import 'package:flutter/material.dart';
import 'package:noticias/src/pages/tabs1_pages.dart';
import 'package:noticias/src/pages/tabs2_pages.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPages extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _navegacionModel(),
      child: Scaffold(
        body: _paginas(),
        bottomNavigationBar: _navegacion(),
      ),
    );
  }
}

class _navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_navegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: ('para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: ('Encabezados')),
        ]);
  }
}

class _paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_navegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Tab1page(),
        Taps2Page()
      ],
    );
  }
}

class _navegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(
    valor, 
    duration: Duration(milliseconds: 250), 
    curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
