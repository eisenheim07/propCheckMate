import 'package:chopper/chopper.dart';

import '../../common/config.dart';
import '../models/homepage/home_model.dart';

part 'ApiService.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: Config.GET_API)
  Future<Response> getHome();

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(Config.BASE_URL),
      interceptors: [
        HttpLoggingInterceptor(),
        const HeadersInterceptor({'Cache-Control': 'no-cache'}),
      ],
      services: [_$ApiService()],
    );
    return _$ApiService(client);
  }
}
