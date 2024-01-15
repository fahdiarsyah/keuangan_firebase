class Transaksi {
  final String uid;
  final String docId;
  
  final String namaTransaksi;
  final DateTime tanggal;
  final double nominal;
  final String kategori;
  final String gambar;
  final String nama;

  Transaksi({
    required this.uid,
    required this.docId,
    required this.namaTransaksi,
    required this.tanggal,
    required this.nominal,
    required this.kategori,
    required this.gambar,
    required this.nama,
  });
}
