class NumberOutput {
  final int randomNumber;
  final DateTime dateTime;

  NumberOutput({this.randomNumber, this.dateTime});

  factory NumberOutput.fromJson(Map<String, dynamic> json) {
    return NumberOutput(
      randomNumber: json["random"],
    );
  }

}

class Date{
  DateTime dateTime;

  static Map<String, dynamic> toMap(Date date) {
    return {
      "dateTime": date.dateTime
    };
  }

}