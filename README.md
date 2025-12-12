📱 EventKu – Event Discovery App

A Flutter mobile application to explore real-time events using Ticketmaster API

📌 Deskripsi Aplikasi

EventKu adalah aplikasi mobile berbasis Flutter yang berfungsi untuk menampilkan berbagai acara (event) secara real-time menggunakan Ticketmaster Discovery API.
Aplikasi ini dikembangkan sebagai bagian dari Ujian Akhir Semester (UAS) mata kuliah Mobile Programming.

EventKu memungkinkan pengguna melihat daftar event, menjelajahi kategori, mencari event tertentu, dan melihat detail event lengkap yang diambil langsung dari internet (tanpa data dummy).

✨ Fitur Utama
🏠 1. Home Page

Header sapaan

Grid kategori event

Event “Upcoming This Week” (horizontal list)

Event “Recommended” (vertical list)

🎭 2. Kategori Event

Menampilkan event berdasarkan kategori:

Music

Arts

Sports

Film

🔍 3. Pencarian Event

Pengguna dapat mencari event berdasarkan keyword

Data diambil real-time dari API Ticketmaster

📝 4. Detail Event

Banner event

Judul

Tanggal & waktu

Lokasi venue

Deskripsi acara

Tombol “Beli Tiket” → membuka halaman resmi Ticketmaster

🔄 5. Loading, Error & Success State

Loading indicator ketika fetch data

Error message ketika koneksi bermasalah

UI dinamis berdasarkan response API

🏛 Arsitektur Proyek

Aplikasi menggunakan struktur folder yang rapi dan terorganisasi:

lib/
 ├── models/
 │     ├── event_model.dart
 │     ├── image_model.dart
 │     └── venue_model.dart
 ├── services/
 │     └── event_service.dart
 ├── providers/
 │     └── event_provider.dart
 ├── pages/
 │     ├── home_page.dart
 │     ├── category_page.dart
 │     ├── detail_page.dart
 │     └── search_page.dart
 ├── widgets/
 │     ├── event_card.dart
 │     └── category_item.dart
 └── main.dart

🌐 API Yang Digunakan

Aplikasi ini menggunakan:

🔗 Ticketmaster Discovery API v2

Dokumentasi resmi:
https://developer.ticketmaster.com/products-and-docs/apis/discovery-api/v2/

Endpoint Utama
Kebutuhan	Endpoint
List Event	/discovery/v2/events.json
Detail Event	/discovery/v2/events/{id}.json
Search Event	/discovery/v2/events.json?keyword=
Contoh Request
https://app.ticketmaster.com/discovery/v2/events.json?apikey=YOUR_API_KEY&classificationName=music&size=20

🛠 Teknologi & Tools

Flutter (SDK 3.x)

Dart (Null Safety)

HTTP / Dio package

Provider (State Management)

Material Design 3 UI

📥 Cara Instalasi & Menjalankan Aplikasi
1. Clone repository
git clone https://github.com/your_username/EventKu.git

2. Masuk ke folder project
cd EventKu

3. Install dependencies
flutter pub get

4. Tambahkan API Key

Buka file:

lib/services/event_service.dart


Lalu isi:

const String apiKey = "YOUR_API_KEY";

5. Jalankan aplikasi
flutter run

📸 Screenshots

Tambahkan screenshot di bawah ini:

Home Page

Kategori Page

Detail Page

Search Page

Loading State

Error State

🎥 Demo Video

Link YouTube demo aplikasi (maksimal 3 menit)
(tempelkan di sini setelah upload)

📄 Dokumentasi Lanjutan (Laporan PDF)

Laporan lengkap berisi:

Arsitektur aplikasi

Diagram alur data

Screenshot hasil pengujian

Penjelasan integrasi API

Analisis loading & error handling

Tambahkan link Google Drive laporan PDF di sini

👨‍💻 Pengembang

Nama: Yanuar Purwa Andriansah
Mata Kuliah: Mobile Programming
NIM: 230605110108
