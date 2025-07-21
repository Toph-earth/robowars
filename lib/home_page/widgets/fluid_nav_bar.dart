import 'package:flutter/material.dart';

class FluidNavBar extends StatefulWidget {
  final List<IconData> icons;
  final List<String>? labels;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Gradient? activeGradient;
  final Color activeColor;
  final Color inactiveColor;
  final Color barBackgroundColor;
  final double iconSize;
  final double barHeight;
  final double bubbleSize;
  final BuildContext context;

  const FluidNavBar({
    Key? key,
    required this.icons,
    this.labels,
    required this.currentIndex,
    required this.onTap,
    this.activeGradient,
    this.activeColor = Colors.deepPurple,
    this.inactiveColor = Colors.grey,
    this.barBackgroundColor = Colors.white,
    this.iconSize = 24.0,
    this.barHeight = 50.0,
    this.bubbleSize = 48.0,
    required this.context,
  }) : assert(icons.length >= 2, 'At least 2 icons are required'),
       super(key: key);

  @override
  _FluidNavBarState createState() => _FluidNavBarState();
}

class _FluidNavBarState extends State<FluidNavBar>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _previousIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(); // Initialize animation
  }

  @override
  void didUpdateWidget(FluidNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    if (index != _currentIndex) {
      _previousIndex = _currentIndex;
      setState(() => _currentIndex = index);
      widget.onTap(index);
      _controller.forward(from: 0);
      switch (index) {
        case 0:
          Navigator.pushNamed(widget.context, '/home');
          break;
        case 1:
          Navigator.pushNamed(widget.context, '/schedule');
          break;
        case 2:
          Navigator.pushNamed(widget.context, '/teams');
          break;
        case 3:
          Navigator.pushNamed(widget.context, '/updates');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconCount = widget.icons.length;
    final iconWidth = MediaQuery.of(context).size.width / iconCount;
    final bubbleCenter = iconWidth * _currentIndex + iconWidth / 2;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: widget.barHeight + safeAreaBottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Bar with Dip
          Positioned.fill(
            top: 20,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double bubbleCenter;
                if (_previousIndex != null && _animation.value < 1) {
                  // Animate between positions
                  final fromCenter =
                      iconWidth * _previousIndex! + iconWidth / 2;
                  final toCenter = iconWidth * _currentIndex + iconWidth / 2;
                  bubbleCenter =
                      fromCenter + (toCenter - fromCenter) * _animation.value;
                } else {
                  // Resting position
                  bubbleCenter = iconWidth * _currentIndex + iconWidth / 2;
                }

                return ClipPath(
                  clipper: _BarClipper(
                    bubbleCenter: bubbleCenter,
                    bubbleRadius: widget.bubbleSize / 2,
                    barHeight: widget.barHeight,
                  ),
                  child: Container(color: widget.barBackgroundColor),
                );
              },
            ),
          ),

          // Icons
          Positioned.fill(
            child: Row(
              children: List.generate(iconCount, (index) {
                final isActive = index == _currentIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isActive) ...[
                          SizedBox(height: widget.barHeight - 24),
                          Icon(
                            widget.icons[index],
                            size: widget.iconSize,
                            color: widget.inactiveColor,
                          ),
                        ],
                        if (widget.labels != null &&
                            widget.labels!.length > index)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              widget.labels![index],
                              style: TextStyle(
                                color: isActive
                                    ? widget.activeColor
                                    : widget.inactiveColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Active Bubble
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double left;
              IconData icon;

              if (_previousIndex != null && _animation.value < 1) {
                final fromLeft =
                    iconWidth * _previousIndex! +
                    (iconWidth - widget.bubbleSize) / 2;
                final toLeft =
                    iconWidth * _currentIndex +
                    (iconWidth - widget.bubbleSize) / 2;
                left = fromLeft + (toLeft - fromLeft) * _animation.value;
                icon = widget.icons[_previousIndex!];
              } else {
                left =
                    iconWidth * _currentIndex +
                    (iconWidth - widget.bubbleSize) / 2;
                icon = widget.icons[_currentIndex];
              }

              return Positioned(
                bottom: 15 + safeAreaBottom, // Adjusted to raise the bubble
                left: left,
                child: Container(
                  width: widget.bubbleSize,
                  height: widget.bubbleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.activeGradient,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.black,
                    size: widget.iconSize * 1.2,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BarClipper extends CustomClipper<Path> {
  final double bubbleCenter;
  final double bubbleRadius;
  final double barHeight;

  _BarClipper({
    required this.bubbleCenter,
    required this.bubbleRadius,
    required this.barHeight,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final dipDepth = bubbleRadius * 2.2;

    path.moveTo(0, 0);
    path.lineTo(bubbleCenter - bubbleRadius * 1.5, 0);
    path.quadraticBezierTo(
      bubbleCenter,
      dipDepth,
      bubbleCenter + bubbleRadius * 1.5,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
