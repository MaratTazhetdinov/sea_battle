part of '../ui_kit_part.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
  });

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;
  // late final Animation _secondAnimation;
  // late final Animation _thirdAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener((_) {})
      ..dispose();
    super.dispose();
  }

  Path _drawPath(double curveMaxHeight, Size size) {
    if (curveMaxHeight > size.height) {
      curveMaxHeight = size.height;
    }
    Path path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width / 2, size.height - curveMaxHeight,
        size.width, size.height * 0.7);
    return path;
  }

  Offset _calculateOffset(double value, Path path) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos?.position ?? const Offset(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final size =
                  Size(constraints.maxWidth - 180, constraints.maxHeight);
              final pathesList = [
                _drawPath(
                  size.height,
                  size,
                ),
                _drawPath(
                  size.height / 1.3,
                  size,
                ),
                _drawPath(
                  size.height / 1.8,
                  size,
                ),
              ];
              return SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    ...pathesList.map(
                      (path) => AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: _calculateOffset(_animation.value, path).dy,
                            left: _calculateOffset(_animation.value, path).dx,
                            child: CircleAvatar(
                              backgroundColor: colors.firstTextColor,
                              radius: 5,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            child: SizedBox(
              width: 100,
              child: Image.asset(
                Assets.images.loaderShipOne.path,
                color: colors.firstTextColor,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              width: 100,
              child: Image.asset(
                Assets.images.loaderShipTwo.path,
                color: colors.firstTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
