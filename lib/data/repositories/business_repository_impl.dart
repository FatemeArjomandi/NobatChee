import '../../domain/entities/business_entity.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/business_local_datasource.dart';
import '../models/business_model.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessLocalDataSource localDataSource;

  BusinessRepositoryImpl(this.localDataSource);

  @override
  Future<void> addBusiness(BusinessEntity business) async {
    final model = BusinessModel(
      id: business.id,
      name: business.name,
      phone: business.phone,
      address: business.address,
      description: business.description,
    );
    await localDataSource.insertBusiness(model);
  }

  @override
  Future<List<BusinessEntity>> getAllBusinesses() async {
    return await localDataSource.getAllBusinesses();
  }
}