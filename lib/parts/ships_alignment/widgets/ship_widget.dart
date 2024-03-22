part of '../ships_alignment_part.dart';

class ShipWidget extends StatelessWidget {
  final ShipType shipType;
  final Axis axis;
  final double cellHeight;

  const ShipWidget({
    super.key,
    required this.shipType,
    required this.axis,
    required this.cellHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return SizedBox(
      height: switch (axis) {
        Axis.horizontal => cellHeight,
        Axis.vertical => shipType.cellCount * cellHeight,
      },
      width: switch (axis) {
        Axis.horizontal => shipType.cellCount * cellHeight,
        Axis.vertical => cellHeight,
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.firstTextColor,
            width: 0.5,
          ),
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            scrollDirection: axis,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: cellHeight,
                width: cellHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.firstTextColor,
                    width: 0.5,
                  ),
                  color: colors.scaffoldBackgroundColor,
                ),
              );
            },
            itemCount: shipType.cellCount,
          ),
        ),
      ),
    );
  }
}
