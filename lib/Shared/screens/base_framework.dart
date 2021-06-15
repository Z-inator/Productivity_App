// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../test_screen.dart';

class BaseFramework extends StatefulWidget {
  @override
  _BaseFrameworkState createState() => _BaseFrameworkState();
}

class _BaseFrameworkState extends State<BaseFramework>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return Provider.of<List<Task>>(context) == null ||
            Provider.of<List<Project>>(context) == null ||
            Provider.of<List<Status>>(context) == null ||
            Provider.of<List<TimeEntry>>(context) == null
        ? Center(child: CircularProgressIndicator()) // TODO: Add logo animation
        : ChangeNotifierProvider<PageState>(
            create: (context) => PageState(),
            builder: (context, child) {
              PageState pageState = Provider.of<PageState>(context);
              return Container(
                  decoration: BoxDecoration(
                      color: DynamicColorTheme.of(context).data.canvasColor),
                  child: SafeArea(
                    child: Scaffold(
                      body: Column(children: [
                        stopwatchState.stopwatch.isRunning
                            ? StopWatchTile()
                            : Container(),
                        Expanded(
                            child: TabBarView(
                                controller: tabController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                              HomeScreen(),
                              TaskProjectScreen(),
                              TimeScreen(),
                              TestScreen()
                            ]))
                      ]),
                      bottomNavigationBar: BottomAppBar(
                          child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: DynamicColorTheme.of(context)
                                        .data
                                        .colorScheme
                                        .onBackground),
                                bottom: BorderSide(
                                    color: DynamicColorTheme.of(context)
                                        .data
                                        .colorScheme
                                        .onBackground))),
                        // padding: EdgeInsets.only(
                        //     top: 2), // Added to counteract the TabBar indicator line
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.dashboard_rounded,
                                      color: pageState.page == 0
                                          ? DynamicColorTheme.of(context)
                                              .data
                                              .iconTheme
                                              .color
                                          : DynamicColorTheme.of(context)
                                              .data
                                              .unselectedWidgetColor),
                                  tooltip: 'Dashboard',
                                  onPressed: () {
                                    tabController!.animateTo(0);
                                    pageState.changePage(0);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.rule_rounded,
                                      color: pageState.page == 1
                                          ? DynamicColorTheme.of(context)
                                              .data
                                              .iconTheme
                                              .color
                                          : DynamicColorTheme.of(context)
                                              .data
                                              .unselectedWidgetColor),
                                  tooltip: 'Tasks',
                                  onPressed: () {
                                    tabController!.animateTo(1);
                                    pageState.changePage(1);
                                  }),
                              AddSpeedDial(),
                              IconButton(
                                  icon: Icon(Icons.timelapse_rounded,
                                      color: pageState.page == 2
                                          ? DynamicColorTheme.of(context)
                                              .data
                                              .iconTheme
                                              .color
                                          : DynamicColorTheme.of(context)
                                              .data
                                              .unselectedWidgetColor),
                                  tooltip: 'Time Log',
                                  onPressed: () {
                                    tabController!.animateTo(2);
                                    pageState.changePage(2);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.bar_chart_rounded,
                                      color: pageState.page == 3
                                          ? DynamicColorTheme.of(context)
                                              .data
                                              .iconTheme
                                              .color
                                          : DynamicColorTheme.of(context)
                                              .data
                                              .unselectedWidgetColor),
                                  tooltip: 'Goals',
                                  onPressed: () {
                                    tabController!.animateTo(3);
                                    pageState.changePage(3);
                                  }),
                            ]),
                      )),
                      drawer: SettingsDrawer(),
                      // floatingActionButton: FloatingActionButton(backgroundColor: Color.fromARGB(100, 149, 0, 0), onPressed: () {},),
                    ),
                  ));
            },
          );
  }
}

// class StopwatchAppBar extends StatelessWidget {
//   const StowatchAppBar({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(

//     );
//   }
// }
