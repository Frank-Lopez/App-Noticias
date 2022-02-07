import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias/src/models/category_models.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:http/http.dart' as http;

  final _URL_NEWS = 'https://newsapi.org/v2';
  final _APIKEY = '6be54e8b37e54bc8aa93caecbb9daaea';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.heartbeat, 'health'),
    Category(FontAwesomeIcons.atom, 'science'),
    Category(FontAwesomeIcons.futbol, 'sports'),
    Category(FontAwesomeIcons.laptopCode, 'technology'),

  ];
  
  Map<String, List<Article>> CategoryArticles = {};

  NewsService(){
 
    this.getTopHeadLines();

    categories.forEach((item) { 
      this.CategoryArticles[item.name] = [];

    });
      this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;
  set SelectedCategory(String valor){
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);

    notifyListeners();
  }


 List<Article>? get getArticulosCategoriaSeleccionada => this.CategoryArticles[this.selectedCategory];


  getTopHeadLines() async {

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar');
    final resp = await  http.get(url);

    final newsResponse = newsResponsesFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
  


  getArticlesByCategory( String category) async {

    if(this.CategoryArticles[category]!.length > 0){

      return this.CategoryArticles[category];
    }

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar&category=$category');
    final resp = await  http.get(url);

    final newsResponse = newsResponsesFromJson(resp.body);
    this.CategoryArticles[category]!.addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}