-- =====================================================================
--  Buku Gudang Hotel — skema database
--  Tempel seluruh isi berkas ini ke Supabase > SQL Editor, lalu Run.
--  Cukup dijalankan sekali saat pertama kali menyiapkan server.
-- =====================================================================

create extension if not exists "pgcrypto";

-- ------------------------- tabel -------------------------

create table if not exists pengaturan (
  id     int primary key default 1,
  brand  text not null default 'Hotel Anda',
  pin    text
);

create table if not exists barang (
  id        uuid primary key default gen_random_uuid(),
  nama      text not null,
  kategori  text not null default 'Lainnya',
  satuan    text not null default 'pcs',
  stok_awal numeric not null default 0,
  minimum   numeric not null default 0,
  harga     numeric not null default 0,
  dibuat    timestamptz not null default now()
);

create table if not exists pengguna (
  id      uuid primary key default gen_random_uuid(),
  nama    text not null,
  dept    text not null default 'Housekeeping',
  kode    text not null unique,
  aktif   boolean not null default true,
  ditutup date,
  dibuat  timestamptz not null default now()
);

create table if not exists transaksi (
  id           uuid primary key default gen_random_uuid(),
  tanggal      date not null,
  barang_id    uuid not null references barang(id) on delete cascade,
  tipe         text not null check (tipe in ('masuk', 'keluar')),
  qty          numeric not null check (qty > 0),
  harga        numeric not null default 0,
  dept         text default '',
  staf_nama    text default '',
  staf_id      uuid references pengguna(id) on delete set null,
  catatan      text default '',
  dicatat_oleh text default '',
  dibuat       timestamptz not null default now()
);

create table if not exists arsip (
  bulan text primary key,
  isi   jsonb not null
);

create index if not exists transaksi_tanggal_idx on transaksi (tanggal);
create index if not exists transaksi_barang_idx  on transaksi (barang_id);

insert into pengaturan (id, brand) values (1, 'Hotel Anda')
on conflict (id) do nothing;

-- ------------------------- akses -------------------------
-- Aplikasi memakai kunci publik (publishable key) dan mengatur peran
-- lewat kode akses di dalam aplikasi. Karena itu kebijakan di bawah
-- mengizinkan aplikasi membaca dan menulis lima tabel ini.
--
-- Artinya: siapa pun yang tahu alamat proyek DAN kunci publik Anda bisa
-- membaca data gudang. Jangan sebarkan dua nilai itu di luar hotel, dan
-- jangan simpan informasi rahasia di kolom catatan.

alter table pengaturan enable row level security;
alter table barang     enable row level security;
alter table pengguna   enable row level security;
alter table transaksi  enable row level security;
alter table arsip      enable row level security;

do $$
declare t text;
begin
  foreach t in array array['pengaturan','barang','pengguna','transaksi','arsip'] loop
    execute format('drop policy if exists akses_aplikasi on %I', t);
    execute format(
      'create policy akses_aplikasi on %I for all using (true) with check (true)', t);
  end loop;
end $$;

-- ------------------- sinkronisasi antarperangkat -------------------
-- Supaya HP lain langsung ikut berubah tanpa perlu menyegarkan.

do $$
declare t text;
begin
  foreach t in array array['barang','transaksi','pengguna','pengaturan','arsip'] loop
    begin
      execute format('alter publication supabase_realtime add table %I', t);
    exception when duplicate_object then null;
    end;
  end loop;
end $$;
