import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/common/reusable.dart';
import '../../../../auth/presentation/componant/add task componant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = AddTaskBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: BlocConsumer<AddTaskBloc, AddTaskState>(
            builder: (context, state) => Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///title
                      AddTaskItem(
                        textTitle: "Title",
                        hintTitle: "Enter title here",
                        controller: cubit.titleController,
                        validator: (String? title) {
                          if (title!.isEmpty) {
                            return "enter title please";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      ///note
                      AddTaskItem(
                        textTitle: "Note",
                        hintTitle: "Enter note here",
                        controller: cubit.noteController,
                        validator: (String? note) {
                          if (note!.isEmpty) {
                            return "enter Note please";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      ///date
                      AddTaskItem(
                        textTitle: "Date",
                        hintTitle: DateFormat.yMd().format(cubit.currentDate),
                        suffixIcon: Icons.calendar_month_outlined,
                        onPressed: () {
                          // use date picker
                          cubit.getDate(context);
                        },
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      /// start and end date
                      Row(
                        children: [
                          Expanded(
                            child: AddTaskItem(
                              textTitle: 'Start Time',
                              readOnly: true,
                              hintTitle: cubit.currentStartTime,
                              suffixIcon: Icons.access_alarm,
                              onPressed: () {
                                cubit.getStartTime(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 27.h,
                          ),
                          Expanded(
                            child: AddTaskItem(
                              textTitle: 'End Time',
                              readOnly: true,
                              hintTitle: cubit.currentEndTime,
                              suffixIcon: Icons.access_alarm,
                              onPressed: () {
                                cubit.getEndTime(context);
                              },
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: 24.h,
                      ),

                      /// choose color
                      Text(
                        "Color",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                cubit.changeColor(index);
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: cubit.colors[index],
                                child: index == cubit.currentIndex
                                    ? const Icon(Icons.check)
                                    : null,
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 8,
                            ),
                            itemCount: cubit.colors.length),
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      /// create bottom
                      customButton(
                          text: 'CREATE TASK',
                          context: context,
                          height: 48,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.insertIntoDataBase();
                             //l Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
            listener: (context, state) {
              if (state is InsertDataSuccess) {
                showToast(
                    message: 'Added Sucessfully', state: ToastStates.success);
                Navigator.pop(context);
              }
            },
          ),




    );
  }
}
