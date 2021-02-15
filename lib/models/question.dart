class Question {
  int id;
  String noAlat;
  String question;
  int cat;
  String categori;
  String idInspection;
  String idSewa;
  int idQuestion;
  String tglInspection;
  String result;
  String cekInspection;

  Question(
      {this.id,
      this.noAlat,
      this.question,
      this.cat,
      this.categori,
      this.idInspection,
      this.idSewa,
      this.idQuestion,
      this.tglInspection,
      this.result,
      this.cekInspection});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noAlat = json['no_alat'];
    question = json['question'];
    cat = json['cat'];
    categori = json['categori'];
    idInspection = json['id_inspection'];
    idSewa = json['id_sewa'];
    idQuestion = json['id_question'];
    tglInspection = json['tgl_inspection'];
    result = json['result'];
    cekInspection = json['cek_inspection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_alat'] = this.noAlat;
    data['question'] = this.question;
    data['cat'] = this.cat;
    data['categori'] = this.categori;
    data['id_inspection'] = this.idInspection;
    data['id_sewa'] = this.idSewa;
    data['id_question'] = this.idQuestion;
    data['tgl_inspection'] = this.tglInspection;
    data['result'] = this.result;
    data['cek_inspection'] = this.cekInspection;
    return data;
  }
}