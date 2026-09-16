# Panduan Pemasangan — Buku Gudang Hotel

Panduan ini ditulis untuk orang yang belum pernah memasang aplikasi.
Tidak ada perintah rumit yang perlu diketik. Semuanya klik dan salin-tempel.

Sediakan waktu sekitar 30 menit dan sebuah laptop atau komputer.
HP dipakai belakangan, saat membagikan aplikasinya ke staf.

---

## Sebelum mulai: apa yang sebenarnya kita lakukan

Bayangkan Anda mau membuka kantor kecil. Ada tiga hal yang disiapkan:

**Lemari arsip** — tempat semua catatan stok disimpan.
Ini yang kita buat di **Supabase**.

**Ruko dengan alamat** — tempat aplikasinya dipajang supaya staf bisa
membukanya dari HP masing-masing. Ini kita buat di **Netlify**.

**Secarik kertas berisi alamat lemari arsip** — supaya aplikasi di ruko
tahu ke mana harus mengambil dan menyimpan data. Ini yang kita tulis di
berkas `index.html`.

Tiga hal itu saja. Kalau di tengah jalan Anda bingung sedang di bagian
mana, kembali ke gambaran ini.

Yang Anda punya sekarang adalah folder berisi berkas-berkas berikut:

```
index.html       <- ini yang nanti kita edit
manifest.json
skema.sql        <- ini yang nanti kita salin ke Supabase
PANDUAN.md       <- berkas yang sedang Anda baca
ikon-192.png
ikon-512.png
aset/            <- folder, jangan diapa-apakan
```

Jangan memindahkan, mengganti nama, atau menghapus berkas mana pun.
Yang kita sentuh nanti cuma `index.html`.

---

## BAGIAN 1 — Membuat lemari arsip (Supabase)

### 1.1 Daftar

1. Buka **supabase.com** di browser.
2. Klik tombol **Start your project** di kanan atas.
3. Pilih **Continue with Google** dan pakai akun Google Anda.
   Ini paling cepat karena tidak perlu membuat sandi baru.

### 1.2 Buat proyek

Setelah masuk, Anda diminta membuat proyek pertama.

1. **Name**: ketik `gudang-hotel`
2. **Database Password**: klik tombol *Generate a password*, lalu klik
   ikon salin di sebelahnya. **Tempel dan simpan di catatan HP Anda.**

   > Sandi ini tidak dipakai sehari-hari. Anda hanya butuh kalau suatu
   > saat mau membuka isi database secara langsung. Simpan saja, jangan
   > sampai hilang.

3. **Region**: pilih **Southeast Asia (Singapore)**.
   Ini yang paling dekat dengan Indonesia, jadi aplikasi terasa cepat.
4. Klik **Create new project**.

Layarnya akan berputar sekitar dua menit sambil menyiapkan database.
Tunggu sampai selesai.

### 1.3 Buat tabelnya

Sekarang lemarinya sudah ada, tapi masih kosong tanpa laci. Kita buat
lacinya dengan menempelkan satu naskah yang sudah saya siapkan.

1. Di menu sebelah kiri, cari menu bertuliskan **SQL Editor**.
2. Klik **New query**. Muncul kotak putih besar yang kosong.
3. Sekarang buka berkas **skema.sql** dari folder Anda.

   > Cara membukanya: klik kanan berkasnya, pilih *Open with*, lalu pilih
   > **Notepad** (Windows) atau **TextEdit** (Mac). Jangan klik dua kali,
   > karena komputer mungkin bingung mau membukanya dengan apa.

4. Tekan **Ctrl+A** (Mac: **Cmd+A**) untuk memilih semua tulisannya, lalu
   **Ctrl+C** untuk menyalin.
5. Kembali ke kotak putih di Supabase, klik di dalamnya, tekan **Ctrl+V**.
6. Klik tombol **Run** di kanan bawah. Bisa juga tekan Ctrl+Enter.

**Yang benar:** muncul tulisan hijau *Success. No rows returned.*

Kalau muncul tulisan merah, berarti ada bagian yang belum tersalin
seluruhnya. Ulangi dari nomor 4 dan pastikan Anda menyalin dari baris
paling atas sampai paling bawah.

### 1.4 Ambil dua nilai penting

Ini alamat lemari arsip Anda. Kita butuh untuk bagian berikutnya.

Cara tercepat: klik tombol **Connect** di bagian atas dasbor proyek.
Alamat dan kuncinya ditampilkan bersamaan di situ.

Kalau ingin mencarinya lewat menu:

1. Di menu kiri paling bawah, klik ikon gerigi **Project Settings**.
2. Klik menu **API Keys** untuk kuncinya, dan **Data API** untuk alamatnya.
3. Yang Anda perlukan dua hal:

   - **Project URL** — teks pendek seperti `https://abcdefgh.supabase.co`
   - **Publishable key** — teks yang diawali `sb_publishable_`

4. **Biarkan halaman ini terbuka.** Kita akan menyalin keduanya sebentar
   lagi.

> **Kalau Anda pernah membaca panduan lain yang menyebut "anon public key"
> berawalan `eyJ`, itu nama lama.** Supabase menggantinya dengan
> publishable key, dan proyek yang dibuat sekarang sudah tidak punya kunci
> lama itu. Yang benar untuk aplikasi ini adalah publishable key.

> Kunci publishable memang dirancang untuk ditaruh di dalam aplikasi, jadi
> wajar kalau nanti terlihat orang. Yang tidak boleh dibagikan adalah kunci
> lain bernama **secret key** di halaman yang sama. Jangan disentuh.

---

## BAGIAN 2 — Menulis alamat ke dalam aplikasi

Sekarang kita beri tahu aplikasinya di mana lemari arsipnya berada.

1. Buka berkas **index.html** dari folder Anda dengan Notepad atau
   TextEdit. Sekali lagi: klik kanan, *Open with*, pilih Notepad.

   > Kalau Anda klik dua kali, berkas ini akan terbuka sebagai halaman web
   > di browser dan Anda tidak bisa mengeditnya. Itu bukan yang kita mau.

2. Di bagian atas ada dua baris seperti ini:

   ```
   alamatServer: "ISI_URL_SUPABASE_ANDA",
   kunciPublik: "ISI_KUNCI_PUBLIK_ANDA",
   ```

3. Hapus tulisan `ISI_URL_SUPABASE_ANDA` saja, lalu tempel **Project URL**
   dari Supabase di tempatnya.
4. Hapus tulisan `ISI_KUNCI_PUBLIK_ANDA` saja, lalu tempel **publishable
   key** di tempatnya.

**Tanda kutip dan tanda komanya jangan ikut terhapus.** Hasil akhirnya
harus terlihat seperti ini:

```
alamatServer: "https://abcdefgh.supabase.co",
kunciPublik: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSJ9.xxxx",
```

5. Simpan dengan **Ctrl+S** (Mac: **Cmd+S**), lalu tutup Notepad.

> Kesalahan paling sering di bagian ini: tanda kutip terhapus, atau ada
> spasi terbawa di dalam kutip. Kalau nanti aplikasi tidak mau tersambung,
> yang pertama diperiksa adalah dua baris ini.

---

## BAGIAN 3 — Membuat alamat aplikasi (Netlify)

### 3.1 Daftar

1. Buka **netlify.com**.
2. Klik **Sign up**, pilih **Sign up with Google**.

### 3.2 Unggah

1. Setelah masuk, klik menu **Sites** di atas.
2. Di halaman itu ada kotak bergaris putus-putus bertuliskan kira-kira
   *Drag and drop your project output folder here*.
3. Buka jendela penjelajah berkas Anda, cari **folder** berisi berkas tadi.
4. **Seret seluruh foldernya** ke dalam kotak bergaris putus-putus itu.

   > Yang diseret adalah foldernya, bukan berkas-berkas di dalamnya satu
   > per satu. Kalau Anda mengunggah berkas terpisah, aplikasinya tidak
   > akan jalan.

5. Tunggu beberapa detik. Netlify langsung memberi alamat acak seperti
   `bright-otter-8f3a12.netlify.app`.

### 3.3 Ganti nama alamatnya

Alamat acak susah diingat dan susah dibacakan lewat telepon.

1. Klik **Site configuration**.
2. Di bagian *Site details*, klik **Change site name**.
3. Ketik nama yang mudah, misalnya `gudang-sanurbay`.
   Kalau namanya sudah dipakai orang lain, tambahkan angka.
4. Alamat baru Anda menjadi `gudang-sanurbay.netlify.app`.

### 3.4 Uji

Buka alamat itu di browser.

**Yang benar:** muncul layar gelap dengan papan angka dan tulisan
*Masukkan kode akses*.

**Kalau muncul** *"Aplikasi belum tersambung ke server"*: berarti Bagian 2
belum berhasil. Perbaiki `index.html`, lalu ulangi Bagian 3.2 dengan
menyeret ulang foldernya. Netlify akan menimpa versi lama.

---

## BAGIAN 4 — Mengisi gudang

Kali pertama dibuka, aplikasi belum terkunci karena PIN admin belum ada.

1. Klik **Buat PIN admin** di kanan atas. Pilih angka yang Anda ingat,
   minimal empat digit. **Catat di tempat aman. Tidak ada cara memulihkan
   PIN yang lupa.**
2. Buka tab **Daftar barang**, klik **Tambah barang**. Isi satu per satu:
   nama, kategori, satuan, stok yang ada di gudang sekarang, batas minimum,
   dan harga satuannya.

   > Kalau Anda sebelumnya sudah memakai versi lama di satu perangkat:
   > jangan diketik ulang. Klik **Pulihkan dari berkas** dan pilih berkas
   > cadangan yang dulu Anda unduh. Semua barang dan riwayatnya pindah
   > sendiri ke server.

3. Buka tab **Akses staf**, klik **Tambah staf**. Isi nama, departemen,
   dan kode akses empat sampai delapan angka untuk tiap orang.

   Gunakan angka yang tidak mudah ditebak. Jangan memakai tanggal lahir
   atau urutan seperti 1234.

---

## BAGIAN 5 — Memasang di HP staf

Kirim alamat aplikasi ke tiap staf lewat WhatsApp. Lalu minta mereka
melakukan ini sekali saja:

**Android:** buka tautannya di **Chrome**, ketuk titik tiga di kanan atas,
pilih **Tambahkan ke layar utama**, ketuk **Tambah**.

**iPhone:** buka tautannya di **Safari** (harus Safari, bukan Chrome),
ketuk ikon kotak dengan panah ke atas di bawah layar, geser ke bawah,
pilih **Tambah ke Layar Utama**, ketuk **Tambah**.

Setelah itu muncul ikon di layar HP mereka. Dibuka dari situ, tampilannya
penuh satu layar tanpa alamat browser, persis seperti aplikasi biasa.

**Kode akses diberikan langsung ke orangnya**, jangan lewat grup WhatsApp.

---

## Cara pakai sehari-hari

**Staf:** buka ikon di HP, masukkan kode, catat barang yang diambil.
Namanya terisi otomatis dari kode yang dipakai, jadi tidak bisa mencatat
atas nama orang lain. Setelah sepuluh menit tanpa kegiatan, aplikasi
keluar sendiri.

**Anda:** masuk dengan PIN admin untuk mencatat barang masuk, mengubah
harga dan daftar barang, mengatur akses staf, dan menghapus catatan salah.

**Saat ada yang resign:** tab Akses staf, tekan **Tutup akses**. Kodenya
mati saat itu juga, tapi namanya tetap ada di catatan lama sehingga kartu
stok bulan sebelumnya tidak berubah.

---

## Kalau ada yang tidak beres

**"Aplikasi belum tersambung ke server"**
Dua baris di `index.html` belum benar. Periksa tanda kutipnya masih ada,
tidak ada spasi di dalam kutip, dan alamatnya diawali `https://`.

**"Server tidak terjangkau" di kop halaman**
Biasanya internet HP sedang mati. Kalau internet baik-baik saja, cek
dasbor Supabase, mungkin proyeknya sedang dihentikan sementara.

**Kode staf ditolak padahal sudah benar**
Pastikan aksesnya masih aktif di tab Akses staf. Kode yang sudah ditutup
memang sengaja ditolak.

**Angka stok berbeda antara dua HP**
Ketuk tulisan **segarkan** di kop halaman. Kalau masih berbeda, berarti
salah satu HP kehilangan internet saat mencatat.

**Proyek Supabase berhenti sendiri**
Paket gratis menghentikan sementara proyek yang tidak dipakai sekitar
seminggu. Buka dasbor Supabase, klik **Restore project**. Data Anda utuh.
Kalau gudang dipakai tiap hari, ini tidak akan terjadi.

---

## Perawatan rutin

**Sebulan sekali:** buka Daftar barang, klik **Unduh cadangan**, simpan
berkasnya ke Google Drive.

**Setahun sekali:** tutup buku untuk tahun sebelumnya. Angka riwayat dan
ringkasan tahunannya tetap bisa dibuka setelahnya.

---

## Yang perlu Anda ketahui soal keamanannya

Aplikasi ini memakai kode akses sederhana, bukan sistem akun dengan sandi
terenkripsi. Artinya kode dan PIN tersimpan apa adanya di database, dan
siapa pun yang tahu alamat aplikasi beserta kunci di dalamnya secara
teknis bisa membaca data gudang.

Untuk catatan stok sabun, handuk, dan air mineral, ini wajar. Jangan
sebarkan tautannya di luar hotel, dan jangan menulis informasi rahasia di
kolom catatan.

---

## Lampiran — Mengisi daftar barang dari Excel

Kalau barang Anda banyak, jangan diketik satu per satu di aplikasi.

1. Buka Excel, buat enam kolom dengan urutan persis seperti ini:

   | nama | kategori | satuan | stok saat ini | batas minimum | harga satuan |
   |------|----------|--------|---------------|---------------|--------------|
   | Sabun batang 30 gr | Amenities kamar | pcs | 480 | 200 | 2500 |
   | Handuk mandi putih | Linen & laundry | pcs | 210 | 80 | 85000 |

2. Isi seluruh barang gudang Anda, satu baris satu barang.
3. Klik **File**, **Save As**, pilih bentuk **CSV UTF-8 (Comma delimited)**.
4. Di aplikasi, buka tab **Daftar barang**, cari kotak
   *Isi daftar barang dari Excel*, klik **Pilih berkas CSV**.

Kategori yang boleh dipakai, tulis persis seperti ini:

- Amenities kamar
- Housekeeping
- Linen & laundry
- Makanan & minuman
- Alat tulis kantor
- Teknik & perawatan
- Lainnya

Kategori lain yang tidak dikenali akan otomatis jadi "Lainnya", dan bisa
Anda betulkan satu per satu setelah masuk.

Barang dengan nama yang sudah ada di daftar akan dilewati, jadi kalau
berkasnya terlanjur diimpor dua kali, tidak akan ada barang ganda.

Kalau bingung dengan bentuk berkasnya, klik **Unduh contoh formatnya**
di kotak yang sama, buka hasilnya di Excel, lalu ganti isinya dengan data
Anda sendiri.
