class Sewa {
  String noSewa;
  String noAlat;
  String idCustomer;
  String lamaSewa;
  String tglSewa;
  String tglSelesai;
  String telpon;
  String namaPic;
  String approve;
  String accept;
  String pic;
  String customer;
  String alat;

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
      this.accept,
      this.pic,
      this.customer,
      this.alat});

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
    pic = json['pic'];
    customer = json['customer'];
    alat = json['alat'];
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
    data['pic'] = this.pic;
    data['customer'] = this.customer;
    data['alat'] = this.alat;
    return data;
  }
}