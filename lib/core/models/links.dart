class Links {
  final String self;
  final String first;
  final String last;
  final String next;

  Links({
    required this.self,
    required this.first,
    required this.last,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'] ?? '',
      first: json['first'] ?? '',
      last: json['last'] ?? '',
      next: json['next'] ?? '',
    );
  }
}
