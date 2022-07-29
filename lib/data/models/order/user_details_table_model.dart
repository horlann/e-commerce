import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/order/user_details.dart';

part 'user_details_table_model.g.dart';

@JsonSerializable()
class UserDetailsTableModel {
  @JsonKey(name: FirestoreSchema.name)
  final String name;
  @JsonKey(name: FirestoreSchema.number)
  final String number;
  @JsonKey(name: FirestoreSchema.userId)
  final String userId;

  const UserDetailsTableModel({
    required this.name,
    required this.number,
    required this.userId,
  });

  factory UserDetailsTableModel.fromJson(Map<String, dynamic> json) => _$UserDetailsTableModelFromJson(json);

  factory UserDetailsTableModel.fromEntity(UserDetails userDetails) => UserDetailsTableModel(
        name: userDetails.name,
        number: userDetails.number,
        userId: userDetails.userId,
      );

  Map<String, dynamic> toJson() => _$UserDetailsTableModelToJson(this);
}
