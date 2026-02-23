class TvModel{

  final String name;
  final String abbrev;
  final String description;

  TvModel({
    required this.name,
    required this.abbrev,
    required this.description
});

}

class TvServiceModel{

  final String title;
  final String duration;
  final String amount;

  TvServiceModel({
    required this.title,
    required this.amount,
    required this.duration
});
}