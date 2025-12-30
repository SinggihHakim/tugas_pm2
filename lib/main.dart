import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Fungsi Main diubah menjadi async untuk memuat environment variable
Future<void> main() async {
  // Memastikan binding widget siap sebelum operasi async
  WidgetsFlutterBinding.ensureInitialized();
  
  // Memuat file .env
  // Pastikan file .env sudah dibuat di root project dan didaftarkan di pubspec.yaml
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
    // Aplikasi tetap jalan, tapi nanti akan error saat minta API Key jika file tidak ada
  }

  runApp(const ChefSakuApp());
}

class ChefSakuApp extends StatelessWidget {
  const ChefSakuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChefSaku',
      // --- SETUP TEMA WARNA (Food Theme) ---
      theme: ThemeData(
        useMaterial3: true,
        // Warna Utama: Deep Orange (Warna nafsu makan/masakan)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7043), 
          background: const Color(0xFFFFF3E0), // Krem (Seperti warna piring bersih)
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
        
        // Styling Input Text
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  
  String _result = ""; 
  bool _isLoading = false; 

  // MENGAMBIL API KEY DARI FILE .ENV
  // Jika tidak ditemukan, akan mengembalikan string kosong
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? ''; 

  Future<void> _askChefGemini() async {
    // 1. Validasi Input
    if (_controller.text.trim().isEmpty) return;

    // 2. Validasi API Key
    if (_apiKey.isEmpty) {
      setState(() {
        _result = "⚠️ ERROR: API Key belum disetting.\n"
                  "Pastikan Anda sudah membuat file .env dan mengisinya dengan:\n"
                  "GEMINI_API_KEY=kode_api_anda";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = ""; 
    });
    
    // Menurunkan keyboard setelah tombol ditekan
    FocusScope.of(context).unfocus(); 

    try {
      // 3. Inisialisasi Model Gemini
      final model = GenerativeModel(
        model: 'gemini-3-flash-preview', 
        apiKey: _apiKey,
      );

      // 4. Prompt Engineering (Instruksi ke AI)
      final prompt = '''
        Bertindaklah sebagai Chef profesional yang ramah.
        User memiliki bahan: "${_controller.text}".
        
        Tugasmu:
        1. Pilihkan SATU resep masakan Indonesia yang paling enak dan cocok menggunakan bahan itu.
        2. Tuliskan Judul Resep.
        3. Tuliskan Bahan Tambahan (bumbu dasar yang biasanya ada di dapur).
        4. Tuliskan Cara Memasak (maksimal 4 langkah singkat).
        
        Gunakan bahasa yang santai tapi sopan. Gunakan emoji makanan agar menarik.
      ''';

      // 5. Kirim Request
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // 6. Tampilkan Hasil
      setState(() {
        _result = response.text ?? "Maaf, Chef sedang bingung. Coba lagi ya!";
      });

    } catch (e) {
      setState(() {
        _result = "Terjadi kesalahan koneksi atau API Key: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- HEADER ---
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043), // Oranye
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "ChefSaku",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0,
        centerTitle: true,
      ),

      // --- BODY ---
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Ada bahan apa di kulkas?",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037), // Coklat Tua
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // INPUT FIELD
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Contoh: Telur, Tahu, Kecap...",
                prefixIcon: Icon(Icons.search, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 20),

            // TOMBOL BUTTON
            ElevatedButton(
              onPressed: _isLoading ? null : _askChefGemini,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047), // Hijau Segar
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20, 
                      width: 20, 
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                  : const Text(
                      "MASAK SEKARANG! 🍳",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            
            const SizedBox(height: 30),

            // AREA HASIL (RESULT)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: _result.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.soup_kitchen, size: 80, color: Colors.orange[100]),
                            const SizedBox(height: 10),
                            Text(
                              "Resep akan muncul di sini...",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        )
                      : Text(
                          _result,
                          style: const TextStyle(
                            fontSize: 16, 
                            height: 1.6, 
                            color: Color(0xFF3E2723), // Coklat Gelap
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}