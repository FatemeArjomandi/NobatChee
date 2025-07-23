import '../repositories/business_repository.dart';

class DeleteBusiness {
  final BusinessRepository repository;

  DeleteBusiness(this.repository);

  Future<void> call(int id) {
    return repository.deleteBusiness(id);
  }
}
