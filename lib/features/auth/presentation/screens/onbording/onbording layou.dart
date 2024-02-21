
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common/reusable.dart';
import 'package:todo_app/features/task/presentation/cubit/task_state.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../task/presentation/cubit/task_cubit.dart';
import '../../../../task/presentation/screens/home screen/home screen.dart';
import '../../../data/model/onbording model.dart';

class OnBordingLayout extends StatelessWidget {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskBloc, AddTaskState>(
      builder: (context, state) =>
          SafeArea(
            child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: controller,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (index != 2)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: textButton(
                                      controller: controller,
                                      context: context,
                                      text: "SKIP",
                                      onPressed: () {
                                        AddTaskBloc.get(context)
                                            .enterHomeScreen();
                                        navigate(
                                            context: context,
                                            screen: const HomeScreen());
                                      },

                                    ),
                                  ),










                                const SizedBox(
                                  height: 50,
                                ),
                                ///image
                                Expanded(
                                  child: Image(
                                      image: AssetImage(
                                          BordingScreens
                                              .screens[index]["image"])),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                /// dots that appear use  smooth_page_indicator: package
                                SmoothPageIndicator(
                                  controller: controller,
                                  count: 3,
                                  effect: const ExpandingDotsEffect(
                                    dotWidth: 15,
                                    dotHeight: 10,
                                    spacing: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                ///title
                                Text(BordingScreens.screens[index]["title"],
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge),
                                const SizedBox(
                                  height: 50,
                                ),

                                ///subtitle
                                Text(BordingScreens.screens[index]["subtitle"],
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium),
                                const SizedBox(
                                  height: 60,
                                ),


                                /// back and next button
                                Row(
                                  children: [
                                    if (index != 0)
                                      textButton(
                                          controller: controller,
                                          context: context,
                                          text: "BACK",
                                        onPressed: () {
                                          controller.previousPage(
                                              duration:
                                              const Duration(milliseconds: 400),
                                              curve: Curves.ease);
                                         },

                                      ),
                                    const Spacer(),
                                    index != 2
                                        ? customButton(
                                      context: context,
                                      text: 'NEXT',
                                      onPressed: () {
                                        controller.nextPage(
                                            duration:
                                            const Duration(milliseconds: 400),
                                            curve: Curves.ease
                                        );
                                      },
                                      width: 90,
                                      height: 48,
                                      color: 0xFF8875FF,
                                    )
                                        : customButton(
                                      context: context,
                                      text: 'GET STARTED',
                                      onPressed: () {
                                        AddTaskBloc.get(context)
                                            .enterHomeScreen();
                                        navigate(
                                          context: context,
                                          screen: const HomeScreen(),
                                        );
                                      },
                                      width: 151,
                                      height: 48,
                                      color: 0xFF8875FF,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 3,
                      ),
                    ),
                  ],
                )),
          ),
      listener: (context, state) {},
    );
  }
}



/// skip and Back bottom
Widget textButton({
  required controller,
 required context,
  required String text,
  required void Function()? onPressed
})=>TextButton(
onPressed:onPressed ,
child: Text(text,
style: Theme
    .of(context)
    .textTheme
    .displayMedium ),
);





