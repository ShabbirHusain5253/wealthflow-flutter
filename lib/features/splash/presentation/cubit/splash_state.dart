import 'package:equatable/equatable.dart';

enum SplashStatus { initial, animatingLogo, animatingBranding, completed }

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({this.status = SplashStatus.initial});

  @override
  List<Object> get props => [status];
}
