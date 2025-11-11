import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Geolocator (Dasar)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  String? _errorMessage;
  String? _currentAddress;
  StreamSubscription<Position>? _positionStream;

  // Variabel untuk menyimpan jarak ke PNB (Tugas 2)
  String? _distanceToPNB; 
  
  // Koordinat Titik Tetap (Sydney, Australia)
  final double pnbLat = -33.8688;   
  final double pnbLng = 151.2093;

  
  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  // Fungsi untuk mendapatkan izin akses dan posisi awal
  Future<Position> _getPermissionAndLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Layanan lokasi tidak aktif. Harap aktifkan GPS.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Izin lokasi ditolak permanen. Harap ubah di pengaturan aplikasi.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  
  // Fungsi untuk mendapatkan alamat dari koordinat (Geocoding)
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      setState(() {
        // Menggabungkan elemen alamat
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Gagal mendapatkan alamat: $e";
      });
    }
  }

  // Fungsi untuk menghitung jarak ke PNB dan update state (Tugas 2)
  void _calculateDistanceToPNB(Position position) {
    // Hitung jarak dalam meter
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      pnbLat,
      pnbLng,
    );

    // Konversi ke kilometer dan bulatkan 2 angka di belakang koma
    double distanceInKm = distanceInMeters / 1000;
    
    // Simpan hasilnya di _distanceToPNB menggunakan setState
    setState(() {
      _distanceToPNB = "${distanceInKm.toStringAsFixed(2)} km"; 
    });
  }

  
  // tombol "Dapatkan Lokasi Sekarang" (Hanya ambil lokasi dan alamat)
  void _handleGetLocation() async {
    try {
      Position position = await _getPermissionAndLocation();
      setState(() {
        _currentPosition = position;
        _errorMessage = null;
        // Jarak direset saat klik single shot, agar hanya tracking yang menampilkan
        _distanceToPNB = null; 
      });
      await _getAddressFromLatLng(position); 
      
      
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  
  // tombol "Mulai Lacak" (Mulai stream posisi dan hitung jarak real-time)
  void _handleStartTracking() {
    _positionStream?.cancel();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    try {
      // untuk update posisi terus-menerus
      _positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen((Position position) async {
        setState(() {
          _currentPosition = position;
          _errorMessage = null;
        });
        await _getAddressFromLatLng(position); 
        
        // Panggil fungsi perhitungan jarak untuk update real-time (Tugas 2)
        _calculateDistanceToPNB(position); 
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  // tombol "Henti Lacak"
  void _handleStopTracking() {
    _positionStream?.cancel();
    setState(() {
      _errorMessage = "Pelacakan dihentikan.";
    });
  }

  // UI (Antarmuka Pengguna)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum Geolocator (Dasar)")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                SizedBox(height: 16),

                // Area informasi lokasi
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 16),

                      if (_currentPosition != null) ...[
                        Text(
                          "Lat: ${_currentPosition!.latitude.toStringAsFixed(7)}\nLng: ${_currentPosition!.longitude.toStringAsFixed(7)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_currentAddress != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Alamat: $_currentAddress",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        
                        // Tampilkan Jarak ke PNB (Hanya muncul saat _distanceToPNB terisi)
                        if (_distanceToPNB != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              "Jarak ke PNB: $_distanceToPNB",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 227, 38, 198), // Menyesuaikan style gambar
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: 32),

                
                // Tombol Dapatkan Lokasi Sekarang
                ElevatedButton.icon(
                  icon: Icon(Icons.location_searching),
                  label: Text('Dapatkan Lokasi Sekarang'),
                  onPressed: _handleGetLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    side: BorderSide(color: Colors.grey.shade300),
                    minimumSize: Size(double.infinity, 50), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol Mulai Lacak
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow),
                        label: Text('Mulai Lacak'),
                        onPressed: _handleStartTracking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Tombol Henti Lacak
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.stop),
                        label: Text('Henti Lacak'),
                        onPressed: _handleStopTracking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}