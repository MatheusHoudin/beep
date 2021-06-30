import 'package:beep/core/error/exception.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../error/exception.dart';

abstract class BeepInventoryRepository {
  Future registerInventory(BeepInventory inventory, String companyCode);

  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode);

  Future<List<BeepInventory>> fetchCompanyStartedInventories(String companyCode);

  Future<List<EmployeeInventoryAllocation>> fetchEmployeeInventoryAllocations(
      String inventoryCode, BeepUser loggedUser);

  Future registerInventoryProductCounting(String companyCode, String inventoryCode,
      EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct);

  Future<List<InventoryProduct>> fetchInventoryProducts(String companyCode, String inventoryCode);

  Future<List<InventoryEmployee>> fetchInventoryEmployees(String companyCode, String inventoryId);

  Future importInventoryProductsToInventory(
      String companyCode, String inventoryCode, List<InventoryProduct> inventoryProducts);

  Future<BeepInventory> fetchInventoryData(String companyCode, String inventoryId);

  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail);

  Future registerInventoryLocation(String companyCode, String inventoryCode, InventoryLocation inventoryLocation);

  Future<List<InventoryLocation>> fetchInventoryLocations(String companyCode, String inventoryCode);

  Future registerInventoryCountingSession(
      String companyCode, String inventoryCode, InventoryCountingSession inventoryCountingSession);

  Future<List<InventoryCountingSession>> fetchInventoryCountingSessions(String companyCode, String inventoryCode);

  Future<BeepInventoryCountingSessionsOptions> fetchInventoryCountingSessionsOptions(
      String companyCode, String inventoryCode);

  Future registerInventoryCountingSessionAllocation(String companyCode, String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation);

  Future<List<InventoryCountingSessionAllocation>> fetchInventoryCountingSessionAllocations(
      String companyCode, String inventoryCode, String countingSession);

  Future changeInventoryAllocationStatus(
      String companyCode, String inventoryCode, EmployeeInventoryAllocation inventoryAllocation);
}

class BeepInventoryRepositoryImpl extends BeepInventoryRepository {
  final FirebaseFirestore firestore;

  BeepInventoryRepositoryImpl({this.firestore});

  @override
  Future registerInventory(BeepInventory inventory, String companyCode) async {
    try {
      await firestore.collection('companies').doc(companyCode).collection('inventories').add(inventory.toJson());
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode) async {
    try {
      final inventoriesSnapshot =
          await firestore.collection('companies').doc(companyCode).collection('inventories').get();

      return inventoriesSnapshot.docs
          .map((e) => BeepInventory.fromJson(e.data()..putIfAbsent('id', () => e.id)))
          .toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<List<BeepInventory>> fetchCompanyStartedInventories(String companyCode) async {
    try {
      final inventoriesSnapshot = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .where('status', isEqualTo: 'Started')
          .get();

      return inventoriesSnapshot.docs
          .map((e) => BeepInventory.fromJson(e.data()..putIfAbsent('id', () => e.id)))
          .toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future importInventoryProductsToInventory(
      String companyCode, String inventoryCode, List<InventoryProduct> inventoryProducts) async {
    try {
      await Future.wait(inventoryProducts.map((e) {
        return firestore
            .collection('companies')
            .doc(companyCode)
            .collection('inventories')
            .doc(inventoryCode)
            .collection('products')
            .doc(e.code)
            .set(
                e.toJsonWithoutQuantityField(),
                SetOptions(
                  merge: true,
                ));
      }).toList());
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<BeepInventory> fetchInventoryData(String companyCode, String inventoryId) async {
    try {
      final inventorySnapshot =
          await firestore.collection('companies').doc(companyCode).collection('inventories').doc(inventoryId).get();
      final inventoryProducts = await inventorySnapshot.reference.collection('products').get();

      final data = inventorySnapshot.data();
      final inventoryDetailsJson = {
        'id': inventoryId,
        'name': data['name'],
        'description': data['description'],
        'date': data['date'],
        'time': data['time'],
        'status': data['status'],
        'products': inventoryProducts.docs.map((e) => e.data()).toList()
      };
      return BeepInventory.fromJson(inventoryDetailsJson);
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail) async {
    try {
      final foundUser = await firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .where('type', isNotEqualTo: 'company')
          .limit(1)
          .get();

      if (foundUser.docs.length == 0) throw InventoryUserNotFoundException();

      final inventoryUserWithNewUserEmail = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryId)
          .collection('employees')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (inventoryUserWithNewUserEmail.docs.length > 0) throw InventoryUserIsAlreadyRegisteredOnInventoryException();

      final userData = foundUser.docs.first.data();

      return await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryId)
          .collection('employees')
          .add({
        'name': userData['name'],
        'id': userData['id'],
        'email': userData['email'],
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<InventoryEmployee>> fetchInventoryEmployees(String companyCode, String inventoryId) async {
    try {
      final inventorySnapshot =
          await firestore.collection('companies').doc(companyCode).collection('inventories').doc(inventoryId).get();

      final inventoryEmployees = await inventorySnapshot.reference.collection('employees').get();
      return inventoryEmployees.docs.map((e) => InventoryEmployee.fromJson(e.data())).toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future registerInventoryLocation(
      String companyCode, String inventoryCode, InventoryLocation inventoryLocation) async {
    try {
      final locationExistsOnInventory = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('locations')
          .where('name', isEqualTo: inventoryLocation.name)
          .get();

      if (locationExistsOnInventory.size > 0) throw InventoryLocationAlreadyExistsException();

      return await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('locations')
          .add(inventoryLocation.toJson());
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<List<InventoryLocation>> fetchInventoryLocations(String companyCode, String inventoryCode) async {
    try {
      final inventoryLocationsReference = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('locations')
          .get();

      return inventoryLocationsReference.docs.map((e) => InventoryLocation.fromJson(e.data())).toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future registerInventoryCountingSession(
      String companyCode, String inventoryCode, InventoryCountingSession inventoryCountingSession) async {
    try {
      final inventoryCountingSessionReference = firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('sessions');

      final inventoryCountingAlreadyExists = await inventoryCountingSessionReference
          .where('name', isEqualTo: inventoryCountingSession.name)
          .limit(1)
          .get();

      if (inventoryCountingAlreadyExists.size > 0) throw InventoryCountingSessionAlreadyExistsException();

      return await inventoryCountingSessionReference.add(inventoryCountingSession.toJson());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<InventoryCountingSession>> fetchInventoryCountingSessions(
      String companyCode, String inventoryCode) async {
    try {
      final inventoryCountingSessions = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('sessions')
          .get();

      return inventoryCountingSessions.docs.map((e) => InventoryCountingSession.fromJson(e.data())).toList();
    } catch (e) {
      throw GenericException();
    }
  }

  @override
  Future<BeepInventoryCountingSessionsOptions> fetchInventoryCountingSessionsOptions(
      String companyCode, String inventoryCode) async {
    try {
      final inventoryReference =
          firestore.collection('companies').doc(companyCode).collection('inventories').doc(inventoryCode);

      final inventoryLocationsResult = await inventoryReference.collection('locations').get();
      final inventoryEmployeesResult = await inventoryReference.collection('employees').get();

      final inventoryLocations =
          inventoryLocationsResult.docs.map((e) => InventoryLocation.fromJson(e.data())).toList();
      final inventoryEmployees =
          inventoryEmployeesResult.docs.map((e) => InventoryEmployee.fromJson(e.data())).toList();

      return BeepInventoryCountingSessionsOptions(employees: inventoryEmployees, locations: inventoryLocations);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future registerInventoryCountingSessionAllocation(String companyCode, String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation) async {
    try {
      final allocationsReference = firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations');
      final allocationAlreadyExists = await allocationsReference
          .where('employee', isEqualTo: inventoryCountingSessionAllocation.employee.toJson())
          .where('location', isEqualTo: inventoryCountingSessionAllocation.location.name)
          .where('session', isEqualTo: countingSession)
          .limit(1)
          .get();

      if (allocationAlreadyExists.size > 0) throw AllocationAlreadyExistsException();

      return await allocationsReference.add({
        'employee': inventoryCountingSessionAllocation.employee.toJson(),
        'location': inventoryCountingSessionAllocation.location.toJson(),
        'session': countingSession,
        'status': 'NotStarted'
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<InventoryCountingSessionAllocation>> fetchInventoryCountingSessionAllocations(
      String companyCode, String inventoryCode, String countingSession) async {
    try {
      final allocationsResult = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .where('session', isEqualTo: countingSession)
          .get();

      return allocationsResult.docs.map((e) => InventoryCountingSessionAllocation.fromJson(e.data())).toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<List<EmployeeInventoryAllocation>> fetchEmployeeInventoryAllocations(
      String inventoryCode, BeepUser loggedUser) async {
    try {
      final employeeAllocationsResult = await firestore
          .collection('companies')
          .doc(loggedUser.companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .where('employee', isEqualTo: {'name': loggedUser.name, 'email': loggedUser.email}).get();

      return employeeAllocationsResult.docs.map((e) => EmployeeInventoryAllocation.fromJson(e.data())).toList();
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<List<InventoryProduct>> fetchInventoryProducts(String companyCode, String inventoryCode) async {
    try {
      final inventoryProductsResult = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('products')
          .get();

      return inventoryProductsResult.docs.map((e) => InventoryProduct.fromJson(e.data())).toList();
    } catch (e) {
      throw GenericException();
    }
  }

  @override
  Future registerInventoryProductCounting(String companyCode, String inventoryCode,
      EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct) async {
    try {
      final inventoryAllocationResult = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .where('employee', isEqualTo: inventoryAllocation.employeeAllocation.toJson())
          .where('location', isEqualTo: inventoryAllocation.inventoryLocation.toJson())
          .where('session', isEqualTo: inventoryAllocation.session)
          .limit(1)
          .get();

      if (inventoryAllocationResult.size == 0) throw InventoryAllocationNotFoundException();

      final inventoryAllocationId = inventoryAllocationResult.docs.first.id;
      final allocationProductCounting = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .doc(inventoryAllocationId)
          .collection('counting')
          .doc(inventoryProduct.code)
          .get();

      if (allocationProductCounting.exists) {
        final foundInventoryProduct = InventoryProduct.fromJson(allocationProductCounting.data());

        return await allocationProductCounting.reference.set(
            foundInventoryProduct.copyWithNewQuantity(inventoryProduct.quantity).toJson(),
            SetOptions(
              merge: true,
            ));
      }

      return await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .doc(inventoryAllocationId)
          .collection('counting')
          .doc(inventoryProduct.code)
          .set(inventoryProduct.toJson());
    } catch (e) {
      throw GenericException();
    }
  }

  @override
  Future changeInventoryAllocationStatus(
      String companyCode, String inventoryCode, EmployeeInventoryAllocation inventoryAllocation) async {
    try {
      final inventoryAllocationResult = await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .where('employee', isEqualTo: inventoryAllocation.employeeAllocation.toJson())
          .where('location', isEqualTo: inventoryAllocation.inventoryLocation.toJson())
          .where('session', isEqualTo: inventoryAllocation.session)
          .limit(1)
          .get();

      final inventoryAllocationId = inventoryAllocationResult.docs.first.id;
      final foundAllocation = EmployeeInventoryAllocation.fromJson(inventoryAllocationResult.docs.first.data());
      return await firestore
          .collection('companies')
          .doc(companyCode)
          .collection('inventories')
          .doc(inventoryCode)
          .collection('allocations')
          .doc(inventoryAllocationId)
          .update(foundAllocation.toJsonWithNewStatus());
    } catch (_) {
      throw GenericException();
    }
  }
}
