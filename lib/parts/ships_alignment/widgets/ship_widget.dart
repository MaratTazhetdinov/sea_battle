part of '../ships_alignment_part.dart';

class ShipWidget extends StatelessWidget {
  final Ship ship;
  final double cellHeight;

  const ShipWidget({
    super.key,
    required this.ship,
    required this.cellHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return SizedBox(
      height: switch (ship.shipAxis) {
        Axis.horizontal => cellHeight,
        Axis.vertical => ship.shipType.size * cellHeight,
      },
      width: switch (ship.shipAxis) {
        Axis.horizontal => ship.shipType.size * cellHeight,
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
            scrollDirection: ship.shipAxis,
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
            itemCount: ship.shipType.size,
          ),
        ),
      ),
    );
  }
}
