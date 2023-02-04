import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class VerticalTabs extends StatefulWidget {
  final Key? key;
  final double? tabsWidth;
  final double? itemExtent;
  final double? indicatorWidth;
  final List<Tab>? tabs;
  final List<Widget>? contents;
  final TextDirection? direction;

  final bool? disabledChangePageFromContentView;
  final Axis? contentScrollAxis;
  final Color? selectedTabBackgroundColor;
  final Color? unselectedTabBackgroundColor;
  final Color? dividerColor;
  final Color? backgroundColor;
  final Duration? changePageDuration;
  final Curve? changePageCurve;
  final Color? tabsShadowColor;
  final double? tabsElevation;
  final List<Widget>? leading;
  final List<Widget>? trailing;
  final void Function(int)? callback;

  VerticalTabs({
    this.key,
    this.tabs,
    this.contents,
    this.tabsWidth,
    this.itemExtent,
    this.indicatorWidth = 3,
    this.direction = TextDirection.ltr,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.vertical,
    this.selectedTabBackgroundColor = const Color(0xffBBDEFB),
    this.unselectedTabBackgroundColor = const Color(0xfff8f8f8),
    this.dividerColor = const Color(0xffe5e5e5),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.tabsShadowColor = Colors.black54,
    this.tabsElevation = 2.0,
    this.leading = const [],
    this.trailing = const [],
    this.callback,
  })  : assert(
            tabs != null && contents != null && tabs.length == contents.length),
        super(key: key);

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool? _changePageByTapView;
  bool _isLoading = false;
  bool _isLoading1 = false;
  AnimationController? animationController;
  Animation<double>? animation;
  Animation<RelativeRect>? rectAnimation;
  PageController pageController = PageController();
  List<AnimationController> animationControllers = [];
  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();
  String oldpassword = "";
  String newpassword = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    for (int i = 0; i < widget.tabs!.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(0);
    if (widget.disabledChangePageFromContentView == true) {
      pageScrollPhysics = const NeverScrollableScrollPhysics();
    }
    super.initState();
  }

  Future showChangePasswordDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState1) {
          return Dialog(
            backgroundColor: Colors.transparent,

            // insetPadding: EdgeInsets.all(10),
            child: Container(
              height: height * 0.44,
              width: width * 0.28,
              decoration: BoxDecoration(
                  color: Colors.blue[500],
                  border: Border.all(color: Colors.white, width: 4)),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: width * 0.2,
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (newValue) {
                            oldpassword = newValue!;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Employee code can't be empty";
                            } else if (value.length < 3) {
                              return "Can't be less than 3 words";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              labelText: "Old Password",
                              labelStyle: const TextStyle(color: Colors.white)),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(
                        // width: width * 0.2,
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length < 3) {
                              return "Can't be less than 3 words";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            newpassword = newValue!;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                              labelText: 'New Password',
                              labelStyle: const TextStyle(color: Colors.white)),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        height: height * 0.049,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: () async {},
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: widget.direction!,
      child: Row(
        children: <Widget>[
          Material(
            child: Container(
              // padding: EdgeInsets.only(top: 40),
              width: widget.tabsWidth,
              decoration: const BoxDecoration(
                  border:
                      Border(right: BorderSide(color: Colors.black, width: 2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.089,
                  ),
                  for (Widget lead in widget.leading!) lead,
                  for (int index = 0; index < widget.tabs!.length; index++)
                    Builder(
                      builder: (context) {
                        Tab tab = widget.tabs![index];
                        Alignment alignment = Alignment.centerLeft;
                        if (widget.direction == TextDirection.rtl) {
                          alignment = Alignment.centerRight;
                        }
                        Widget childx;
                        if (tab.child != null) {
                          childx = tab.child!;
                        } else {
                          childx = Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              (tab.icon != null)
                                  ? Row(
                                      children: <Widget>[
                                        tab.icon!,
                                        const SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    )
                                  : Container(),
                              (tab.text != null)
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.02),
                                      child: Text(tab.text!,
                                          style: TextStyle(
                                              fontSize: height * 0.020,
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900)),
                                    )
                                  : Container(),
                            ],
                          );
                        }
                        Color itemBGColor =
                            widget.unselectedTabBackgroundColor!;
                        if (_selectedIndex == index) {
                          itemBGColor = widget.selectedTabBackgroundColor!;
                        }
                        return GestureDetector(
                          onTap: () {
                            _changePageByTapView = true;
                            setState(() {
                              _selectTab(index);
                            });
                            pageController.animateToPage(
                              index,
                              duration: widget.changePageDuration!,
                              curve: widget.changePageCurve!,
                            );
                            widget.callback!(index);
                          },
                          child: Container(
                            height: widget.itemExtent,
                            margin: EdgeInsets.only(bottom: height * 0.06),
                            decoration: BoxDecoration(
                              color: itemBGColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ScaleTransition(
                                  child: SizedBox(
                                    width: widget.indicatorWidth,
                                    height: widget.itemExtent,
                                  ),
                                  scale: Tween(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: animationControllers[index],
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.4,
                                  alignment: alignment,
                                  padding: const EdgeInsets.all(5),
                                  child: childx,
                                ),
                                // _selectedIndex == index
                                //     ? SizedBox(
                                //         width: width * 0.05,
                                //         height: height,
                                //         child: Image.asset(
                                //           "assets/jklogo.png",
                                //           fit: BoxFit.fill,
                                //         ))
                                //     : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
            elevation: widget.tabsElevation!,
            shadowColor: widget.tabsShadowColor,
            shape: BeveledRectangleBorder(),
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: widget.contentScrollAxis!,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                if (_changePageByTapView == false ||
                    _changePageByTapView == null) {
                  _selectTab(index);
                }
                if (_selectedIndex == index) {
                  _changePageByTapView = null;
                }
                setState(() {});
              },
              controller: pageController,
              itemCount: widget.contents!.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.contents![index];
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();
  }
}
