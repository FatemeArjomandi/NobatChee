import '../entities/business_entity.dart';

abstract class BusinessRepository {
  Future<List<BusinessEntity>> getAllBusinesses();
  Future<void> addBusiness(BusinessEntity business);
  Future<void> updateBusiness(BusinessEntity business);
  Future<void> deleteBusiness(int id);
}
