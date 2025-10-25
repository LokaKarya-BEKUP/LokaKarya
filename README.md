# LokaKarya 🛍️

<div align="center">

**Platform Digital untuk UMKM Lokal Indonesia**

Menghubungkan pelaku ekonomi kreatif dengan masyarakat dan wisatawan melalui aplikasi mobile yang minimalis dan mudah digunakan.

</div>

---

## 📖 Tentang LokaKarya

**LokaKarya** adalah aplikasi mobile berbasis Flutter yang dirancang untuk meningkatkan visibilitas dan aksesibilitas produk UMKM lokal. Aplikasi ini menjadi jembatan antara pelaku ekonomi kreatif dengan konsumen, memudahkan mereka untuk mempromosikan dan menemukan produk-produk unik lokal.

### 🎯 Tujuan

- Meningkatkan visibilitas produk UMKM lokal
- Memudahkan masyarakat dan wisatawan menemukan produk lokal
- Mendukung pertumbuhan ekonomi kreatif Indonesia
- Menyediakan platform digital yang mudah diakses untuk UMKM

---


## Fitur Utama


- 🔍 **Jelajahi Produk** - Temukan berbagai produk UMKM lokal
- 📱 **Detail Produk** - Lihat informasi lengkap produk dan profil penjual
- 🗂️ **Kategori** - Filter produk berdasarkan kategori
- ❤️ **Favorit** - Simpan produk favorit untuk akses cepat

## Fitur Tambahan
- 🔐 **Authentication** - Login/Register dengan email dan password
- 👤 **User Profile** - Kelola informasi profil pengguna
- 🌐 **Real-time Updates** - Data sinkron langsung dengan Firebase

---


## 🛠️ Tech Stack

- **Framework:** Flutter SDK
- **Language:** Dart
- **Backend:** Firebase
  - Authentication (Email/Password)
  - Cloud Firestore Database
- **State Management:** Provider

---

## 🚀 Installation

### Prerequisites

Pastikan sudah menginstall:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

### Step 1: Clone Repository

```bash
git clone https://github.com/LokaKarya-BEKUP/LokaKarya.git
cd LokaKarya
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Setup Firebase

#### 3.1 Buat Firebase Project

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Klik "Add project" atau "Tambah project"
3. Ikuti wizard untuk membuat project baru

#### 3.2 Setup Android App

1. Di Firebase Console, klik icon Android untuk menambahkan aplikasi Android
2. Masukkan package name aplikasi (biasanya: `com.lokakarya.app`)
3. Download file `google-services.json`
4. Copy file tersebut ke folder:
   ```
   android/app/google-services.json
   ```

#### 3.3 Setup iOS App (Opsional)

1. Di Firebase Console, klik icon iOS
2. Masukkan Bundle ID aplikasi
3. Download file `GoogleService-Info.plist`
4. Copy file tersebut ke folder:
   ```
   ios/Runner/GoogleService-Info.plist
   ```

#### 3.4 Aktifkan Firebase Services

Di Firebase Console, aktifkan:

1. **Authentication**
   - Navigate ke: Authentication → Sign-in method
   - Enable: Email/Password

2. **Cloud Firestore**
   - Navigate ke: Firestore Database
   - Klik "Create database"
   - Pilih mode: Start in test mode (untuk development)

### Step 4: Setup Firestore Database

Buat 4 collections berikut di Firestore:

#### Collection: `users`
```
{
  "id": "string",
  "email": "string",
  "name": "string",
  "photoUrl": "string",
  "createdAt": "timestamp"
  "updatedAt": "timestamp"
}
```

#### Collection: `stores`
```
{
  "id": "string",
  "name": "string",
  "city": "string",
  "phone": "string",
}
```

#### Collection: `categories`
```
{
  "id": "string",
  "imageUrl": "string",
  "name": "string"
}
```

#### Collection: `products`
```
{
  "id": "string",
  "storeId": "string",
  "categoryId": "string", // reference ke categories
  "name": "string",
  "description": "string",
  "price": "number",
  "imageUrl": "string",
  "unit": "string",
}
```

> **💡 Tip:** Lihat struktur lengkap di `lib/data/model/` untuk detail field dan tipe data.

### Step 5: Run Application

1. **Aktifkan emulator atau connect physical device**
   ```bash
   # Cek device yang tersedia
   flutter devices
   ```

2. **Run aplikasi**
   ```bash
   flutter run
   ```

3. **Untuk build release:**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   ```

--- 

## 👥 Tim Pengembang 

| Nama                            | ID       |
| ------------------------------- | -------- |
| Muhammad Aris Efendi            | BC25B010 |
| Aditya Dwi Suryo HardiYanto     | BC25B011 |
| Gravfel R. Pasaribu             | BC25B012 |
| Firza Hakim                     | BC25B013 |

---

<div align="center">
Made with ❤️ by B25-PG010 Team
</div>