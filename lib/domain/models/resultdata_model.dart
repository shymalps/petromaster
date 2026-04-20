class ResultModel {
  final String yourAns;
  final String explanation;
  final String qns;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;
  final String currectAnwser;

  ResultModel({
    required this.yourAns,
    required this.explanation,
    required this.qns,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.optionE,
    required this.currectAnwser,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      yourAns: json['your_ans'] ?? '',
      explanation: json['explanation'] ?? '',
      qns: json['qns'] ?? '',
      optionA: json['option_a'] ?? '',
      optionB: json['option_b'] ?? '',
      optionC: json['option_c'] ?? '',
      optionD: json['option_d'] ?? '',
      optionE: json['option_e'] ?? '',
      currectAnwser: json['currect_anwser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'your_ans': yourAns,
      'explanation': explanation,
      'qns': qns,
      'option_a': optionA,
      'option_b': optionB,
      'option_c': optionC,
      'option_d': optionD,
      'option_e': optionE,
      'currect_anwser': currectAnwser,
    };
  }
}
