import '../../models/appointment_model.dart';

abstract class AppointmentLocalDataSource {
  Future<List<AppointmentModel>> getAppointments(int businessId);
  Future<void> addAppointment(AppointmentModel appointment);
  Future<void> updateAppointment(AppointmentModel appointment);
  Future<void> deleteAppointment(int id);
}
