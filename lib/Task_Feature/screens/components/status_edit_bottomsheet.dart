import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class StatusEditBottomSheet extends StatelessWidget {
  final Status status;
  final bool isUpdate;
  final int statusCount;
  StatusEditBottomSheet({Key key, this.status, this.isUpdate, this.statusCount})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatusEditState(),
      builder: (context, child) {
        final StatusEditState state = Provider.of<StatusEditState>(context);
        final StatusService statusService = Provider.of<StatusService>(context);
        if (status != null) {
          state.updateStatus(status);
        }
        if (statusCount != null) {
          state.updateStatusOrder(statusCount);
        }
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Status Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: state.newStatus.statusName ?? 'Status Name'),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  state.updateStatusName(newText);
                },
              ),
              ColorSelector(
                  saveColor: state.updateStatusColor,
                  matchColor: state.newStatus.statusColor),
              CheckboxListTile(
                  value: state.newStatus.equalToComplete,
                  title: Text('This Status represents Task Complete:',
                      style: Theme.of(context).textTheme.subtitle1),
                  onChanged: (bool value) => state.updateStatusComplete(value)),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check_circle_outline_rounded),
                    label: Text(isUpdate ? 'Update' : 'Add'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        isUpdate
                          ? statusService.updateStatus(
                              statusID: status.statusID,
                              updateData: state.newStatus.toFirestore())
                          : statusService.addStatus(
                              addData: state.newStatus.toFirestore());
                        Navigator.pop(context);
                      }
                    },
                  ))
            ],
          ),
        );
      },
    );
  }
}

// class StatusEditBottomSheet extends StatefulWidget {
//   final Status status;

//   StatusEditBottomSheet({this.status});

//   @override
//   _StatusEditBottomSheetState createState() => _StatusEditBottomSheetState();
// }

// class _StatusEditBottomSheetState extends State<StatusEditBottomSheet> {
//   String newStatusName;
//   Color newStatusColor;
//   int newStatusColorValue;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//                 hintText: widget.status.statusName ?? 'Status Name'),
//             textAlign: TextAlign.center,
//             onChanged: (newText) {
//               newStatusName = newText;
//             },
//           ),
//           StatefulBuilder(
//               builder: (BuildContext context, StateSetter modalSetState) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: ProjectColors().colorList.map((color) {
//                   return IconButton(
//                       icon: (newStatusColor ??
//                                   Color(widget.status.statusColor)) ==
//                               Color(color)
//                           ? Icon(
//                               Icons.check_circle_rounded,
//                               color: Color(color),
//                               size: 36,
//                             )
//                           : Icon(
//                               Icons.circle,
//                               color: Color(color),
//                               size: 36,
//                             ),
//                       onPressed: () {
//                         modalSetState(() {
//                           newStatusColor = Color(color);
//                         });
//                       });
//                 }).toList(),
//               ),
//             );
//           }),
//           Container(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: ElevatedButton.icon(
//                 icon: Icon(Icons.check_circle_outline_rounded),
//                 label: Text('Submit'),
//                 onPressed: () {
//                   StatusService().updateStatus(
//                       statusID: widget.status.statusID,
//                       updateData: {
//                         'statusName': newStatusName ?? widget.status.statusName,
//                         'statusColor': int.parse(
//                                 '0x${newStatusColor.value.toRadixString(16).toUpperCase().toString()}') ??
//                             int.parse(
//                                 '0x${widget.status.statusColor.toString()}')
//                       });
//                   Navigator.pop(context);
//                 },
//               ))
//         ],
//       ),
//     );
//   }
// }
