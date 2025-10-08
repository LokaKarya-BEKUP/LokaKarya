class ProductList {
  final String id;
  final String name;
  final int price;
  final String unit;
  final String city;
  final String? imageUrl;

  ProductList({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.city,
    this.imageUrl,
  });
}

/// Dummy data product
final List<ProductList> dummyProductList = [
  ProductList(
    id: "1",
    name: "Keripik Pisang",
    price: 25000,
    unit: "kg",
    city: "Kediri",
    imageUrl: "https://plus.unsplash.com/premium_photo-1663854478810-26b620ade38a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
  ProductList(
    id: "2",
    name: "Keripik Singkong",
    price: 20000,
    unit: "kg",
    city: "Kediri",
    imageUrl: "https://images.unsplash.com/photo-1740993384870-0793845268e6?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ),
  ProductList(
    id: "3",
    name: "Bolu Nanas",
    price: 30000,
    unit: "box",
    city: "Kediri",
    imageUrl: "https://umkm.kedirikab.go.id/wp-content/uploads/2024/02/LAPIS-TUGU-PODANGG-bidang-pembiayaan-600x670.jpg",
  ),
  ProductList(
    id: "4",
    name: "Tas Batok",
    price: 50000,
    unit: "pcs",
    city: "Kediri",
    imageUrl: "https://umkm.kedirikab.go.id/wp-content/uploads/2024/02/Sri-Asmorowati-600x800.jpg",
  ),
];