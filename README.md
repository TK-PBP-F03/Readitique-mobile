# Readitique-mobile

## Anggota Kelompok :
- Dhafin Fadhlan Kamal
- Athira Reika
- Thaariq Kurnia Spama
- Kevin Ignatius Wijaya
- Melvara Zafirah Ramsi

## Deskripsi aplikasi
Readitique adalah sebuah aplikasi perpustakaan digital yang memungkinkan pengguna untuk mengakses koleksi buku digital yang kaya. Kini readitique kembali dalam bentuk aplikasi mobile untuk kemudahan dan kenyamana para konsumen. Hanya saja terdapat sedikit perbedaan dengan versi website dimana versi ini menawarkan fitur mengunggah rating dan ulasan melalui fitur Review, serta membaca ulasan dari pengguna lain. Profil pengguna memiliki peran Reader dengan hak akses yang sesuai. Fitur Add Buku memungkinkan pengguna untuk mengusulkan dan memberikan suara pada buku yang ingin mereka lihat ditambahkan ke dalam koleksi. Dengan aplikasi ini, pengguna dapat menjalani pengalaman membaca yang terorganisir dan berinteraktif, serta berpartisipasi dalam komunitas literatur yang dinamis. 

## Daftar modul yang akan diimplementasikan
1. Autentikasi pengguna (`thaariq`)
2. Homepage (Melvara)
3. Review (read rating/a few reviews only/add) (Dhafin)
4. Profile (Reader) (Kevin)
5. Add buku (guest: lihat usulan terbaru, non-admin: usulkan dan voting buku) (Reika)

## Peran Pengguna
- Login (Reader): Pengguna dapat menyimpan buku yang akan dibaca atau memasukkan ke dalam list favorit buku. Pengguna dapat membuka reading list pengguna lain dan melihat buku yang sudah dibaca, sedang dibaca, dan ingin dibaca pengguna tersebut. Mereka juga bisa membuat dan memodifikasi reading list yang mereka buat sendiri. Selain itu, pengguna dapat melihat semua review suatu buku dan bisa memberikan rating dan review pada buku tersebut. Pengguna juga bisa memberikan usulan terbaru mengenai buku yang akan ditambahkan dan melakukan voting buku yang akan diusulkan tersebut.
- Tidak Login : Pengguna yang belum login atau bahkan belum memiliki akun hanya dapat mengakses beberapa fitur pada website ini seperti, hanya bisa membaca buku tanpa menyimpan ke favorite atau menandai bahwa buku itu belum selesai. Pengguna hanya bisa melihat buku yang sudah dibaca pengguna yang sudah login di reading list mereka dan tidak bisa membuat atau memodifikasi reading list tersebut. Pengguna juga tidak bisa melihat review full dan memberikan review pada suatu buku. Pengguna juga hanya bisa melihat usulan buku baru yang ingin ditambahkan tanpa melakukan voting pada usulan tersebut. Jika pengguna belum memiliki akun, pengguna dapat membuat akun baru dengan membuat username dan password baru pada website tersebut.

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
1. Langkah-langkah Umum untuk Integrasi:
2. Definisikan Endpoint API: Tentukan endpoint untuk setiap modul di web service Anda.
3. Akses Data: Gunakan HTTP request dari aplikasi Flutter untuk mengakses data melalui API.
4. Autentikasi dan Otorisasi: Pastikan autentikasi dan otorisasi pengguna bekerja dengan baik antara kedua platform.
5. Uji Coba: Lakukan pengujian menyeluruh untuk memastikan integrasi berjalan dengan lancar.
