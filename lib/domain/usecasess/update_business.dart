import '../repositories/business_repository.dart';
import '../entities/business_entity.dart';

class UpdateBusiness {
  final BusinessRepository repository;

  UpdateBusiness(this.repository);

  Future<void> call(BusinessEntity business) {
    return repository.updateBusiness(business);
  }
}