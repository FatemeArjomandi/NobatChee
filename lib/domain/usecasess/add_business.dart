import '../entities/business_entity.dart';
import '../repositories/business_repository.dart';

class AddBusiness {
  final BusinessRepository repository;

  AddBusiness(this.repository);

  Future<void> call(BusinessEntity business) {
    return repository.addBusiness(business);
  }
}