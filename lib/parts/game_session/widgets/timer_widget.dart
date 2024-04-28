part of '../game_session_part.dart';

/// Timer Widget.
class TimerWidget extends StatelessWidget {
  /// ValueNotifier for timerCount.
  final ValueNotifier<int> timerCount;

  /// Determines whose turn it is now.
  final bool isUserTurn;

  const TimerWidget({
    super.key,
    required this.timerCount,
    required this.isUserTurn,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: timerCount,
      builder: (context, value, _) {
        if (value == 0 && isUserTurn) {
          context.readGameSessionBloc.add(GameSessionUserSurrendered());
        }
        final minutes = value ~/ 60;
        final seconds = value % 60;
        final minutesStr = switch (minutes) {
          _ when minutes >= 0 && minutes < 10 => '0$minutes',
          _ => '$minutes',
        };
        final secondsStr = switch (seconds) {
          _ when seconds > 9 && seconds < 60 => '$seconds',
          _ when seconds > 0 && seconds < 10 => '0$seconds',
          _ => '00',
        };
        return Text(value < 0 ? '00:00' : '$minutesStr:$secondsStr');
      },
    );
  }
}
