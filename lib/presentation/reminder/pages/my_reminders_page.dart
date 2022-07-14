import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/domain/model/reminder.dart';
import 'package:document_bank/presentation/reminder/blocs/reminder/reminder_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyRemindersPage extends StatelessWidget {
  const MyRemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Reminders",
          style: getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: 16.0,
          ),
        ),
      ),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state.status.isSuccess) {
            final List<Reminder> _reminderList = state.reminderList;
            return ListView.builder(
              itemCount: _reminderList.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final Reminder _reminder = _reminderList[index];
                return GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Slidable(
                          direction: Axis.horizontal,
                          closeOnScroll: false,
                          key: ValueKey(UniqueKey()),
                          dragStartBehavior: DragStartBehavior.start,
                          startActionPane: ActionPane(
                            extentRatio: 0.4,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                 context.read<ReminderCubit>().deleteReminder(_reminder.id);
                                },
                                backgroundColor: ColorManager.redColor,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  //todo: Edit Action
                                },
                                backgroundColor: ColorManager.primaryYellow,
                                foregroundColor: Colors.white,
                                icon: Icons.edit_outlined,
                              ),
                            ],
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _reminder.title,
                                  style: getMediumStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "${_reminder.date}, ${_reminder.time}",
                                  style: getRegularStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  _reminder.recurringPeriod,
                                  style: getRegularStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 12.0,
                                  ).copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: ColorManager.grayColor.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
