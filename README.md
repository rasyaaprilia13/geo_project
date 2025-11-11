# mapping_project
**Rasya Aprilia (362458302115) 2B TRPL**
A new Flutter project.

## Tugas 1: Geocoding (Alamat dari Koordinat)
Saat ini kita hanya menampilkan Lat/Lng. Buatlah agar aplikasi menampilkan alamat
(nama jalan, kota, dll) dari koordinat yang didapat.
dokumentasi awal :
![WhatsApp Image 2025-11-10 at 20 41 41_5fa68e1e](https://github.com/user-attachments/assets/d1c6cfbd-6347-4da2-94c5-af5563342922)

## Petunjuk:
## 1. Anda sudah menambahkan paket geocoding di pubspec.yaml.
Source code :
<img width="623" height="196" alt="image" src="https://github.com/user-attachments/assets/3cac290b-1236-416f-b4ef-44fca93d838e" />

## 2. Import paketnya: import ’package:geocoding/geocoding.dart’;
Source code :
<img width="620" height="138" alt="image" src="https://github.com/user-attachments/assets/c72e3c00-6cae-461d-af6f-e5272b9e0ae5" />

## 3. Buat variabel String? currentAddress; di MyHomePageState.
Source code :
<img width="667" height="163" alt="image" src="https://github.com/user-attachments/assets/05e164d9-bcdc-4eb7-b6fc-d997024a77b2" />

## 4. Buat fungsi baru getAddressFromLatLng(Position position).
Source code :
<img width="1214" height="377" alt="image" src="https://github.com/user-attachments/assets/6bf14c40-f2a2-4524-8f9e-c911d82384eb" />

## 5.  Panggil fungsi getAddressFromLatLng( currentPosition!) di dalam getLocation dan startTracking (di dalam .listen()) setelah setState untuk currentPosition.
Source code : pada getLocation
<img width="635" height="284" alt="image" src="https://github.com/user-attachments/assets/8a39c854-a070-419f-bf4c-19e85412e9b9" />

Source code : pada startTracking
<img width="681" height="493" alt="image" src="https://github.com/user-attachments/assets/c6fa160e-4224-4c73-b5dc-f3816ba483c5" />

## 6. Tampilkan currentAddress di UI Anda, di bawah Lat/Lng.
<img width="410" height="254" alt="image" src="https://github.com/user-attachments/assets/874ce445-edc9-451b-903b-101fbd1a1ffc" />

## Hasil Akhir
![Screenshot_20251110_211921 1](https://github.com/user-attachments/assets/b07f11e5-569d-49cb-bae6-33a45cafabb7)
![Screenshot_20251110_211925 1](https://github.com/user-attachments/assets/a724dc73-1eaa-4c51-bafd-92ddb355de7b)

## ---------------------------------------------------------------------------------------
## TUGAS 2 : Jarak Real-time ke Titik Tetap
Manfaatkan fungsi Geolocator.distanceBetween dari Langkah 4.

## 1. Buat variabel String? distanceToPNB; di MyHomePageState.
Penjelasan : untuk menyimpan Jarak dari posisi saat ini ke titik tetap yang ditentukan diperlukan variable untuk menyimpannya. menggunakan tipe string karena variable tersebut bisa saja kosong jika aplikasi belum menghitung Jarak
Potongan kode : menambahkan di class MyHomePageState. ini merupakan bagian di state management nya
- <img width="681" height="235" alt="image" src="https://github.com/user-attachments/assets/fe487c8b-4de8-4f82-bf2e-805981358d8e" />

**setelah itu tentukan titik tetap koordinatnya yang berlokasi di Sydney, Australia**
Potongan kode :
- <img width="547" height="101" alt="image" src="https://github.com/user-attachments/assets/7bffb81d-7e77-41eb-9d85-0770890431a7" />
kemudian buat fungsi untuk menghitung jarak posisi dengan jarak titik tetap

**fungsi untuk menghitung jarak**
Fungsi Geolocator.distanceBetween() akan menghitung jarak dari posisi pengguna ke titik ini. fungsi ini menghitung jarak dalam meter kemudian dirubah menjadi km, yang dibulatkan hasilnya sampai menjadi 2 desimal
setState() dipakai agar nilai jarak langsung muncul di UI.
Potongan kode :
- <img width="701" height="440" alt="image" src="https://github.com/user-attachments/assets/a301221d-a2fd-4639-b5d1-fb3a5410211b" />

## 2. Di dalam startTracking (di dalam .listen()), panggil fungsi untuk menghitung jarak
Setiap ada update posisi, aplikasi otomatis menghitung jarak real-time ke Sydney, Australia. Fungsi ini berjalan continous tracking, sehingga jarak akan berubah jika pengguna bergerak.
Potongan kode :
- <img width="706" height="404" alt="image" src="https://github.com/user-attachments/assets/10f03b3c-06ca-4a12-a696-c6957550015f" />

## 3. Simpan hasilnya di distanceToPNB menggunakan setState.
menyimpan hasil perhitungan jarak ke variabel _distanceToPNB dan men-trigger UI agar menampilkan jarak terbaru secara real-time.
Potongan kode :
- <img width="608" height="139" alt="image" src="https://github.com/user-attachments/assets/66c6505b-e317-4fed-b1fa-14c10228c3f1" />

## 4. Tampilkan distanceToPNB di UI agar jaraknya ter-update secara real-time saat Anda bergerak
Nilai _distanceToPNB akan langsung muncul di layar. Saat pengguna bergerak dengan jarak tertentu yang ditentukan, jarak ini akan update otomatis sesuai lokasi terbaru.
Potongan kode :
- <img width="870" height="368" alt="image" src="https://github.com/user-attachments/assets/5e9f193d-2c3d-4d99-a62b-577649fb0992" />

## Cara Kerja
1. User menekan “Mulai Lacak” → aplikasi mulai mendengarkan GPS secara real-time.
2. Setiap update posisi:
Alamat dikonversi dari koordinat (_getAddressFromLatLng()).
Jarak dihitung ke Sydney menggunakan _calculateDistanceToPNB().
3. Hasil jarak (dalam km) ditampilkan di layar secara otomatis.
4. Jika user menekan “Henti Lacak”, stream dihentikan dan update jarak berhenti.

## Hasil
UI menampilkan:
- Latitude & Longitude saat ini
- Alamat saat ini
- Jarak real-time ke Sydney, Australia (misal: “15,200.35 km”)
- Jarak update otomatis saat pengguna bergerak.

## Dokumentasi Hasil Tugas 2 :
**Saat melacak lokasi saat ini :**
![WhatsApp Image 2025-11-11 at 20 22 12_3fe5b971](https://github.com/user-attachments/assets/afb4504c-f54b-4db2-9449-beef0c9ab829)

**Saat melakukan mulai lacak dan menampilkan jarak ke koordinat tetap :**
![WhatsApp Image 2025-11-11 at 20 22 11_353b10ca](https://github.com/user-attachments/assets/fdb8a5a4-61f3-46ff-9adb-065ea0c7461e)

**Saat berhenti melakukan pelacakan :**
![WhatsApp Image 2025-11-11 at 20 22 11_359507b3](https://github.com/user-attachments/assets/683d1ad8-3f4b-45ba-85f4-5672ef9bf982)

