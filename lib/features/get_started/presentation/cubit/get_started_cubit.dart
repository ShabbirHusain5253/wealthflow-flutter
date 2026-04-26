import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'get_started_state.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  GetStartedCubit() : super(const GetStartedState());

  /// Orchestrates the Get Started animation sequence.
  Future<void> init() async {
    // Phase 1: "Take Control" Fade
    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;
    emit(const GetStartedState(status: GetStartedStatus.fadingTakeControl));

    // Phase 2: Rich Text Fade
    await Future.delayed(const Duration(milliseconds: 800));
    if (isClosed) return;
    emit(const GetStartedState(status: GetStartedStatus.fadingRichText));

    // Phase 3: Slide Headline
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    emit(const GetStartedState(status: GetStartedStatus.slidingHeadline));

    // Phase 4: Reveal Bullets
    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;
    emit(const GetStartedState(status: GetStartedStatus.revealingBullets));

    // Phase 5: Final completion (Button reveal)
    await Future.delayed(const Duration(milliseconds: 1200));
    if (isClosed) return;
    emit(const GetStartedState(status: GetStartedStatus.completed));
  }
}
