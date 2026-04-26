import 'package:equatable/equatable.dart';

enum GetStartedStatus {
  initial,
  fadingTakeControl,
  fadingRichText,
  slidingHeadline,
  revealingBullets,
  completed
}

class GetStartedState extends Equatable {
  final GetStartedStatus status;

  const GetStartedState({this.status = GetStartedStatus.initial});

  @override
  List<Object> get props => [status];
}
