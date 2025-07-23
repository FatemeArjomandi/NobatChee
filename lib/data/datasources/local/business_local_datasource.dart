import '../../models/business_model.dart';

abstract class BusinessLocalDataSource {
  Future<List<BusinessModel>> getAllBusinesses();
  Future<void> addBusiness(BusinessModel business);
  Future<void> updateBusiness(BusinessModel business);
  Future<void> deleteBusiness(int id);
}