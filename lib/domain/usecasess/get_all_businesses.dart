import '../repositories/business_repository.dart';
import '../entities/business_entity.dart';

class GetAllBusinesses {
  final BusinessRepository repository;

  GetAllBusinesses(this.repository);

  Future<List<BusinessEntity>> call() {
    return repository.getAllBusinesses();
  }
}