**Tugas 2**: Jarak Real-time ke Titik Tetap
//Manfaatkan fungsi Geolocator.distanceBetween dari Langkah 4.//

1. Buat variabel String? distanceToPNB; di MyHomePageState.
Penjelasan : untuk menyimpan Jarak dari posisi saat ini ke titik tetap yang ditentukan diperlukan variable untuk menyimpannya. menggunakan tipe string karena variable tersebut bisa saja kosong jika aplikasi belum menghitung Jarak
Potongan kode : menambahkan di class MyHomePageState

2. Di dalam startTracking (di dalam .listen()), panggil fungsi untuk menghitung
jarak:
3. Simpan hasilnya di distanceToPNB menggunakan setState.
4. Tampilkan distanceToPNB di UI agar jaraknya ter-update secara real-time saat
Anda bergerak
