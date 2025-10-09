class Store {
  final String id;
  final String name;
  final String city;
  final String phone;
  final String? imageUrl;

  Store({
    required this.id,
    required this.name,
    required this.city,
    required this.phone,
    this.imageUrl,
  });
}

/// Dummy data UMKM
final List<Store> dummyStores = [
  Store(
    id: "umkm1",
    name: "Dipo Chips",
    city: "Kediri",
    phone: "6285850824053",
  ),
  Store(
    id: "umkm2",
    name: "Tasmi Collection",
    city: "Kediri",
    phone: "6282332229606",
  ),
];
