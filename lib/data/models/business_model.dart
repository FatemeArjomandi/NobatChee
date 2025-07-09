import '../../domain/entities/business_entity.dart';

class BusinessModel extends BusinessEntity {
  BusinessModel({
    super.id,
    required super.name,
    required super.phone,
    required super.address,
    required super.description,
  });

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'description': description,
    };
  }
}