

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/database/cach/cash%20helper.dart';
import 'package:todo_app/features/task/data/model/task_model.dart';
import 'package:todo_app/features/task/presentation/cubit/task_state.dart';

import '../../../../core/database/sqflit/sqflit_helper.dart';

class AddTaskBloc extends Cubit<AddTaskState>
{
  AddTaskBloc():super(TaskInitialState());

  static AddTaskBloc get(context)=>BlocProvider.of(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  DateTime currentDate = DateTime.now();
  String currentEndTime =
  DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: 1)));
  String currentStartTime = DateFormat('hh:mm a').format(DateTime.now());

  int currentIndex=0;


  Future<void> getDate(
      context
      )
  async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2600),
    );
    if(pickedDate==null) {
      currentDate=DateTime.now();
      emit(GetDateError());
    }
      else {
      currentDate=pickedDate!;
      emit(GetDateFromUser());
    }
  }


  getStartTime(
      context
      )
  async {
    TimeOfDay? timeStartPicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if(timeStartPicker==null) {
      currentStartTime=DateFormat('hh:mm a').format(DateTime.now());
      emit(GetStartTimeFromUser());
    }
    else {
      currentStartTime=timeStartPicker!.format(context) ;
      emit(GetStartTimeDateError());
    }

  }



  getEndTime(
      context
      )
  async {
    TimeOfDay? timeEndPicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if(timeEndPicker==null) {
      currentEndTime=DateFormat('hh:mm a').format(DateTime.now());
      emit(GetEndTimeFromUser());
    }
    else {
      currentEndTime=timeEndPicker!.format(context) ;
      emit(GetEndTimeError());
    }

  }




   List colors=const[
    Color(0xFFFF4666),
    Color(0xFF66CC41),
    Color(0xFF41CCA7),
    Color(0xFF4181CC),
    Color(0xFFCC8441),
    Color(0xFF9741CC),

  ] ;

  DateTime selctedDate = DateTime.now();
  void getSelectedDate(date) {
    selctedDate = date;
    emit(SelectDateSuccess());
    getTasks();
  }



  void changeColor(index)
  {
    currentIndex=index;
    emit((ChangeColor()));
  }

  void openDataBase()
  {
    object.createDatabase();
  }

  LocalDataBase object =LocalDataBase();


  late TaskModel model;

  void insertIntoDataBase()
  {
    model=TaskModel(title: titleController.text,
        color: currentIndex??0,
        date: DateFormat.yMd().format(currentDate),
        endTime: currentEndTime,
       note: noteController.text,
        startTime: currentStartTime,
        isCompleted: 0);
    object.insertData(model: model).then((value) {
      print("data is inserted");
      titleController.clear();
      noteController.clear();
      currentDate = DateTime.now();
      currentEndTime =
          DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: 1)));
      currentStartTime = DateFormat('hh:mm a').format(DateTime.now());
      currentIndex=0;
      getTasks();
      emit(InsertDataSuccess());
    }).onError((error, stackTrace) {
      print(error);
      emit(InsertDataError());
    });


  }



  List<TaskModel> list=[];
  void getTasks() async {
    list=[];
    await object.getFromDB().then((value) {
    value.forEach((element) {
      element.forEach((key, value) {
        if(key=="date"&&value==DateFormat.yMd().format(selctedDate))
          {
            list.add(TaskModel.formjason(element));
          }
      });
    });
      emit(GetDateSucessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }



  void deleteTask(id) async {
    await object.deleteData(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }



  void updateTask(id) async
  {
    await object.updateData(id: id).then((value) {
      emit(UpdateDataSuccess());
      getTasks();
    }).catchError((e){
      print(e);
      emit(UpdateDataError());
    });
  }


  bool homeScreen=false;

  void enterHomeScreen({bool? value}){

    if(value!=null)
    {
      homeScreen=value;
      emit(EnterHomeSCreen());
    }
    else {
      homeScreen = !homeScreen;
      CachHelper.saveData(key: "Bording", value: homeScreen).then((value) {
        emit(EnterHomeSCreen());
      });

    }
  }




  bool isDark=false;

  void changeThemeData ( {bool? dark}){

    if(dark!=null)
      {
        isDark=dark;
        emit(themechangel());
      }
    else {
      isDark = !isDark;
      CachHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(themechangel());
      });

    }
  }


}