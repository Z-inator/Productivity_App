import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/widgets/home_page/time_tile_list_builder.dart';
import 'package:productivity_app/widgets/home_page/home_page_dashboard.dart';
import 'package:productivity_app/screens/base_framework.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseFramework(
      dash: HomeDashboard(),
      list: TimeTileList(),
    );
    // Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: HomeDashboard()
    //     ),
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: Scrollbar(
    //         child: ListView(
    //           children: <Widget>[
    //             TimeTileList(),
    //             TimeTileList(),
    //             TimeTileList(),
    //             TimeTileList(),
    //           ],
    //         ),
    //       )
    //     )
    //   ]
    // );
  }
}
