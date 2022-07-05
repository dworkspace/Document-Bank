import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/utils/dialog_utils.dart';
import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/core/widgets/custom_read_container.dart';
import 'package:document_bank/presentation/reminder/blocs/set_reminder/set_reminder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({Key? key}) : super(key: key);

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleCtrl = TextEditingController();
    final TextEditingController _dateCtrl = TextEditingController();
    final TextEditingController _timeCtrl = TextEditingController();
    final TextEditingController _repeatFromDateCtrl = TextEditingController();
    final TextEditingController _recurringCtrl = TextEditingController();

    final List<String> recurringEvents = [
      ReminderRecurringEnum.daily.getStringOfRecurringEnum(),
      ReminderRecurringEnum.weekly.getStringOfRecurringEnum(),
      ReminderRecurringEnum.monthly.getStringOfRecurringEnum(),
      ReminderRecurringEnum.yearly.getStringOfRecurringEnum(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Reminder",
          style:
              getSemiBoldStyle(color: ColorManager.blackColor, fontSize: 16.0),
        ),
      ),
      body: BlocBuilder<SetReminderCubit, SetReminderState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                CustomInputField(
                  controller: _titleCtrl,
                  hintText: "Title",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                CustomReadContainer(
                  textValue: state.selectedDate ?? "Select Date",
                  isHint: state.selectedDate == null,
                  onTap: () async {
                    final dateTime =
                        await DialogUtils.inputDateFromUser(context);
                    if (dateTime != null) {
                      context.read<SetReminderCubit>().onDateChanged(
                            DateFormat.yMMMMd().format(dateTime),
                          );
                    }
                  },
                  suffixIcon: Image.asset(
                    IconAssets.calenderImg,
                    height: 16.0,
                    width: 16.0,
                  ),
                ),
                CustomReadContainer(
                  textValue: state.selectedTime ?? "Select Time",
                  isHint: state.selectedTime == null,
                  onTap: () async {
                    final time = await DialogUtils.inputTimeFromUser(context);
                    if (time != null) {
                      context
                          .read<SetReminderCubit>()
                          .onTimeChanged(time.format(context));
                    }
                  },
                  suffixIcon: Image.asset(
                    IconAssets.timeImg,
                    height: 16.0,
                    width: 16.0,
                  ),
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
                        CustomReadContainer(
                          textValue:
                              state.recurringDate ?? "Select Recurring date",
                          isHint: state.recurringDate == null,
                          onTap: () async {
                            final dateTime =
                                await DialogUtils.inputDateFromUser(context);
                            if (dateTime != null) {
                              context
                                  .read<SetReminderCubit>()
                                  .onRecurringDateChanged(
                                      DateFormat.yMMMMd().format(dateTime));
                            }
                          },
                          suffixIcon: GestureDetector(
                            child: Image.asset(
                              IconAssets.calenderImg,
                              height: 16.0,
                              width: 16.0,
                            ),
                          ),
                        ),
                        CustomReadContainer(
                          textValue: state.recurringText ?? "Recurring",
                          isHint: state.recurringText == null,
                          suffixIcon: DropdownButton(
                            isDense: true,
                            icon: Image.asset(IconAssets.dropDownImg),
                            elevation: 4,
                            iconSize: 10.0,
                            style:
                                getRegularStyle(color: ColorManager.blackColor),
                            underline: const SizedBox(height: 0),
                            items: recurringEvents
                                .map(
                                  (e) => DropdownMenuItem(
                                      value: e, child: Text(e)),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                context
                                    .read<SetReminderCubit>()
                                    .onRecurringTextChanged(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ))
              ],
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
                if (context.read<SetReminderCubit>().isFormValid()) {
                } else {
                  DialogUtils.buildErrorMessageDialog(
                    context,
                    title: "Form Validation",
                    message: "Please Enter All required data",
                    onClose: () => Navigator.pop(context),
                  );
                }
              },
              child: const Text("Save"),
            ),
          );
        },
      ),
    );
  }
}
