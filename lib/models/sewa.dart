class Sewa {
  String noSewa;
  String noAlat;
  String idCustomer;
  String lamaSewa;
  String tglSewa;
  String tglSelesai;
  String telpon;
  String namaPic;
  Null approve;
  Null accept;

  Sewa(
      {this.noSewa,
      this.noAlat,
      this.idCustomer,
      this.lamaSewa,
      this.tglSewa,
      this.tglSelesai,
      this.telpon,
      this.namaPic,
      this.approve,
      this.accept});

  Sewa.fromJson(Map<String, dynamic> json) {
    noSewa = json['no_sewa'];
    noAlat = json['no_alat'];
    idCustomer = json['id_customer'];
    lamaSewa = json['lama_sewa'];
    tglSewa = json['tgl_sewa'];
    tglSelesai = json['tgl_selesai'];
    telpon = json['telpon'];
    namaPic = json['nama_pic'];
    approve = json['approve'];
    accept = json['accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sewa'] = this.noSewa;
    data['no_alat'] = this.noAlat;
    data['id_customer'] = this.idCustomer;
    data['lama_sewa'] = this.lamaSewa;
    data['tgl_sewa'] = this.tglSewa;
    data['tgl_selesai'] = this.tglSelesai;
    data['telpon'] = this.telpon;
    data['nama_pic'] = this.namaPic;
    data['approve'] = this.approve;
    data['accept'] = this.accept;
    return data;
  }
}