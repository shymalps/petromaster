import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  final int itemcount;
  final Duration delayBetweenItems;
  final Widget Function(BuildContext, int, Animation<double>) itemBuilder;
  const AnimatedListView({
    super.key,
    required this.itemcount,
    required this.itemBuilder,
    this.delayBetweenItems = const Duration(milliseconds: 200),
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
      _listKey.currentState?.insertItem(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        return widget.itemBuilder(context,  index,animation);
      },
    );
  }
}
