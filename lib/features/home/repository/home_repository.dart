// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/core/providers/firebase_providers.dart';
import 'package:finance_tracker/models/budget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository(firestore: ref.read(fireStoreProvider));
});

class HomeRepository {
  final FirebaseFirestore firestore;
  HomeRepository({
    required this.firestore,
  });
}
