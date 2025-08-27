import 'package:micarro/src/core/models/company.dart';

class User {
  final String id;
  final String name;
  final List<Company> companies;

  User({required this.id, required this.name, required this.companies});
}
