class AppointmentEntity {
  final int? id;
  final int businessId;
  final String clientName;
  final String date;
  final String time;

  AppointmentEntity({
    this.id,
    required this.businessId,
    required this.clientName,
    required this.date,
    required this.time,
  });
}