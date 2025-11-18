// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk Timer

// --- DEFINISI WARNA & KONSTANTA ---
const Color primaryColor = Color(0xFF0D47A1); 
const Color secondaryColor = Color(0xFFFFC107); 
const Color searchBarColor = Color(0xFFF0F0F0); 
const Color menuBackgroundColor = Colors.white; 
const Color lightBlueBanner = Color(0xFF42A5F5); 
const Color redLaporIcon = Color(0xFFD32F2F); 
const double MAX_WIDTH = 480.0; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 

  // --- LOGIC CAROUSEL BARU ---
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late final Timer _timer;

  final List<String> carouselImages = [
    'assets/images/benner1.jpeg', 
    'assets/images/banner2.png', 
    'assets/images/banner3.png', 
  ];
  // -----------------------------

  // Data gridItems (Item 'Lainnya' telah dihapus)
  final List<Map<String, dynamic>> gridItems = [
    {'title': 'LaporGub', 'icon': Icons.person_pin, 'color': primaryColor},
    {'title': 'Info Loker', 'icon': Icons.work, 'color': primaryColor},
    {'title': 'Agenda', 'icon': Icons.calendar_today, 'color': primaryColor},
    {'title': 'Info Transport', 'icon': Icons.directions_bus, 'color': primaryColor},
    {'title': 'Harga Pasar', 'icon': Icons.local_grocery_store, 'color': primaryColor},
    {'title': 'Pajak & Retribusi', 'icon': Icons.receipt, 'color': primaryColor},
    {'title': 'Lapor', 'icon': Icons.camera_alt, 'color': primaryColor}, 
    {'title': 'Jelajahi', 'icon': Icons.explore, 'color': primaryColor},
  ];

  // Data categoryItems
  final List<Map<String, dynamic>> categoryItems = [
    {'title': 'Gratispol', 'imagePath': 'assets/images/cat_gratispol.png', 'color': secondaryColor},
    {'title': 'Jospol', 'imagePath': 'assets/images/cat_jospol.png', 'color': Colors.red.shade700},
    {'title': 'Kesehatan', 'imagePath': 'assets/images/cat_kesehatan.png', 'color': Colors.green.shade700},
    {'title': 'Rekreasi', 'imagePath': 'assets/images/cat_rekreasi.png', 'color': Colors.purple.shade700},
    {'title': 'Pendidikan', 'imagePath': 'assets/images/cat_pendidikan.png', 'color': Colors.brown.shade700},
    {'title': 'Lainnya', 'imagePath': 'assets/images/cat_lainnya.png', 'color': primaryColor},
  ];

  // DATA DUMMY BARU UNTUK BERITA (dengan 2 gambar per item)
  final List<Map<String, dynamic>> newsItems = [
    {
      'title': 'Berita Monyet Ijo Banyumas Datang Di Hari Natal',
      'image1': 'assets/images/berita_placeholder.png', 
      'image2': 'assets/images/berita_placeholder.png',
    },
    {
      'title': 'Berita Mas Aldo Mengikuti Kelas Tambahan Di Malam Hari',
      'image1': 'assets/images/berita_placeholder_3.png',
      'image2': 'assets/images/berita_placeholder_3.png',
    },
    {
      'title': 'Berita Mas Aldo Di Marahi Dosen',
      'image1': 'assets/images/berita_placeholder_5.png',
      'image2': 'assets/images/berita_placeholder_5.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Inisialisasi Timer untuk auto-scroll setiap 3 detik
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < carouselImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Batalkan timer
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; 

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // --- MODIFIKASI 1: BACKGROUND TRANSPARAN ---
        backgroundColor: Colors.transparent, 
        bottomNavigationBar: _buildBottomNavigationBar(),
        
        // --- MODIFIKASI 2: FLOATING ACTION BUTTONS ---
        floatingActionButton: _buildFloatingActionButtons(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 

        body: Center( 
          child: Container(
            width: screenWidth > MAX_WIDTH ? MAX_WIDTH : screenWidth, 
            // --- MODIFIKASI 3: DECORATION UNTUK BACKGROUND GAMBAR ---
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_home.png'), 
                fit: BoxFit.cover, 
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. HEADER (Di luar Stack)
                  _buildHeader(), 

                  // 2. CAROUSEL GAMBAR BARU 
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildImageCarousel(),
                  ),
                  const SizedBox(height: 10),

                  // 3. SEARCH BAR DIPINDAHKAN DI BAWAH CAROUSEL
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildSearchBar(),
                  ),
                  
                  const SizedBox(height: 20), 

                  // 4. TIGA TOMBOL FILTER 
                  _buildFilterButtons(), 
                  
                  const SizedBox(height: 20),

                  // 5. GRID MENU 4xN
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                    child: _buildGridMenu3x3(),
                  ),
                  
                  const SizedBox(height: 5),

                  // 6. BANNER GRATISPOL
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildBannerGratispol(),
                  ),

                  const SizedBox(height: 25),
                  
                  // 7. KATEGORI LAYANAN & INFORMASI
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: _buildCategorySection(),
                  ),

                  const SizedBox(height: 25),

                  // 8. BERITA SEPUTAR KALTIM
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildNewsSection(),
                  ),
                  
                  const SizedBox(height: 20), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET BARU: IMAGE CAROUSEL ---
  Widget _buildImageCarousel() {
    return Container(
      height: 150, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: carouselImages.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  carouselImages[index],
                  fit: BoxFit.cover, 
                ),
              );
            },
          ),
          
          // Dot Indicator
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _pageController.animateToPage(entry.key, duration: const Duration(milliseconds: 300), curve: Curves.ease),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == entry.key ? Colors.white : Colors.white54,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET FLOATING ACTION BUTTONS (2 FAB) ---
  Widget _buildFloatingActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0), 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // FAB 1 (Ikon Pensil)
          FloatingActionButton(
            heroTag: 'fab1', 
            onPressed: () {
              print('FAB Pensil diklik');
            },
            backgroundColor: primaryColor,
            mini: true, 
            child: const Icon(Icons.edit, color: Colors.white), 
          ),
          const SizedBox(height: 10),
          // FAB 2 (Ikon Plus/Standar)
          FloatingActionButton(
            heroTag: 'fab2', 
            onPressed: () {
              print('FAB Plus diklik');
            },
            backgroundColor: redLaporIcon, 
            child: const Icon(Icons.add, color: Colors.white, size: 30), 
          ),
        ],
      ),
    );
  }


  // --- WIDGET HEADER (SAKTI Logo, Waktu, & Ikon Profil) ---
  Widget _buildHeader() {
    return Container(
      height: 60, // Ketinggian disesuaikan
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 5, 100, 234), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // KIRI: Logo SAKTI + Waktu
          Row(
            children: const [
                // Placeholder Logo SAKTI
                CircleAvatar(
                    radius: 12,
                    backgroundColor: Color.fromARGB(255, 8, 8, 8), 
                    child: Text('D', style: TextStyle(color: Color.fromARGB(255, 249, 248, 248), fontSize: 14)),
                ),
                SizedBox(width: 8),
                Text(
                  '18.30', 
                  style: TextStyle(color: Color.fromARGB(255, 248, 247, 247), fontWeight: FontWeight.bold, fontSize: 15),
                ),
            ],
          ),
          
          // KANAN: Ikon Notifikasi
          const Icon(Icons.notifications_none, color: Color.fromARGB(255, 253, 253, 253), size: 24),
        ],
      ),
    );
  }

  // --- WIDGET SEARCH BAR ---
  Widget _buildSearchBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: searchBarColor, 
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari Apa Saja...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: primaryColor, size: 20),
          filled: true,
          fillColor: searchBarColor, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            borderSide: BorderSide.none, 
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
        ),
      ),
    );
  }

  // --- WIDGET FILTER BUTTONS ---
  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPillButton(text: 'Favorite', icon: Icons.favorite_border, isSelected: true),
          _buildPillButton(text: 'Aktivitas', icon: Icons.list_alt, isSelected: false),
          _buildPillButton(text: 'Pencarian Populer', icon: Icons.star_border, isSelected: false),
        ],
      ),
    );
  }

  // --- WIDGET PILL BUTTON ---
  Widget _buildPillButton({
    required String text, 
    required IconData icon,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.grey.shade600),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET GRID MENU 4xN ---
  Widget _buildGridMenu3x3() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8, 
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 55, 
                height: 55, 
                decoration: BoxDecoration(
                  color: menuBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), 
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    item['icon'] as IconData,
                    size: 28, 
                    color: item['color'] as Color, 
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text( 
                item['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11, 
                  color: Colors.black87, 
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  // --- WIDGET BANNER GRATISPOL ---
  Widget _buildBannerGratispol() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightBlueBanner, 
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Informasi Layanan\nGratispol', 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ), 
                SizedBox(height: 5), 
                Text(
                  'Baca Selengkapnya', 
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ), 
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: Colors.white),
                    SizedBox(width: 4),
                    Icon(Icons.circle, size: 6, color: Colors.white54),
                    SizedBox(width: 4),
                    Icon(Icons.circle, size: 6, color: Colors.white54),
                  ],
                )
              ],
            ),
          ),
          
          // Ilustrasi Aset Gambar
          Image.asset(
            'assets/images/gratispol_man.png', 
            height: 100, 
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
  
  // --- WIDGET KATEGORI LAYANAN & INFORMASI ---
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori Layanan & Informasi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 100, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryItems.length,
            itemBuilder: (context, index) {
              final box = categoryItems[index];
              return Container(
                width: 70, 
                margin: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: box['color'].withOpacity(0.3), width: 1),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                            )
                        ]
                      ),
                      // Ikon Kategori: Sudah menggunakan Image.asset
                      child: Image.asset(box['imagePath'] as String), 
                    ),
                    const SizedBox(height: 5),
                    Text(
                      box['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- WIDGET BERITA SEPUTAR KALTIM (Sudah dimodifikasi untuk 2 gambar) ---
  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Berita Seputar Kalimantan Timur',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 210, // Ketinggian disesuaikan untuk 2 gambar + teks
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsItems.length, 
            itemBuilder: (context, index) {
              final news = newsItems[index]; 
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      // KODE GAMBAR PERTAMA
                    Container(
                      height: 60, 
                      decoration: const BoxDecoration(
                        color: Colors.transparent, // Menggunakan Image.asset, tidak perlu DecorationImage
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        child: Image.asset(news['image1'] as String, fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                      // KODE GAMBAR KEDUA
                    Container(
                      height: 60, 
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(news['image2'] as String, fit: BoxFit.cover, width: double.infinity),
                    ),
                    const SizedBox(height: 5), // Jeda antara gambar kedua dan teks
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        news['title'] as String,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '1 jam lalu',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // --- WIDGET BOTTOM NAVIGATION BAR ---
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pencarian'),
        // Ikon Lapor menonjol di tengah
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: redLaporIcon, 
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.camera_alt, size: 24, color: Colors.white),
          ), 
          label: 'Lapor',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Jelajah'),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'), 
      ],
    );
  }
}