import '../entities/appointment_entity.dart';
import '../repositories/appointment_repository.dart';

class GetAppointments {
  final AppointmentRepository repository;

  GetAppointments(this.repository);

  Future<List<AppointmentEntity>> call(int businessId) {
    return repository.getAppointments(businessId);
  }
}
