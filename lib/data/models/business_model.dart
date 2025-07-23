import '../../domain/entities/business_entity.dart';

class BusinessModel extends BusinessEntity {
  BusinessModel({
    super.id,
    required super.name,
    String? phone,
    String? description,
    String? address,
  }) : super(
          phone: phone ?? '',
          description: description ?? '',
          address: address ?? '',
        );

  factory BusinessModel.fromMap(Map<String, dynamic> map) => BusinessModel(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        description: map['description'],
        address: map['address'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'description': description,
        'address': address,
      };
}
