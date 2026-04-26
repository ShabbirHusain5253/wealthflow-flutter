import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/features/dashboard/domain/entities/asset_entity.dart';
import 'package:wealthflow/features/dashboard/domain/entities/net_worth_entity.dart';
import 'package:wealthflow/features/dashboard/domain/usecases/get_net_worth_usecase.dart';
import 'package:wealthflow/features/dashboard/domain/usecases/get_assets_usecase.dart';
import 'package:wealthflow/core/usecase/usecase.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:wealthflow/core/storage/app_storage.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetNetWorthUseCase _getNetWorthUseCase;
  final GetAssetsUseCase _getAssetsUseCase;

  DashboardBloc(this._getNetWorthUseCase, this._getAssetsUseCase)
      : super(DashboardState.initial()) {
    on<FetchDashboardData>(_onFetchDashboardData);
    on<ChangeChartPeriod>(_onChangeChartPeriod);
    on<FetchAssets>(_onFetchAssets);
  }

  bool _isMockUser() {
    try {
      final token = sl<AppStorage>().getToken();
      return token == null || token.isEmpty;
    } catch (_) {
      return true; // Fallback to mock if storage not ready
    }
  }

  Future<void> _onFetchDashboardData(
    FetchDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));

      if (_isMockUser()) {
        await Future.delayed(const Duration(milliseconds: 600));
        emit(state.copyWith(
          status: DashboardStatus.loaded,
          netWorth: 245000.0,
          netWorthChange: 12500.0,
          netWorthChangePercentage: 5.2,
          lastUpdated: DateTime.now(),
          chartData: const [
            FlSpot(0, 200000),
            FlSpot(1, 210000),
            FlSpot(2, 205000),
            FlSpot(3, 230000),
            FlSpot(4, 245000),
          ],
        ));
      } else {
        final results = await Future.wait([
          _getNetWorthUseCase.call(params: state.selectedPeriod),
          Future.delayed(const Duration(milliseconds: 600)),
        ]);

        final result = results[0] as Either<Failure, NetWorthEntity>;

        result.fold(
          (failure) => emit(state.copyWith(status: DashboardStatus.error)),
          (netWorth) {
            emit(state.copyWith(
              status: DashboardStatus.loaded,
              netWorth: netWorth.currentNetWorth,
              netWorthChange: netWorth.absoluteChange,
              netWorthChangePercentage: netWorth.percentageChange,
              lastUpdated: netWorth.lastUpdated,
              chartData: netWorth.timeline
                  .map((e) => FlSpot(
                        e.date.millisecondsSinceEpoch.toDouble(),
                        e.netWorth,
                      ))
                  .toList(),
            ));
          },
        );
      }
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.error));
    } finally {
      if (!isClosed) {
        add(FetchAssets());
      }
    }
  }

  Future<void> _onChangeChartPeriod(
    ChangeChartPeriod event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedPeriod: event.period,
        status: DashboardStatus.loading,
      ));

      if (_isMockUser()) {
        await Future.delayed(const Duration(milliseconds: 600));
        emit(state.copyWith(
          status: DashboardStatus.loaded,
          netWorth: 245000.0,
          netWorthChange: 12500.0,
          netWorthChangePercentage: 5.2,
          lastUpdated: DateTime.now(),
          chartData: const [
            FlSpot(0, 200000),
            FlSpot(1, 210000),
            FlSpot(2, 205000),
            FlSpot(3, 230000),
            FlSpot(4, 245000),
          ],
        ));
      } else {
        final results = await Future.wait([
          _getNetWorthUseCase.call(params: event.period),
          Future.delayed(const Duration(milliseconds: 600)),
        ]);

        final result = results[0] as Either<Failure, NetWorthEntity>;

        result.fold(
          (failure) => emit(state.copyWith(status: DashboardStatus.error)),
          (netWorth) {
            emit(state.copyWith(
              status: DashboardStatus.loaded,
              netWorth: netWorth.currentNetWorth,
              netWorthChange: netWorth.absoluteChange,
              netWorthChangePercentage: netWorth.percentageChange,
              lastUpdated: netWorth.lastUpdated,
              chartData: netWorth.timeline
                  .map((e) => FlSpot(
                        e.date.millisecondsSinceEpoch.toDouble(),
                        e.netWorth,
                      ))
                  .toList(),
            ));
          },
        );
      }
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.error));
    }
  }

  Future<void> _onFetchAssets(
    FetchAssets event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(assetStatus: DashboardStatus.loading));

      if (_isMockUser()) {
        await Future.delayed(const Duration(milliseconds: 600));
        emit(state.copyWith(
          assetStatus: DashboardStatus.loaded,
          assetList: [
            AssetEntity(id: '1', name: 'Cash', amount: 45000.0, updatedAt: DateTime.now()),
            AssetEntity(id: '2', name: 'Stocks', amount: 150000.0, updatedAt: DateTime.now()),
            AssetEntity(id: '3', name: 'Real Estate', amount: 50000.0, updatedAt: DateTime.now()),
          ],
        ));
      } else {
        final results = await Future.wait([
          _getAssetsUseCase.call(params: NoParams()),
          Future.delayed(const Duration(milliseconds: 600)),
        ]);

        final result = results[0] as Either<Failure, List<AssetEntity>>;

        result.fold(
          (failure) => emit(state.copyWith(assetStatus: DashboardStatus.error)),
          (assets) {
            emit(state.copyWith(
              assetStatus: DashboardStatus.loaded,
              assetList: assets,
            ));
          },
        );
      }
    } catch (e) {
      emit(state.copyWith(assetStatus: DashboardStatus.error));
    }
  }
}
