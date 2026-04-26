import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wealthflow/core/constants/api_constants.dart';
import 'package:wealthflow/features/auth/data/models/auth_model.dart';
import 'package:wealthflow/features/auth/data/models/register_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  @POST(ApiConstants.register)
  Future<HttpResponse<AuthModel>> register(@Body() RegisterModel model);
}
