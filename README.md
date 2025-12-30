ChefSaku - AI Recipe Generator

ChefSaku adalah aplikasi mobile yang dikembangkan menggunakan framework Flutter dan terintegrasi dengan Google Gemini AI (model gemini-3-flash-prevuew). Aplikasi ini berfungsi sebagai asisten memasak sederhana yang memberikan rekomendasi resep masakan Indonesia berdasarkan bahan-bahan yang dimiliki pengguna di rumah.

Project ini dibuat sebagai studi kasus implementasi Artificial Intelligence pada aplikasi mobile dengan manajemen state yang sederhana.

Fitur Utama

Input Bahan: Pengguna dapat memasukkan daftar bahan makanan yang tersedia (contoh: Telur, Tempe, Sawi).

AI Generation: Menggunakan Google Gemini untuk menghasilkan resep yang relevan, lengkap dengan bumbu tambahan dan langkah memasak.

Tampilan Sederhana: Antarmuka pengguna (UI) yang bersih dan mudah digunakan dengan tema warna makanan.

Manajemen Error: Menangani kasus ketika koneksi gagal atau API Key bermasalah.

Teknologi yang Digunakan

Flutter (Dart)

Google Generative AI SDK (google_generative_ai)

Flutter Dotenv (flutter_dotenv) untuk manajemen environment variable

Cara Menjalankan Aplikasi (Instalasi)

Dikarenakan project ini menggunakan API Key yang bersifat rahasia, Anda perlu melakukan konfigurasi mandiri untuk menjalankannya. Ikuti langkah-langkah berikut:

Clone Repository
Unduh source code ke komputer Anda:
git clone https://github.com/SinggihHakim/tugas_pm2.git
cd tugas_pm2

Install Dependencies
Unduh semua library yang diperlukan:
flutter pub get

Konfigurasi API Key (PENTING)
Project ini tidak menyertakan file .env di dalam repository demi alasan keamanan. Anda harus membuatnya sendiri:

Buat file baru bernama .env di root folder project (sejajar dengan file pubspec.yaml).

Buka Google AI Studio (https://aistudio.google.com/) dan buat API Key baru.

Isi file .env tersebut dengan format berikut:
GEMINI_API_KEY=MASUKKAN_API_KEY_ANDA_DISINI

Jalankan Aplikasi
Pastikan emulator atau device fisik sudah terhubung, lalu jalankan:
flutter run

Keamanan dan File .env

Anda tidak akan menemukan file .env di dalam repository ini. Hal ini disengaja dan merupakan praktik standar keamanan (Best Practice) dalam pengembangan perangkat lunak.

Alasan mengapa file .env tidak di-push ke GitHub:

Perlindungan Data Sensitif: File .env berisi GEMINI_API_KEY. Kunci ini bersifat rahasia. Jika diunggah ke publik, siapa pun dapat mengambilnya.

Mencegah Penyalahgunaan: Jika API Key bocor, pihak yang tidak bertanggung jawab dapat menggunakan kuota API Anda, yang dapat menyebabkan habisnya kuota gratis atau pembengkakan biaya tagihan.

GitIgnore: File .env telah didaftarkan ke dalam file .gitignore, sehingga Git secara otomatis mengabaikan file tersebut saat proses upload (push) dilakukan.

Oleh karena itu, setiap developer yang ingin menjalankan project ini diharapkan memiliki API Key masing-masing.

Author

Singgih Hakim
Tugas Project PM2
