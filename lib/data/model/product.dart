import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/store.dart';

class Product {
  final String id;
  final String name;
  final String categoryId;
  final int price;
  final String unit;
  final String? imageUrl;
  final String storeId;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.unit,
    this.imageUrl,
    required this.storeId,
    this.description,
  });
}

/// Extension for Product
extension ProductExtension on Product {
  /// Menampilkan 'City" sesuai "storeId" pada Product
  String getStoreCity(List<Store> stores) {
    final store = stores.firstWhere(
      (s) => s.id == storeId,
      orElse: () => Store(id: "", name: "", city: "-", phone: ""),
    );
    return store.city;
  }

  /// Mengambil data Store berdasarkan storeId
  Store? getStoreInfo(List<Store> stores) {
    try {
      return stores.firstWhere((s) => s.id == storeId);
    } catch (_) {
      return null;
    }
  }

  /// Menampilkan nama kategori sesuai "categoryId" pada Product
  String getCategoryName(List<CategoryModel> categories) {
    final category = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => CategoryModel(id: "", name: "", imageUrl: ""),
    );
    return category.name;
  }
}

/// Dummy data product
final List<Product> dummyProductList = [
  Product(
    id: "1",
    name: "Keripik Pisang",
    categoryId: "1",
    price: 25000,
    unit: "kg",
    imageUrl:
        "https://plus.unsplash.com/premium_photo-1663854478810-26b620ade38a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    storeId: "umkm1",
    description:
        "Olahan kripik pisang dari bahan baku berkualitas pisang Kepok pilihan dengan 3 macam varian rasa Original Asin, Manis dan Coklat, memberikan sensasi kerenyahan dan rasa yang khas aman di konsumsi tidak menggunakan pewarna makanan dan pemanis buatan.",
  ),
  Product(
    id: "2",
    name: "Keripik Singkong",
    categoryId: "1",
    price: 20000,
    unit: "kg",
    imageUrl:
        "https://images.unsplash.com/photo-1740993384870-0793845268e6?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    storeId: "umkm1",
    description:
        "Terbuat dari singkong pilihan digoreng menggunakan minyak yang baru dan diberi rasa yang gurih dan pedas cocok untuk teman nyemilmu.",
  ),
  Product(
    id: "3",
    name: "Bolu Nanas",
    categoryId: "1",
    price: 30000,
    unit: "box",
    imageUrl:
        "https://umkm.kedirikab.go.id/wp-content/uploads/2024/02/LAPIS-TUGU-PODANGG-bidang-pembiayaan-600x670.jpg",
    storeId: "umkm1",
    description:
        "Bolu nanas dibuat dengan nanas matang tanpa pemanis buatan, cocok untuk teman ngopi dan ngeteh anda.",
  ),
  Product(
    id: "4",
    name: "Tas Batok",
    categoryId: "3",
    price: 50000,
    unit: "pcs",
    imageUrl:
        "https://umkm.kedirikab.go.id/wp-content/uploads/2024/02/Sri-Asmorowati-600x800.jpg",
    storeId: "umkm2",
    description:
        "Tas dari bahan batok kelapa. Bahan baku di dapatkan dengan memanfaatkan limbah batok kelapa dan di proses sedemikian rupa sehingga menjadi kerajinan tangan yang mempunyai nilai jual yg tinggi.",
  ),
];
