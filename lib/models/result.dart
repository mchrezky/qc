class Result {
  bool status;
  int totQuestion;
  int totAnswer;
  int totNull;
  int totGood;
  int totNotgood;
  String result;
  Data data;

  Result(
      {this.status,
      this.totQuestion,
      this.totAnswer,
      this.totNull,
      this.totGood,
      this.totNotgood,
      this.result,
      this.data});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totQuestion = json['tot_question'];
    totAnswer = json['tot_answer'];
    totNull = json['tot_null'];
    totGood = json['tot_good'];
    totNotgood = json['tot_notgood'];
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['tot_question'] = this.totQuestion;
    data['tot_answer'] = this.totAnswer;
    data['tot_null'] = this.totNull;
    data['tot_good'] = this.totGood;
    data['tot_notgood'] = this.totNotgood;
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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