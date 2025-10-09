class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});
}

// Dummy Data Category
final List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: "1",
    name: "Makanan",
    imageUrl: "assets/images/categories/food.png",
  ),
  CategoryModel(
    id: "2",
    name: "Pakaian",
    imageUrl: "assets/images/categories/clothes.png",
  ),
  CategoryModel(
    id: "3",
    name: "Kerajinan",
    imageUrl: "assets/images/categories/souvenir.png",
  ),
  CategoryModel(
    id: "4",
    name: "Aksesoris",
    imageUrl: "assets/images/categories/accessories.png",
  ),
  CategoryModel(
    id: "5",
    name: "Jasa",
    imageUrl: "assets/images/categories/service.png",
  ),
];
