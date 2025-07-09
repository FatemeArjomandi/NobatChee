import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_local_datasource.dart';
import '../models/appointment_model.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentLocalDataSource localDataSource;

  AppointmentRepositoryImpl(this.localDataSource);

  @override
  Future<void> addAppointment(AppointmentEntity appointment) async {
    final model = AppointmentModel(
      id: appointment.id,
      businessId: appointment.businessId,
      clientName: appointment.clientName,
      date: appointment.date,
      time: appointment.time,
    );
    await localDataSource.insertAppointment(model);
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentsForBusiness(int businessId) async {
    return await localDataSource.getAppointmentsForBusiness(businessId);
  }
}