import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/business_model.dart';
import '../models/service_model.dart';

abstract class BusinessRemoteDataSource {
  Future<List<BusinessModel>> getBusinesses();
  Future<BusinessModel> getBusinessById(String id);
  Future<List<ServiceModel>> getServicesForBusiness(String businessId);
  Future<void> updateBusinessStatus(String businessId, bool isOpen);
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final FirebaseFirestore firestore;

  BusinessRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<BusinessModel>> getBusinesses() async {
    try {
      final snapshot = await firestore.collection('businesses').get();
      return snapshot.docs
          .map((doc) => BusinessModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<BusinessModel> getBusinessById(String id) async {
    try {
      final doc = await firestore.collection('businesses').doc(id).get();
      if (!doc.exists) {
        throw ServerException();
      }
      return BusinessModel.fromMap(doc.data()!, doc.id);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ServiceModel>> getServicesForBusiness(String businessId) async {
    try {
      final snapshot = await firestore
          .collection('businesses')
          .doc(businessId)
          .collection('services')
          .get();
      return snapshot.docs
          .map((doc) => ServiceModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateBusinessStatus(String businessId, bool isOpen) async {
    try {
      await firestore.collection('businesses').doc(businessId).update({
        'isOpen': isOpen,
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
