// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_tracker/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider((ref) {
  final homeRepository = ref.read(homeRepositoryProvider);
  return HomeController(homeRepository: homeRepository);
});

class HomeController {
  final HomeRepository homeRepository;
  HomeController({
    required this.homeRepository,
  });
}
