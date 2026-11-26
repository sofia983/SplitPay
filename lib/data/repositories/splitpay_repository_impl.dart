import '../../core/network/network_info.dart';
import '../../core/notifications/notification_service.dart';
import '../datasources/local/local_database_service.dart';
import '../datasources/remote/firestore_remote_datasource.dart';

typedef RegistroDato = Map<String, dynamic>;

class SplitPayRepositoryImpl {
  final NetworkInfo networkInfo;
  final LocalDatabaseService localDb;
  final FirestoreRemoteDatasource remoteDb;

  SplitPayRepositoryImpl({
    required this.networkInfo,
    required this.localDb,
    required this.remoteDb,
  });

  /// Obtiene grupos: si hay internet consulta Firestore y actualiza SQLite;
  /// si está offline lee directamente desde SQLite.
  Future<List<RegistroDato>> getGroups() async {
    final online = await networkInfo.isConnected;
    if (online) {
      final remoteGroups = await remoteDb.getGroups();
      await localDb.cacheGroups(remoteGroups);
      return remoteGroups;
    } else {
      return await localDb.getCachedGroups();
    }
  }

  /// Crea un grupo: requiere conexión a internet (y rol admin en reglas)
  Future<void> createGroup(RegistroDato groupData) async {
    final online = await networkInfo.isConnected;
    if (!online) {
      throw Exception('Sin conexión: conéctate a internet para crear un grupo.');
    }
    await remoteDb.createGroup(groupData);
    await localDb.cacheGroups([groupData]);
  }

  /// Obtiene gastos de un grupo con respaldo automático en SQLite
  Future<List<RegistroDato>> getExpensesByGroup(String groupId) async {
    final online = await networkInfo.isConnected;
    if (online) {
      final remoteExpenses = await remoteDb.getExpensesByGroup(groupId);
      await localDb.cacheExpenses(remoteExpenses);
      return remoteExpenses;
    } else {
      return await localDb.getCachedExpensesByGroup(groupId);
    }
  }

  /// Registra un gasto: bloquea en modo offline y dispara notificación local al guardar
  Future<void> addExpense(String groupId, RegistroDato expenseData) async {
    final online = await networkInfo.isConnected;
    if (!online) {
      throw Exception('Modo sin conexión activo: no puedes registrar gastos nuevos sin internet.');
    }
    await remoteDb.addExpense(groupId, expenseData);
    await localDb.cacheExpenses([expenseData]);

    await NotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Nuevo gasto en SplitPay',
      body: '${expenseData['description']} por \$${expenseData['amount']}',
    );
  }
}