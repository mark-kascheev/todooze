import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/view/blur_notifier.dart';

class ExpandableFloatingButton extends StatefulWidget {
  final List<Widget> children;

  const ExpandableFloatingButton({Key? key, required this.children})
      : super(key: key);

  @override
  _ExpandableFloatingButtonState createState() =>
      _ExpandableFloatingButtonState();
}

class _ExpandableFloatingButtonState extends State<ExpandableFloatingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _open ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlurNotifier>(builder: (context, blur, child) {
      final needBlur = blur.value;
      if (needBlur != null) {
        _open = needBlur;
        if (_open) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      }
      return SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            _TapCloseButton(onTap: context.read<BlurNotifier>().unBlurScreen),
            ..._buildExpandingActionButtons(),
            _TapOpenButton(
                isOpen: _open, onTap: context.read<BlurNotifier>().blurScreen),
          ],
        ),
      );
    });
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    const step = 60;
    for (var i = 0, distance = step; i < count; i++, distance += step) {
      children.add(
        _ExpandingActionButton(
          distance: distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

class _TapCloseButton extends StatelessWidget {
  final Function()? onTap;

  const _TapCloseButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 56.0,
        height: 56.0,
        child: Center(
            child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: InkWell(
                    onTap: onTap,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close,
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer))))));
  }
}

class _TapOpenButton extends StatelessWidget {
  final bool isOpen;
  final Function()? onTap;

  const _TapOpenButton({Key? key, required this.isOpen, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isOpen,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          isOpen ? 0.7 : 1.0,
          isOpen ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: isOpen ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            onPressed: onTap,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.progress,
    required this.child,
    required this.distance,
  }) : super(key: key);

  final int distance;

  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        if (child != null) {
          final offset = Offset.fromDirection(
              90 * (math.pi / 180.0), progress.value * distance);
          return Positioned(
              right: 4.0 + offset.dx, bottom: 4.0 + offset.dy, child: child);
        } else {
          return const SizedBox();
        }
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key,
      this.onPressed,
      required this.icon,
      this.actionDescription = ''})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final String actionDescription;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Material(color: Colors.transparent, child: Text(actionDescription)),
      const SizedBox(width: 10),
      Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 4.0,
        child: IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: () {
              context.read<BlurNotifier>().unBlurScreen();
              onPressed?.call();
            }),
      )
    ]);
  }
}
