class Ingredient {
  String? name;
  String? measure;

  Ingredient({
    required this.name,
    required this.measure,
  });

  //Formar el thumb con el nombre del ingrediente
  get thumb {
    String encodedName = Uri.encodeComponent(name!);
    return 'https://www.themealdb.com/images/ingredients/$encodedName.png';
  }
}
