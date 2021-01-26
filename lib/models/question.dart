class Question {
  int idQuestion;
  String noAlat;
  String question;
  int cat;

  Question({this.idQuestion, this.noAlat, this.question, this.cat});

  Question.fromJson(Map<String, dynamic> json) {
    idQuestion = json['id_question'];
    noAlat = json['no_alat'];
    question = json['question'];
    cat = json['cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_question'] = this.idQuestion;
    data['no_alat'] = this.noAlat;
    data['question'] = this.question;
    data['cat'] = this.cat;
    return data;
  }
}