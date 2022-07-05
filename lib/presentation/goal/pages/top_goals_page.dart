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
              message: state.errorMsg ?? "Something went wrong");
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
                child: GridView.builder(
                  itemCount: _todoGoals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                  ),
                  itemBuilder: (context, index) {
                    final TodoGoal _todoGoal = _todoGoals[index];
                    return Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: ColorManager.darkBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primaryYellow,
          onPressed: () {
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                    context
                                        .read<GoalBloc>()
                                        .add(CreateGoal(_goalTextCtrl.text));
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
          },
          child: Icon(
            Icons.add,
            color: ColorManager.blackColor,
          ),
        ),
      ),
    );
  }
}
