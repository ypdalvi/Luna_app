import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';
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
        : Scaffold(
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
                      backgroundImage: NetworkImage(Constants.avatarDefault),
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
                          child:
                              ref.watch(getHealthModelProvider(user.hid)).when(
                            data: (data) {
                              return SfDateRangePicker(
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
                  const Spacer(),
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: Constants.articels.map((i) {
                      return Builder(builder: (BuildContext context) {
                        try {
                          return Banner(
                            location: BannerLocation.topStart,
                            message: 'Top Headlines',
                            child: InkWell(
                              onTap: () async {
                                 final Uri url = Uri.parse(i['url']!);
                                  if (!await launchUrl(url)) {
                                        print('Could not launch $url');
                                  }
                              },
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    i['image'] ?? " ",
                                    fit: BoxFit.fill,
                                    height: double.infinity,
                                    width: double.infinity,
                                    // if the image is null
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child:
                                              Icon(Icons.broken_image_outlined),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12.withOpacity(0),
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter)),
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                i['title']!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                    )),
                              ]),
                            ),
                          );
                        } catch (e) {
                          print(e);
                          return Container();
                        }
                      });
                    }).toList(),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
  }
}
