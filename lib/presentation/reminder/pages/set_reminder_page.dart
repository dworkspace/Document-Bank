import 'package:document_bank/core/blocs/folder_cubit.dart';
import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/router/arguments/set_reminder_arg.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/data/request/reminder_requests.dart';
import 'package:document_bank/presentation/reminder/blocs/set_reminder/set_reminder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({Key? key, required this.args}) : super(key: key);
  final SetReminderArg args;

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  final TextEditingController _repeatFromDateCtrl = TextEditingController();
  final TextEditingController _recurringCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SetReminderArg get args => widget.args;

  @override
  void initState() {
    super.initState();
  }

  final List<String> recurringEvents = [
    ReminderRecurringEnum.daily.getStringOfRecurringEnum(),
    ReminderRecurringEnum.weekly.getStringOfRecurringEnum(),
    ReminderRecurringEnum.monthly.getStringOfRecurringEnum(),
    ReminderRecurringEnum.yearly.getStringOfRecurringEnum(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetReminderCubit, SetReminderState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          DialogUtils.buildLoadingDialog(context);
        } else if (state.status.isFailure) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              title: "Set Reminder Fail",
              message: state.addReminderFailMessage,
              onClose: () => Navigator.pop(context));
        }
        if (state.status.isSuccess) {
          Navigator.pop(context);
          DialogUtils.buildSuccessMessageDialog(
            context,
            title: "Set Reminder",
            message: "Successfully added reminder",
            onDone: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Set Reminder",
            style: getSemiBoldStyle(
                color: ColorManager.blackColor, fontSize: 16.0),
          ),
        ),
        body: BlocBuilder<SetReminderCubit, SetReminderState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomInputField(
                      controller: _titleCtrl,
                      hintText: "Title",
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title is required";
                        }
                        return null;
                      },
                    ),
                    CustomInputField(
                      controller: _dateCtrl,
                      hintText: "Select Date",
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Date is required";
                        }
                        return null;
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      suffixIcon: Image.asset(
                        IconAssets.calenderImg,
                        height: 16.0,
                        width: 16.0,
                      ),
                      onFieldTap: () async {
                        final dateTime =
                            await DialogUtils.inputDateFromUser(context);
                        if (dateTime != null) {
                          setState(() {
                            _dateCtrl.text =
                                DateFormat("yyyy-MM-dd").format(dateTime);
                          });
                        }
                      },
                    ),
                    CustomInputField(
                      controller: _timeCtrl,
                      hintText: "Select time",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Time is required";
                        }
                        return null;
                      },
                      readOnly: true,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      suffixIcon: Image.asset(
                        IconAssets.timeImg,
                        height: 16.0,
                        width: 16.0,
                      ),
                      onFieldTap: () async {
                        final time =
                            await DialogUtils.inputTimeFromUser(context);
                        if (time != null) {
                          setState(() {
                            _timeCtrl.text = time.format(context);
                          });
                        }
                      },
                    ),
                    CheckboxListTile(
                      checkColor: ColorManager.whiteColor,
                      activeColor: ColorManager.primaryYellow,
                      value: state.isRecurringChecked,
                      onChanged: (value) {
                        context.read<SetReminderCubit>().toggleRecurring();
                      },
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Do you want a recurring reminder ?",
                        style: getMediumStyle(
                          color: ColorManager.blackColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Visibility(
                        visible: state.isRecurringChecked,
                        child: Column(
                          children: [
                            CustomInputField(
                              controller: _repeatFromDateCtrl,
                              hintText: "Select recurring date",
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Recurring Date is required";
                                }
                                return null;
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              suffixIcon: Image.asset(
                                IconAssets.calenderImg,
                                height: 16.0,
                                width: 16.0,
                              ),
                              onFieldTap: () async {
                                final dateTime =
                                    await DialogUtils.inputDateFromUser(
                                        context);
                                if (dateTime != null) {
                                  setState(() {
                                    _repeatFromDateCtrl.text =
                                        DateFormat("yyyy-MM-dd")
                                            .format(dateTime);
                                  });
                                }
                              },
                            ),
                            CustomInputField(
                              controller: _recurringCtrl,
                              hintText: "Recurring",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Recurring is required";
                                }
                                return null;
                              },
                              readOnly: true,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              suffixIcon: DropdownButton(
                                isDense: false,
                                icon: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(IconAssets.dropDownImg)),
                                elevation: 4,
                                iconSize: 10.0,
                                style: getRegularStyle(
                                    color: ColorManager.blackColor),
                                underline: const SizedBox(height: 0),
                                items: recurringEvents
                                    .map(
                                      (e) => DropdownMenuItem(
                                          value: e, child: Text(e)),
                                    )
                                    .toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _recurringCtrl.text = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<SetReminderCubit, SetReminderState>(
          builder: (context, state) {
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final SetReminderRequest _request = SetReminderRequest(
                      title: _titleCtrl.text,
                      date: _dateCtrl.text,
                      time: _timeCtrl.text,
                      recurring: state.isRecurringChecked ? 1 : 0,
                      reminderOn: args.reminderOn,
                      endDate: _repeatFromDateCtrl.text,
                      recurringPeriod: _recurringCtrl.text.toLowerCase(),
                      id: args.noteId,
                      ids: args.ids,
                    );
                    context.read<SetReminderCubit>().addReminder(_request);
                  }
                },
                child: const Text("Save"),
              ),
            );
          },
        ),
      ),
    );
  }
}
