import '../entities/business_entity.dart';

abstract class BusinessRepository {
  Future<void> addBusiness(BusinessEntity business);
  Future<List<BusinessEntity>> getAllBusinesses();
}