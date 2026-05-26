class RatingModel {
  final double rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel.fromMap(json);

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      rate: (map['rate'] ?? 0).toDouble(),
      count: map['count']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'rate': rate,
    'count': count,
  };
}