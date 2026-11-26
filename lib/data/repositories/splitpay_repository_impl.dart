import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/network/network_info.dart';
import '../datasources/local/local_database_service.dart';

typedef RegistroDato = Map<String, dynamic>;

class SplitPayRepositoryImpl {
  final NetworkInfo networkInfo;
  final LocalDatabaseService localDb;
  final FirebaseFirestore _firestore;

  SplitPayRepositoryImpl({
    required this.networkInfo,
    required this.localDb,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<RegistroDato>> getGroups() async {
    final online = await networkInfo.isConnected;
    if (online) {
      final snapshot = await _firestore
          .collection('groups')
          .orderBy('updated_at', descending: true)
          .get();

      final remoteGroups = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      await localDb.cacheGroups(remoteGroups);
      return remoteGroups;
    } else {
      return await localDb.getCachedGroups();
    }
  }

  Future<void> createGroup(RegistroDato groupData) async {
    final online = await networkInfo.isConnected;
    if (!online) {
      throw Exception('Sin conexión: conéctate a internet para crear un grupo.');
    }
    await _firestore.collection('groups').doc(groupData['id']).set(groupData);
    await localDb.cacheGroups([groupData]);
  }

  Future<List<RegistroDato>> getExpensesByGroup(String groupId) async {
    final online = await networkInfo.isConnected;
    if (online) {
      final snapshot = await _firestore
          .collection('groups')
          .doc(groupId)
          .collection('expenses')
          .orderBy('created_at', descending: true)
          .get();

      final remoteExpenses = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      await localDb.cacheExpenses(remoteExpenses);
      return remoteExpenses;
    } else {
      return await localDb.getCachedExpensesByGroup(groupId);
    }
  }

  Future<void> addExpense(String groupId, RegistroDato expenseData) async {
    final online = await networkInfo.isConnected;
    if (!online) {
      throw Exception('Modo sin conexión activo: no puedes registrar gastos nuevos sin internet.');
    }
    final groupRef = _firestore.collection('groups').doc(groupId);
    await groupRef
        .collection('expenses')
        .doc(expenseData['id'])
        .set(expenseData);

    await groupRef.update({
      'total_amount': FieldValue.increment(expenseData['amount'] as num),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await localDb.cacheExpenses([expenseData]);
  }
}