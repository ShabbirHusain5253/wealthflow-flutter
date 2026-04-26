import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wealthflow/core/constants/api_constants.dart';
import 'package:wealthflow/features/dashboard/data/models/assets_response.dart';
import 'package:wealthflow/features/dashboard/data/models/net_worth_model.dart';

part 'dashboard_remote_data_source.g.dart';

@RestApi()
abstract class DashboardRemoteDataSource {
  factory DashboardRemoteDataSource(Dio dio, {String baseUrl}) = _DashboardRemoteDataSource;

  @GET(ApiConstants.netWorth)
  Future<NetWorthModel> getNetWorth(@Query('filter') String filter);

  @GET(ApiConstants.assets)
  Future<AssetsResponse> getAssets();
}
