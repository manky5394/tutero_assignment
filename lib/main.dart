import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tutero_assignment/custome_scroll_behavior.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: ReOrderableList(),
      );
}

/// enum for camera sides
enum CameraRackSides { top, left, right, bottom }

class ReOrderableList extends StatefulWidget {
  const ReOrderableList({Key? key}) : super(key: key);

  @override
  State<ReOrderableList> createState() => _ReOrderableListState();
}

class _ReOrderableListState extends State<ReOrderableList> {
  List<Widget> listWidget = [];
  late List<String> listChild1;
  late List<String> listChild2;
  late List<String> listChild3;
  late List<String> listChild4;
  late List<String> listChild5;

  ///
  static const String keyTop = 'top';
  static const String keyLeft = 'left';
  static const String keyRight = 'right';
  static const String keyBottom = 'bottom';

  ///
  bool _isDragStart = false;

  bool _isShowExtraSpaceTop = false;
  bool _isShowExtraSpaceLeft = false;
  bool _isShowExtraSpaceRight = false;
  bool _isShowExtraSpaceBottom = false;

  static const double itemWidth = 150;
  static const double itemHeight = 100;
  final ScrollController _scrollController = ScrollController();
  double _listHeight = 0;

  /// Lists
  List<CustomData> items1 = [];
  List<CustomData> items2 = [];
  List<CustomData> items3 = [];
  List<CustomData> items4 = [];
  List<CustomData> items5 = [];

  @override
  void initState() {
    items1 = [
      CustomData(id: 1, position: "center", row: 1),
      CustomData(id: 2, position: "center", row: 1),
      CustomData(id: 3, position: "center", row: 1),
      CustomData(id: 4, position: "center", row: 1),
      CustomData(id: 5, position: "center", row: 1),
    ];

    items2 = [
      CustomData(id: 6, position: "center", row: 1),
      CustomData(id: 7, position: "center", row: 1),
      CustomData(id: 8, position: "center", row: 1),
      CustomData(id: 9, position: "center", row: 1),
      CustomData(id: 10, position: "center", row: 1),
    ];
    items3 = [
      CustomData(id: 11, position: "center", row: 1),
      CustomData(id: 12, position: "center", row: 1),
      CustomData(id: 13, position: "center", row: 1),
      CustomData(id: 14, position: "center", row: 1),
      CustomData(id: 15, position: "center", row: 1),
    ];
    items4 = [
      CustomData(id: 16, position: "center", row: 1),
      CustomData(id: 17, position: "center", row: 1),
      CustomData(id: 18, position: "center", row: 1),
      CustomData(id: 19, position: "center", row: 1),
      CustomData(id: 20, position: "center", row: 1),
    ];
    items5 = [
      CustomData(id: 21, position: "center", row: 1),
      CustomData(id: 22, position: "center", row: 1),
      CustomData(id: 23, position: "center", row: 1),
      CustomData(id: 24, position: "center", row: 1),
      CustomData(id: 25, position: "center", row: 1),
    ];
    listWidget = createHorizontalList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: SafeArea(
        child: ReorderableListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            key: ValueKey(listWidget),
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return listWidget[index];
            },
            itemCount: listWidget.length,
            onReorder: reorderData),
      ),
    );
  }

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = listWidget.removeAt(oldIndex);
      listWidget.insert(newIndex, items);
    });
  }

/*  void reorderChildData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = listChild.removeAt(oldIndex);
      listChild.insert(newIndex, items);
    });
  }*/

  List<Widget> createHorizontalList() {
    return <Widget>[
      SizedBox(
        width: 300,
        key: const ValueKey(0),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.green.shade200,
          child: createItemsForCards(items1),
        ),
      ),
      SizedBox(
        width: 300,
        key: const ValueKey(1),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.pink.shade200,
          child: createItemsForCards(items2),
        ),
      ),
      SizedBox(
        width: 300,
        key: const ValueKey(2),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.cyan.shade200,
          child: createItemsForCards(items3),
        ),
      ),
      SizedBox(
        width: 300,
        key: const ValueKey(3),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.brown.shade200,
          child: createItemsForCards(items4),
        ),
      ),
      SizedBox(
        width: 300,
        key: const ValueKey(4),
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.orangeAccent.shade200,
          child: createItemsForCards(items5),
        ),
      ),
    ];
  }

  // get list from index
  List<CustomData> getList(int boardIndex) {
    List<CustomData> customData = [];
    switch (boardIndex) {
      case 0:
        customData = items1;
        break;
      case 1:
        customData = items2;
        break;
      case 2:
        customData = items3;
        break;
      case 3:
        customData = items4;
        break;
    }
    return customData;
  }

  /// get list item
  Widget getListItem(
      int index, TaskIndex location, List<CustomData> _list, bool _isVertical) {
    if (index == _list.length) {
      return widgetForExtraSpace(location.boardIndex, false);
    }

    if (index == 0) {
      return _isVertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widgetForExtraSpace(location.boardIndex, true),
                getInnerSubItem(index, location, _list, _isVertical)
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widgetForExtraSpace(location.boardIndex, true),
                getInnerSubItem(index, location, _list, _isVertical)
              ],
            );
    }

    return getInnerSubItem(index, location, _list, _isVertical);
  }

// scroll list
  _moveUp(ScrollController _scrollController, double _height) {
    _scrollController.animateTo(_scrollController.offset - _height,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown(ScrollController _scrollController, double _height) {
    _scrollController.animateTo(_scrollController.offset + _height,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveLeft(ScrollController _scrollController, double _width) {
    _scrollController.animateTo(_scrollController.offset - _width,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveRight(ScrollController _scrollController, double _width) {
    _scrollController.animateTo(_scrollController.offset + _width,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  Widget _buildSizedNamedButton(
      String url, String name, void Function() onPressed) {
    return SizedBox(
        width: itemWidth,
        height: itemHeight,
        // child: new RaisedButton(
        /*color: Colors.deepOrangeAccent,*/
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(width: 0, color: Colors.grey),
              borderRadius: BorderRadius.zero,
            ),
            child: Center(
                child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ))));
  }

  /// get inner sub item
  Widget getInnerSubItem(
      int index, TaskIndex location, List<CustomData> _list, bool _isVertical) {
    return Padding(
        padding: (_isVertical
            ? EdgeInsets.fromLTRB(0, index == 0 ? 0 : 2, 0, 2)
            : EdgeInsets.fromLTRB(index == 0 ? 0 : 2, 0, 2, 0)),
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return LongPressDraggable(
                child: _buildSizedNamedButton('', '${_list[index].id}', () {}),
                feedback: Transform.rotate(
                  angle: 0, // 5 degrees to radians  0.0872665,
                  child:
                      _buildSizedNamedButton('', '${_list[index].id}', () {}),
                ),
                childWhenDragging: _buildSizedNamedButton('', '', () {}),
                data: DraggableCard(location, _list[index], itemPos: index),
                onDragStarted: () {
                  setState(() {
                    _isDragStart = true;
                    //_isShowExtraSpace = true;
                  });
                },
                onDragCompleted: () {
                  setState(() {
                    _isDragStart = false;
                    //_isShowExtraSpace = false;
                    _isShowExtraSpaceTop = false;
                    _isShowExtraSpaceLeft = false;
                    _isShowExtraSpaceRight = false;
                    _isShowExtraSpaceBottom = false;
                  });
                });
          },
          onWillAccept: (DraggableCard? draggedTask) {
            print(
                "Top WillAccept view data======= ${location.listIndex} Dragged on index ====${draggedTask!.fromLocation.listIndex}");
            if (location.boardIndex != draggedTask.fromLocation.boardIndex) {
              switch (location.boardIndex) {
                case 0:
                  _isShowExtraSpaceTop = true;
                  break;
                case 1:
                  _isShowExtraSpaceLeft = true;
                  break;
                case 2:
                  _isShowExtraSpaceRight = true;
                  break;
                case 3:
                  _isShowExtraSpaceBottom = true;
                  break;
              }
            }
            return true;
          },
          onAccept: (DraggableCard draggedTask) {
            print("inside accept top=== ${draggedTask.itemPos}");
            _doAcceptCard(draggedTask, location);
          },
        ));
  }

  // accept dragged item
  _doAcceptCard(DraggableCard draggedTask, TaskIndex location) {
    setState(() {
      _isDragStart = false;
      //_isShowExtraSpace = false;

      _isShowExtraSpaceTop = false;
      _isShowExtraSpaceLeft = false;
      _isShowExtraSpaceRight = false;
      _isShowExtraSpaceBottom = false;
    });
    // from other location
    if (location.boardIndex != draggedTask.fromLocation.boardIndex) {
      setState(() {
        var toList = getList(location.boardIndex);
        var fromList = getList(draggedTask.fromLocation.boardIndex);

        print(" from board : ${draggedTask.fromLocation.boardIndex}");
        // set positions
        draggedTask.item.position = getListPosition(location.boardIndex);

        toList.insert(location.listIndex, draggedTask.item);
        fromList.removeAt(draggedTask.fromLocation.listIndex);
      });
    } else {
      // from same list
      setState(() {
        var tmpList = getList(location.boardIndex);
        if (tmpList.remove(draggedTask.item)) {
          tmpList.insert(location.listIndex, draggedTask.item);
        }
      });
    }
  }

  /// get specif visible list space
  bool getVisibilitySpace(int boardIndex) {
    bool selectedBool = false;
    switch (boardIndex) {
      case 0:
        selectedBool = _isShowExtraSpaceTop;
        break;
      case 1:
        selectedBool = _isShowExtraSpaceLeft;
        break;
      case 2:
        selectedBool = _isShowExtraSpaceRight;
        break;
      case 3:
        selectedBool = _isShowExtraSpaceBottom;
        break;
    }
    return selectedBool;
  }

  /// add extra space at end of list
  Widget widgetForExtraSpace(int boardIndex, bool isTop) {
    return Visibility(
        visible: getVisibilitySpace(boardIndex),
        child: DragTarget(builder: (context, candidateData, rejectedData) {
          return Container(
            child: const SizedBox(
              height: itemHeight,
              width: itemWidth,
            ),
            color: Colors.transparent,
          );
        }, onWillAccept: (DraggableCard? draggedTask) {
          print("Will accept  extra trailing space");
          return (draggedTask!.fromLocation.boardIndex != boardIndex);
        }, onAccept: (DraggableCard draggedTask) {
          setState(() {
            print(" from board : $boardIndex");
            // set position
            draggedTask.item.position = getListPosition(boardIndex);

            if (isTop) {
              getList(boardIndex).insert(0, draggedTask.item);
            } else {
              getList(boardIndex).add(draggedTask.item);
            }
            getList(draggedTask.fromLocation.boardIndex)
                .removeAt(draggedTask.fromLocation.listIndex);
          });
        }));
  }

// get list position [index]
  String getListPosition(int index) {
    var key = '';
    switch (index) {
      case 0:
        key = keyTop;
        break;
      case 1:
        key = keyLeft;
        break;
      case 2:
        key = keyRight;
        break;
      case 3:
        key = keyBottom;
        break;
    }
    return key;
  }

  Widget createItemsForCards(List<CustomData> itemsLeft) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: itemWidth,
                margin: const EdgeInsets.fromLTRB(0, 1, 5, 3),
                child: Stack(children: [
                  LayoutBuilder(builder: (context, constraints) {
                    _listHeight = constraints.maxHeight;
                    print("left list height === $_listHeight");
                    return Stack(children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: itemsLeft.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            TaskIndex location =
                                TaskIndex(CameraRackSides.left.index, index);
                            return getListItem(
                                index, location, itemsLeft, true);
                          }),
                      (itemsLeft.length * itemHeight) > _listHeight
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: DragTarget(
                                builder:
                                    (context, candidateData, rejectedData) =>
                                        Container(
                                  width: itemWidth,
                                  height: _listHeight -
                                      ((itemsLeft.length * itemHeight) + 10),
                                  color: Colors.transparent,
                                ),
                                onWillAccept: (DraggableCard? draggedTask) {
                                  return (draggedTask!
                                          .fromLocation.boardIndex !=
                                      1);
                                },
                                onAccept: (DraggableCard draggedTask) {
                                  setState(() {
                                    draggedTask.item.position =
                                        getListPosition(1);
                                    getList(1).add(draggedTask.item);
                                    getList(draggedTask.fromLocation.boardIndex)
                                        .removeAt(
                                            draggedTask.fromLocation.listIndex);
                                  });
                                },
                              ))
                    ]);
                  }),
                  !_isDragStart
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.topCenter,
                          child: DragTarget(
                            builder: (context, candidateData, rejectedData) =>
                                Container(
                              height: 10,
                              width: itemWidth,
                              color: Colors.transparent,
                            ),
                            onWillAccept: (DraggableCard? draggedTask) {
                              print("will accept == Up");
                              setState(() {
                                _moveUp(_scrollController, _listHeight);
                              });

                              return false;
                            },
                          ),
                        ),
                  !_isDragStart
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: DragTarget(
                            builder: (context, candidateData, rejectedData) =>
                                Container(
                              height: 10,
                              width: itemWidth,
                              color: Colors.transparent,
                            ),
                            onWillAccept: (DraggableCard? draggedTask) {
                              print("will accept == Down");
                              setState(() {
                                _moveDown(
                                    _scrollController, _listHeight);
                              });

                              return false;
                            },
                          ),
                        ),
                  !_isDragStart
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: DragTarget(
                            builder: (context, candidateData, rejectedData) =>
                                Container(
                              height: 10,
                              width: itemWidth,
                              color: Colors.transparent,
                            ),
                            onWillAccept: (DraggableCard? draggedTask) {
                              print("will accept == Down");
                              setState(() {
                                _moveLeft(
                                    _scrollController, _listHeight);
                              });

                              return false;
                            },
                          ),
                        ),
                  !_isDragStart
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: DragTarget(
                            builder: (context, candidateData, rejectedData) =>
                                Container(
                              height: 10,
                              width: itemWidth,
                              color: Colors.transparent,
                            ),
                            onWillAccept: (DraggableCard? draggedTask) {
                              print("will accept == Down");
                              setState(() {
                                _moveRight(
                                    _scrollController, _listHeight);
                              });

                              return false;
                            },
                          ),
                        )
                ]),
              ),
            ),
          ]),
    );
  }
}

/// custom data
class CustomData {
  int id;
  String position;
  int row;

  CustomData({
    required this.id,
    required this.position,
    required this.row,
  });
}

/// for maintain card data
class TaskIndex {
  final int boardIndex;
  final int listIndex;

  TaskIndex(this.boardIndex, this.listIndex);

/*  @override
  bool operator ==(other) {
    return boardIndex == other.boardIndex && listIndex == other.listIndex;
  }*/
}

///DraggableCard class
class DraggableCard {
  TaskIndex fromLocation;
  CustomData item;
  int itemPos;

  DraggableCard(this.fromLocation, this.item, {required this.itemPos});
}
