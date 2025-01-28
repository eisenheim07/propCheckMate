import 'package:bloc/bloc.dart';
import 'package:propcheckmate/businessLogic/models/homepage/home_model.dart';
import 'package:propcheckmate/businessLogic/repo/AppRepo.dart';
import 'package:propcheckmate/common/network.dart';

class HomeCubit extends Cubit<NetworkState<List<HomeModel>>> {
  final AppRepo appRepo;

  HomeCubit(this.appRepo) : super(Loading());

  Future<void> fetchData() async {
    emit(Loading());
    final result = await appRepo.getHome();
    emit(result);
  }
}
