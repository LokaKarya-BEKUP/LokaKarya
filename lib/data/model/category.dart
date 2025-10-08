class CategoryModel {
  final String id;
  final String name;
  final String imagePath;

  CategoryModel({required this.id, required this.name, required this.imagePath});
}

// Dummy Data Category
final List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: "1",
    name: "Makanan",
    imagePath: "assets/images/categories/food.png",
  ),
  CategoryModel(
    id: "2",
    name: "Pakaian",
    imagePath: "assets/images/categories/clothes.png",
  ),
  CategoryModel(
    id: "3",
    name: "Kerajinan",
    imagePath: "assets/images/categories/souvenir.png",
  ),
  CategoryModel(
    id: "4",
    name: "Aksesoris",
    imagePath: "assets/images/categories/accessories.png",
  ),
  CategoryModel(
    id: "5",
    name: "Jasa",
    imagePath: "assets/images/categories/service.png",
  ),
];
