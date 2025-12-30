# ChefSaku – AI Recipe Generator

ChefSaku adalah aplikasi mobile yang dikembangkan menggunakan framework Flutter dan terintegrasi dengan Google Gemini AI. Aplikasi ini berfungsi sebagai asisten memasak sederhana yang memberikan rekomendasi resep masakan Indonesia berdasarkan bahan-bahan yang dimiliki pengguna di rumah.

Project ini dibuat sebagai studi kasus implementasi Artificial Intelligence pada aplikasi mobile dengan manajemen state yang sederhana.

## Fitur Utama

* Input Bahan
  Pengguna dapat memasukkan daftar bahan makanan yang tersedia, seperti telur, tempe, atau sawi.

* AI Recipe Generation
  Menggunakan Google Gemini untuk menghasilkan resep yang relevan, lengkap dengan bahan tambahan dan langkah memasak.

* Tampilan Sederhana
  Antarmuka pengguna yang bersih dan mudah digunakan dengan tema warna makanan.

* Manajemen Error
  Menangani kondisi ketika koneksi gagal atau API Key bermasalah.

## Teknologi yang Digunakan

* Flutter (Dart)
* Google Gemini API
* HTTP REST API
* Flutter Dotenv (flutter_dotenv)

## Cara Menjalankan Aplikasi

Karena project ini menggunakan API Key yang bersifat rahasia, diperlukan konfigurasi mandiri sebelum aplikasi dapat dijalankan.

### 1. Clone Repository

```bash
git clone https://github.com/SinggihHakim/tugas_pm2.git
cd tugas_pm2
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Konfigurasi API Key

Repository ini tidak menyertakan file .env demi alasan keamanan.

Langkah-langkah:

1. Buat file baru bernama .env di root project (sejajar dengan pubspec.yaml).
2. Buat API Key melalui Google AI Studio.
3. Isi file .env dengan format berikut:

```env
GEMINI_API_KEY=MASUKKAN_API_KEY_ANDA_DISINI
```

### 4. Jalankan Aplikasi

Pastikan emulator atau device fisik sudah terhubung, lalu jalankan:

```bash
flutter run
```

## Keamanan dan File .env

File .env tidak disertakan di dalam repository sebagai bentuk penerapan praktik keamanan yang baik.

Alasan utama:

* File .env berisi API Key yang bersifat rahasia.
* Mencegah penyalahgunaan kuota API.
* File .env telah dimasukkan ke dalam .gitignore sehingga tidak terunggah ke GitHub.

Setiap developer yang menjalankan project ini diwajibkan menggunakan API Key masing-masing.
