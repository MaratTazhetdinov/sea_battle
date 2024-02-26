part of '../ui_kit_part.dart';

void showLoader(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AppLoader();
      });
}

class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
  });

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with TickerProviderStateMixin {
  late final AnimationController _cannonballAnimationController;
  late final Animation _cannonballAnimation;
  late final AnimationController _shipAnimationController;
  late final Animation _shipAnimation;

  @override
  void initState() {
    _cannonballAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: defaultLoadingAnimationDurationInMilliseconds),
    );
    _cannonballAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _cannonballAnimationController,
      curve: Curves.easeInOut,
    ));
    _cannonballAnimationController.forward();
    _cannonballAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _cannonballAnimationController.forward(from: 0);
      }
    });
    _shipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: defaultLoadingAnimationDurationInMilliseconds),
    );
    _shipAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: -0.05,
            end: 0.05,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 0.05,
            end: -0.05,
          ),
          weight: 50,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _shipAnimationController,
        curve: Curves.linear,
      ),
    );
    _shipAnimationController.forward();
    _shipAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shipAnimationController.forward(from: 0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cannonballAnimationController
      ..removeStatusListener((_) {})
      ..dispose();
    _shipAnimationController
      ..removeStatusListener((status) {})
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
    final theme = context.theme;
    final colors = theme.colors;
    final locale = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          color: colors.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final size = Size(constraints.maxWidth - 180,
                              constraints.maxHeight);
                          final pathsList = [
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
                                ...pathsList.map(
                                  (path) => AnimatedBuilder(
                                    animation: _cannonballAnimation,
                                    builder: (context, _) {
                                      return Positioned(
                                        top: _calculateOffset(
                                                _cannonballAnimation.value,
                                                path)
                                            .dy,
                                        left: _calculateOffset(
                                                _cannonballAnimation.value,
                                                path)
                                            .dx,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              colors.firstTextColor,
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
                          child: AnimatedBuilder(
                              animation: _shipAnimationController,
                              builder: (context, _) {
                                return Transform.rotate(
                                  angle: _shipAnimation.value,
                                  child: Image.asset(
                                    Assets.images.loaderShipOne.path,
                                    color: colors.firstTextColor,
                                  ),
                                );
                              }),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: SizedBox(
                          width: 100,
                          child: AnimatedBuilder(
                              animation: _shipAnimationController,
                              builder: (context, _) {
                                return Transform.rotate(
                                  angle: _shipAnimation.value,
                                  child: Image.asset(
                                    Assets.images.loaderShipTwo.path,
                                    color: colors.firstTextColor,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    locale.loading,
                    style: theme.textTheme.titleMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
