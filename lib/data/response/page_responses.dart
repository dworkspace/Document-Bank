class PageResponse {
  final String title;
  final String iconSvg;
  final String? subTitle;
  final String description;
  final String? photo;

  PageResponse({
    required this.title,
    required this.iconSvg,
    required this.description,
    this.photo,
    this.subTitle,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      title: json['title'] ?? "N/A",
      iconSvg: json['icon'] ?? "",
      description: json['description'] ?? "N/A",
      subTitle: json['subtitle'],
      photo: json['photo'],
    );
  }
}
