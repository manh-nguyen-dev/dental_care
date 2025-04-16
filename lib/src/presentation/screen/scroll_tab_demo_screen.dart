import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ScrollTabDemoScreen extends StatefulWidget {
  const ScrollTabDemoScreen({super.key});

  @override
  State<ScrollTabDemoScreen> createState() => _ScrollTabDemoScreenStates();
}

class _ScrollTabDemoScreenStates extends State<ScrollTabDemoScreen> {
  late ScrollController _scrollController;
  bool sliverActionsHidden = false;
  BuildContext? tabContext;
  double appBarOpacity = 0;
  double toolBarHeight = 180;
  double tempDynamicHeight = 200;
  late List<double> widgetStartPoint;
  final List<GlobalKey<State<StatefulWidget>>> dataKey = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  void scrollListener() {
    setState(() {
      appBarOpacity = (_scrollController.position.pixels / toolBarHeight).clamp(
        0.0,
        1.0,
      );
    });

    List<double> heightOfWidget =
        dataKey
            .mapIndexed(
              (index, item) =>
                  (item.currentContext?.findRenderObject() as RenderBox)
                      .size
                      .height,
            )
            .toList();

    double previousValue = 0.0;
    widgetStartPoint = [
      0.0,
      ...heightOfWidget.map((value) {
        double newValue = previousValue + value;
        previousValue = newValue;
        return newValue + toolBarHeight;
      }),
    ];

    int? index = widgetStartPoint.lastIndexWhere(
      (startPoint) => _scrollController.position.pixels >= startPoint,
    );

    DefaultTabController.of(tabContext!).animateTo(
      index < 0 ? 0 : index,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) {
          tabContext = context;
          return Scaffold(
            extendBody: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.white.withValues(alpha: appBarOpacity),
              surfaceTintColor: Colors.transparent,
              bottomOpacity: appBarOpacity,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: appBarOpacity < 0.5 ? Colors.white : Colors.black,
              ),
              actions: const [
                RoundedIconWidget(
                  icon: Icon(Icons.favorite_outline_rounded),
                  backgroundColor: Colors.transparent,
                ),
              ],
              title: Text(
                "Scroll Tabs",
                style: TextStyle(
                  color: Colors.black.withValues(alpha: appBarOpacity),
                  fontSize: 18,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(28),
                child: TabBar(
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  onTap: (index) {
                    _scrollController.position.animateTo(
                      widgetStartPoint[index],
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  tabs: const [
                    Tab(height: 28, text: "Part 1"),
                    Tab(height: 28, text: "Part 2"),
                    Tab(height: 28, text: "Part 3"),
                    Tab(height: 28, text: "Part 4"),
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  toolbarHeight: toolBarHeight,
                  automaticallyImplyLeading: false,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/8thang3.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // color: AppColors.primaryColor,
                        ),
                        Container(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              const SizedBox(height: kToolbarHeight + 8),
                              Row(
                                children: [
                                  Container(
                                    width: 86,
                                    height: 120,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/img.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tempDynamicHeight = tempDynamicHeight + 40;
                          });
                        },
                        child: Container(
                          key: dataKey[0],
                          height: tempDynamicHeight,
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              "Part 1",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        key: dataKey[1],
                        height: 120,
                        color: const Color(0xFF6F85B7),
                        child: const Center(
                          child: Text("Part 2", style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      Container(
                        key: dataKey[2],
                        height: 600,
                        color: const Color(0xFF94B498),
                        child: const Center(
                          child: Text("Part 3", style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      Container(
                        key: dataKey[3],
                        height: 800,
                        color: const Color(0xFFA2B5BB),
                        child: const Center(
                          child: Text("Part 4", style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RoundedIconWidget extends StatelessWidget {
  final Widget icon;
  final Function? onClickIcon;
  final Color splashColor;
  final Color highlightColor;
  final Color backgroundColor;
  final double contentPadding;

  const RoundedIconWidget({
    super.key,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.splashColor = Colors.white,
    this.highlightColor = Colors.white,
    this.contentPadding = 12.0,
    this.onClickIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () => onClickIcon?.call(),
      elevation: 0,
      constraints: const BoxConstraints(),
      shape: const CircleBorder(),
      highlightElevation: 0,
      fillColor: backgroundColor,
      padding: EdgeInsets.all(contentPadding),
      child: icon,
    );
  }
}
