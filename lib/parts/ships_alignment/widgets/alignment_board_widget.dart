part of '../ships_alignment_part.dart';

class AlignmentBoardWidget extends StatefulWidget {
  final Size boardSize;

  const AlignmentBoardWidget({super.key, required this.boardSize});

  @override
  State<AlignmentBoardWidget> createState() => _AlignmentBoardWidgetState();
}

class _AlignmentBoardWidgetState extends State<AlignmentBoardWidget> {
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
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemBuilder: (context, index) {
          return SizedBox(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
          );
        },
        itemCount: 100,
      ),
    );
  }
}
