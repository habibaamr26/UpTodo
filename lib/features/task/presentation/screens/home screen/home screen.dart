import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../../../../../shared/app image.dart';
import '../../../../../core/common/reusable.dart';
import '../../../../auth/presentation/componant/home screen componant.dart';
import '../../cubit/task_cubit.dart';
import '../../cubit/task_state.dart';
import '../add task screen/add task screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit= AddTaskBloc.get(context);
    return BlocConsumer<AddTaskBloc,AddTaskState>(builder: (
        BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            DateFormat.yMMMd().format(DateTime.now()),
            style: Theme.of(context).textTheme.displayLarge,
          ),

          actions: [
            IconButton(onPressed: (){
              cubit.changeThemeData();
            }, icon: const Icon(Icons.brightness_4_outlined)),

          ],
        ),


        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 25,
              ),

              // use date_picker_timeline: package

              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color(0xFF242969),
                selectedTextColor: Colors.white,
                height: 110,
                dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                onDateChange: (date) {
                  cubit.getSelectedDate(date);
                },
              ),
              const SizedBox(
                height: 50,
              ),

              cubit.list.isEmpty?
              Center(child: Image.asset(AppImage.app)):
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context,index)=>  item(context,cubit.list[index]),
                    itemCount: cubit.list.length),
              )
            ],
          ),
        ),


        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            navigate(context:context,screen:AddTaskScreen());
           // AddTaskBloc.get(context).deleteTask(24);
          },
          child: const Icon(Icons.add),
        ),
      );
    },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}








