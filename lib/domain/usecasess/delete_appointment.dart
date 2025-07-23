import '../repositories/appointment_repository.dart';

class DeleteAppointment {
  final AppointmentRepository repository;

  DeleteAppointment(this.repository);

  Future<void> call(int id) {
    return repository.deleteAppointment(id);
  }
}
