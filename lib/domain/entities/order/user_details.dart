import 'package:kurilki/data/models/order/user_details_table_model.dart';

class UserDetails {
  final String name;
  final String number;
  final String userId;

  const UserDetails({
    required this.name,
    required this.number,
    required this.userId,
  });

  UserDetails copyWith({
    String? name,
    String? number,
    String? userId,
  }) {
    return UserDetails(
      name: name ?? this.name,
      number: number ?? this.number,
      userId: userId ?? this.userId,
    );
  }

  factory UserDetails.fromTableModel(UserDetailsTableModel model) =>
      UserDetails(name: model.name, number: model.number, userId: model.userId);
}
