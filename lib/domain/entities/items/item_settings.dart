class ItemSettings {
  final String name;
  final String imageLink;
  final bool isVisible;
  final int count;

  const ItemSettings({
    required this.name,
    required this.imageLink,
    required this.isVisible,
    required this.count,
  });

  ItemSettings copyWith({
    String? name,
    String? imageLink,
    bool? isVisible,
    int? count,
  }) {
    return ItemSettings(
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
      isVisible: isVisible ?? this.isVisible,
      count: count ?? this.count,
    );
  }
}
