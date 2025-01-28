import '../../common/network.dart';
import '../chopper/ApiService.dart';
import '../models/homepage/home_model.dart';

class AppRepo {
  final ApiService apiService;

  AppRepo({required this.apiService});

  Future<NetworkState<List<HomeModel>>> getHome() async {
    try {
      var data = await apiService.getHome();
      if (data.isSuccessful && data.statusCode == 200) {
        return Success(homeModelFromJson(data.body.toString()));
      } else {
        return Error("Something went wrong, ${data.statusCode}.");
      }
    } catch (e) {
      return Error("Something went wrong: ${e.toString()}.");
    }
  }
}
