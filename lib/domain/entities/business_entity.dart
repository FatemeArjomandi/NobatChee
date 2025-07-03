class BusinessEntity {
  final int? id;
  final String name;
  final String phone;
  final String address;
  final String description;

  BusinessEntity({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.description,
  });
}