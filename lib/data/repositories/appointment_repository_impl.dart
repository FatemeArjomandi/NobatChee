import '../../../domain/entities/appointment_entity.dart';
import '../../../domain/repositories/appointment_repository.dart';
import '../datasources/local/appointment_local_datasource.dart';
import '../models/appointment_model.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentLocalDataSource localDataSource;

  AppointmentRepositoryImpl(this.localDataSource);

  @override
  Future<List<AppointmentEntity>> getAppointments(int businessId) async {
    return await localDataSource.getAppointments(businessId);
  }

  @override
  Future<void> addAppointment(AppointmentEntity appointment) async {
    final model = AppointmentModel(
      id: appointment.id,
      businessId: appointment.businessId,
      clientName: appointment.clientName,
      date: appointment.date,
      time: appointment.time,
    );
    await localDataSource.addAppointment(model);
  }

  @override
  Future<void> updateAppointment(AppointmentEntity appointment) async {
    final model = AppointmentModel(
      id: appointment.id,
      businessId: appointment.businessId,
      clientName: appointment.clientName,
      date: appointment.date,
      time: appointment.time,
    );
    await localDataSource.updateAppointment(model);
  }

  @override
  Future<void> deleteAppointment(int id) async {
    await localDataSource.deleteAppointment(id);
  }
}
