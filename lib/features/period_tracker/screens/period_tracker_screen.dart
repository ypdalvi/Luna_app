import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/enums.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../../health/controller/health_controller.dart';
import '../../home/drawers/profile_drawer.dart';

class PeriodTrackerScreen extends ConsumerStatefulWidget {
  const PeriodTrackerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends ConsumerState<PeriodTrackerScreen> {
  DateTime dateConverter(int day) {
    final today = DateTime.now();
    int month = today.month;
    int year = today.year;
    int lastday = DateTime(year, month + 1, 0).day;
    if (day > lastday) return DateTime(year, month, lastday);
    return DateTime(year, month, day);
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final user = ref.watch(userModelProvider);

    return (isLoading || user == null)
        ? const Loader()
        : ref.watch(getHealthModelProvider(user.hid)).when(
            data: (data) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Calendar',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: const CircleAvatar(
                          backgroundImage:
                              NetworkImage(Constants.avatarDefault),
                        ),
                        onPressed: () => displayEndDrawer(context),
                      );
                    }),
                  ],
                ),
                endDrawer: const ProfileDrawer(),
                body: DecoratedBox(
                  decoration: BoxDecoration(color: Pallete.backgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 350,
                              child: SfDateRangePicker(
                                monthCellStyle:
                                    const DateRangePickerMonthCellStyle(
                                        todayTextStyle:
                                            TextStyle(color: Colors.deepOrange),
                                        textStyle:
                                            TextStyle(color: Colors.black)),
                                headerStyle: const DateRangePickerHeaderStyle(
                                    textStyle: TextStyle(color: Colors.black)),
                                initialSelectedDate: dateConverter(
                                  data?.attributes[
                                          QuestionName.periodDay.val] ??
                                      1,
                                ),
                                selectionColor: Pallete.redColor,
                                todayHighlightColor: Pallete.redColor,
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                                backgroundColor: Pallete.darkObjColor,
                                view: DateRangePickerView.month,
                                monthViewSettings:
                                    const DateRangePickerMonthViewSettings(
                                  viewHeaderStyle:
                                      DateRangePickerViewHeaderStyle(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
                                  firstDayOfWeek: 1,
                                ),
                              ),
                            ),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(0, 255, 255, 255)),
                              child: SizedBox(
                                height: 350,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return ErrorText(
                error: error.toString(),
              );
            },
            loading: () {
              return const Loader();
            },
          );
  }
}
