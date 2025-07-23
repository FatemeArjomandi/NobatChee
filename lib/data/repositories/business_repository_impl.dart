import '../../../domain/entities/business_entity.dart';
import '../../../domain/repositories/business_repository.dart';
import '../datasources/local/business_local_datasource.dart';
import '../models/business_model.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessLocalDataSource localDataSource;

  BusinessRepositoryImpl(this.localDataSource);

  @override
  Future<List<BusinessEntity>> getAllBusinesses() async {
    return await localDataSource.getAllBusinesses();
  }

  @override
  Future<void> addBusiness(BusinessEntity business) async {
    final model = BusinessModel(
      id: business.id,
      name: business.name,
      phone: business.phone,
      description: business.description,
      address: business.address,
    );
    return await localDataSource.addBusiness(model);
  }

  @override
  Future<void> updateBusiness(BusinessEntity business) async {
    final model = BusinessModel(
      id: business.id,
      name: business.name,
      phone: business.phone,
      description: business.description,
      address: business.address,
    );
    return await localDataSource.updateBusiness(model);
  }

  @override
  Future<void> deleteBusiness(int id) async {
    return await localDataSource.deleteBusiness(id);
  }
}
