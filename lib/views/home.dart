import 'package:flutter/material.dart';
import 'package:food_api/model/reciepe.api.dart';
import 'package:food_api/model/reciepe.dart';
import 'package:food_api/views/widgets/reciepe_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu,color: Colors.black,),
              SizedBox(width: 10),
              Text('Food Reciepe',style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.black,))
            : ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
                title: _recipes[index].name,
                cookTime: _recipes[index].totalTime,
                rating: _recipes[index].rating.toString(),
                thumbnailUrl: _recipes[index].images);
          },
        ));
  }
}