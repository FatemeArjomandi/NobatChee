import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    super.id,
    required super.businessId,
    required super.clientName,
    required super.date,
    required super.time,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      businessId: map['business_id'],
      clientName: map['client_name'],
      date: map['date'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'business_id': businessId,
      'client_name': clientName,
      'date': date,
      'time': time,
    };
  }
}