import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  final int itemcount;
  final Duration delayBetweenItems;
  final Widget Function(BuildContext, int, Animation<double>) itemBuilder;

  /// Set to true when this widget is nested inside another scrollable
  /// (e.g. SingleChildScrollView, CustomScrollView Column).
  /// Pairs with [physics] = NeverScrollableScrollPhysics().
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const AnimatedListView({
    super.key,
    required this.itemcount,
    required this.itemBuilder,
    this.delayBetweenItems = const Duration(milliseconds: 200),
    // FIX: default false keeps all existing usages unchanged.
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _animateListItems();
  }

  void _animateListItems() async {
    for (int i = 0; i < widget.itemcount; i++) {
      await Future.delayed(widget.delayBetweenItems);
      if (mounted) {
        _listKey.currentState?.insertItem(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: 0,
      // FIX: shrinkWrap + physics passed through so this widget can live
      // inside SingleChildScrollView without "unbounded height" error.
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemBuilder: (context, index, animation) {
        return widget.itemBuilder(context, index, animation);
      },
    );
  }
}