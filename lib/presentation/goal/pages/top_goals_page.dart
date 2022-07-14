import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/domain/model/todo_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/styles_manager.dart';
import '../blocs/goal_bloc.dart';

class TopGoalsPage extends StatefulWidget {
  const TopGoalsPage({Key? key}) : super(key: key);

  @override
  State<TopGoalsPage> createState() => _TopGoalsPageState();
}

class _TopGoalsPageState extends State<TopGoalsPage> {
  final List<Color> _colorList = [];
  final TextEditingController _goalTextCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoalBloc, GoalState>(
      listener: (context, state) {
        if (state.createStatus.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.createStatus.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              title: "Goal Error",
              message: state.errorMsg ?? "Something went wrong", onClose: () {
            Navigator.pop(context);
          });
        } else if (state.createStatus.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My 10 Goals",
            style: getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: 18.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<GoalBloc>().add(DeleteAllGoals());
              },
              icon: Icon(
                Icons.delete,
                color: ColorManager.redColor,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isFailure) {
              return Center(
                child: Text(state.errorMsg ?? "Something went wrong"),
              );
            } else if (state.status.isSuccess) {
              final List<TodoGoal> _todoGoals = state.goalList ?? [];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: _todoGoals.isEmpty
                    ? Center(
                        child: Text(
                          "No goals set yet",
                          style: getSemiBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: _todoGoals.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                        ),
                        itemBuilder: (context, index) {
                          final TodoGoal _todoGoal = _todoGoals[index];
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Are you sure?",
                                        style: getMediumStyle(
                                            color: ColorManager.blackColor,
                                            fontSize: 18.0),
                                      ),
                                      content: Text(
                                        "Make sure you completed this goal. Once you completed you cannot undo",
                                        style: getRegularStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: getMediumStyle(
                                                color: ColorManager.redColor,
                                                fontSize: 15.0,
                                              ),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              context.read<GoalBloc>().add(
                                                  CompleteGoal(
                                                      goalId: _todoGoal.id));
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Ok",
                                              style: getMediumStyle(
                                                color: ColorManager.darkBlue,
                                                fontSize: 15.0,
                                              ),
                                            )),
                                      ],
                                    );
                                  });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24.0),
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorManager.darkBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "#${index + 1}",
                                        style: getBoldStyle(
                                          color: ColorManager.whiteColor,
                                          fontSize: FontSize.s24,
                                        ),
                                      ),
                                      Text(
                                        _todoGoal.title,
                                        maxLines: 4,
                                        style: getSemiBoldStyle(
                                          color: ColorManager.whiteColor,
                                          fontSize: FontSize.s16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: Visibility(
                                    visible: _todoGoal.status == 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                          color: ColorManager.primaryYellow,
                                          borderRadius:
                                              BorderRadius.circular(0.0)),
                                      child: Text(
                                        "Completed",
                                        style: getRegularStyle(
                                          color: ColorManager.darkBlue,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: ColorManager.primaryYellow,
              onPressed: () {
                if (state.goalList != null && state.goalList!.length == 10) {
                  DialogUtils.buildErrorMessageDialog(context,
                      title: "Goal Error",
                      message: "You cannot add more than 10 goals",
                      onClose: () {
                    Navigator.pop(context);
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Add Goal",
                                      style: getMediumStyle(
                                        color: ColorManager.blackColor,
                                        fontSize: FontSize.s20,
                                      ),
                                    ),
                                  ),
                                  CustomInputField(
                                    controller: _goalTextCtrl,
                                    maxLines: 1,
                                    hintText: "Title",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your goal title";
                                      }
                                      return null;
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: MaterialButton(
                                      color: ColorManager.primaryYellow,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pop(context);
                                          context.read<GoalBloc>().add(
                                              CreateGoal(_goalTextCtrl.text));
                                          _goalTextCtrl.clear();
                                        }
                                      },
                                      child: const Text("Add"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
              child: Icon(
                Icons.add,
                color: ColorManager.blackColor,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
