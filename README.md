# CRUD Task Management

CRUD Task Management adalah aplikasi manajemen tugas sederhana yang dibangun menggunakan Flutter dengan pendekatan Clean Architecture dan penyimpanan data lokal menggunakan Hive.

## Cara Menjalankan Aplikasi

1. **Clone Repository**
   ```sh
   git clone https://github.com/nuzularifin/crud_task_management.git
   cd crud_task_management
   ```
2. **Install Dependencies**
   ```sh
   flutter pub get
   ```
3. **Generate Model And Class Dependencies**
   ```sh
   flutter pub run build_runner build --delete-conflicting-outputs  
   ```
3. **Jalankan Aplikasi**
   ```sh
   flutter run
   ```
   Pastikan emulator atau perangkat fisik sudah terhubung.
   **Sebelum melakukan running code dibawah install atau tambahkan plugin build_runner pada pubspec.yaml**
   **ada juga yang menggunakan @generate or import or part**
   
4. **Login Part**
   ```sh
   username : eve.holt@reqres.in
   password : cityslicka
   confirmPassword : cityslicka
   ```
## Arsitektur yang Digunakan

Aplikasi ini menerapkan **Clean Architecture** dengan pemisahan kode menjadi beberapa lapisan utama:

- **Presentation Layer:** Menggunakan Flutter Widget dan State Management dengan BLoC.
- **Domain Layer:** Berisi model dan use case untuk bisnis logika aplikasi.
- **Data Layer:** Mengelola sumber data menggunakan Hive sebagai penyimpanan lokal.

### Struktur Folder
```
lib/
├── core/        # Berisi helper, utils, dan constants
├── data/        # Data layer (Hive repository, model, dan source)
├── domain/      # Domain layer (Entities, Use Cases, Repositories Interface)
├── presentation/# UI dan BLoC
│   ├── screens/  # Halaman aplikasi
│   ├── widgets/  # Komponen UI
│   ├── bloc/     # State management
└── main.dart    # Entry point aplikasi
```

## Library Pihak Ketiga

Berikut adalah library yang digunakan dalam proyek ini:

| Library | Deskripsi |
|---------|------------|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management dengan BLoC |
| [hive](https://pub.dev/packages/hive) | Database NoSQL untuk penyimpanan lokal |
| [hive_flutter](https://pub.dev/packages/hive_flutter) | Integrasi Hive dengan Flutter |
| [equatable](https://pub.dev/packages/equatable) | Mempermudah perbandingan objek |
| [intl](https://pub.dev/packages/intl) | Format tanggal dan waktu |
| [json_serializable](https://pub.dev/packages/json_serializable) | JSON Serializable for Modeling serialize |
| [dio](https://pub.dev/packages/dio) | DIO for API |
| [bloc_test](https://pub.dev/packages/bloc_test) | For unit testing BLoC |
| [build_runner](https://pub.dev/packages/build_runner) | Build runner for generate class, model or etc |

## Kontribusi

Jika ingin berkontribusi pada proyek ini, silakan fork repo ini dan ajukan pull request dengan perbaikan atau fitur baru.

## Lisensi

Proyek ini menggunakan lisensi MIT. Silakan lihat file `LICENSE` untuk detail lebih lanjut.

---
Terima kasih telah menggunakan CRUD Task Management! 🚀

