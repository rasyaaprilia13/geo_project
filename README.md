# mapping_project

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

