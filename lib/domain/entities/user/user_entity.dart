class AccountEntity {
  final String uuid;
  final String name;
  final String imageLink;

  const AccountEntity({
    required this.uuid,
    required this.name,
    required this.imageLink,
  });

  AccountEntity copyWith({
    String? uuid,
    String? name,
    String? imageLink,
  }) {
    return AccountEntity(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
    );
  }

  @override
  String toString() => 'UserEntity(uuid: $uuid, name: $name, imageLink: $imageLink)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountEntity && other.uuid == uuid && other.name == name && other.imageLink == imageLink;
  }

  @override
  int get hashCode => uuid.hashCode ^ name.hashCode ^ imageLink.hashCode;
}
