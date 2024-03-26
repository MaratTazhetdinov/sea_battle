part of '../ships_alignment_part.dart';

class AlignmentBoardWidget extends StatefulWidget {
  final Size boardSize;
  final ValueNotifier<bool> userIsDragging;

  const AlignmentBoardWidget({
    super.key,
    required this.boardSize,
    required this.userIsDragging,
  });

  @override
  State<AlignmentBoardWidget> createState() => _AlignmentBoardWidgetState();
}

class _AlignmentBoardWidgetState extends State<AlignmentBoardWidget> {
  ValueNotifier<Board> board = ValueNotifier<Board>(Board(cellsNumber: 100));

  @override
  Widget build(BuildContext context) {
    final boardSize = widget.boardSize;
    return Container(
      height: boardSize.height,
      width: boardSize.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: widget.userIsDragging,
        builder: (context, userIsDragging, _) {
          return DragTarget(
            builder: (context, candidate, _) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 100,
              );
            },
          );
        },
      ),
    );
  }
}
