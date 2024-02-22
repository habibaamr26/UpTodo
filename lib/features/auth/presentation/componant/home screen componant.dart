
import 'package:flutter/material.dart';

import '../../../task/data/model/task_model.dart';
import '../../../task/presentation/cubit/task_cubit.dart';

Widget bottomSheetItem(
  context,
  String text,
  int color,
  void Function()? onPressed,
) =>
    Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Color(color), borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );

Widget item(context, TaskModel list) => GestureDetector(
  // bottom sheet appear when you click on item
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 240,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF424242).withOpacity(0.5),
              child: Column(
                children: [
                  bottomSheetItem(context, "TASK COMPLETED", 0xFF8875FF, () {
                    AddTaskBloc.get(context).updateTask(list.id);
                    Navigator.pop(context);
                  }),
                  bottomSheetItem(context, "DELETE TASK", 0xFFE57373, () {
                    AddTaskBloc.get(context).deleteTask(list.id);
                    Navigator.pop(context);
                  }),
                  bottomSheetItem(context, "CANCEL", 0xFF8875FF, () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            );
          },
        );
      },

      child: Container(
        width: double.infinity,
        height: 128,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AddTaskBloc.get(context).colors[list.color],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title text
                  Expanded(
                    child: Text(
                      "${list.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 24),
                    ),
                  ),
                  // start and end time
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${list.startTime} - ${list.endTime}",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  // note text
                 Expanded(
                    child: Text(
                      "${list.note}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),


            //const Spacer(),
            Container(
              height: 75,
              width: 1,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),

            // todo text
            RotatedBox(
                quarterTurns: 3,
                child: Text(
                  list.isCompleted == 0 ? "TODO" : "COMPLETED",
                  style: Theme.of(context).textTheme.displayMedium,
                ))
          ],
        ),
      ),
    );
