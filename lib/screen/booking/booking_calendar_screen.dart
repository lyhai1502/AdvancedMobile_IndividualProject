import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_app/network/model/user_login.dart';
import 'package:my_app/network/model/booking_info_api.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/model/tutor_api.dart';
import 'package:my_app/network/network_request/booking/booking_class_request.dart';
import 'package:my_app/network/network_request/booking/get_booking_calendar_request.dart';
import 'package:my_app/repository/booking_repository.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BookingCalendarScreen extends StatefulWidget {
  BookingCalendarScreen({super.key, required this.tutorApi});

  // final Teacher teacher;
  final TutorApi tutorApi;
  User user = User();
  BookingRepository bookingRepository = BookingRepository();

  @override
  State<BookingCalendarScreen> createState() => BookingCalendarScreenState();
}

class BookingCalendarScreenState extends State<BookingCalendarScreen> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  TextEditingController requestController = TextEditingController();
  Tokens tokens = Tokens();

  List<int> bookedPeriodTimestampList = [];
  List<int> bookingAvailablePeriodTimestampList = [];

  List<DateTimeRange> bookedOptionList = [];
  List<DateTimeRange> bookingAvailableOptionList = [];

  List<BookingInfoApi> bookingInfoApiList = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
    initializeDateFormatting();

    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Booking Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 23, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 0, 0));
  }

  Future<void> getData() async {
    _isLoading = true;
    tokens = context.read<Tokens>();

    Future<dynamic> future = GetBookingCalendarRequest.getBookingCalendar(
        tokens.access?.token, '4d54d3d7-d2a9-42e5-97a2-5ed38af5789a');
    await future.then((value) {
      setState(() {
        bookingInfoApiList = value;
      });
    });

    getBookedList(bookingInfoApiList);

    getBookingAvailableList(bookingInfoApiList);

    _isLoading = false;
  }

  void getBookedList(List<BookingInfoApi> bookingInfoApiList) {
    for (var i = 0; i < bookingInfoApiList.length; i++) {
      if (bookingInfoApiList[i].isBooked == true) {
        final startPeriodTimestamp = bookingInfoApiList[i].startTimestamp;
        bookedPeriodTimestampList.add(startPeriodTimestamp!);
      }
    }

    for (var element in bookedPeriodTimestampList) {
      bookedOptionList.add(DateTimeRange(
          start: DateTime.fromMillisecondsSinceEpoch(element),
          end: DateTime.fromMillisecondsSinceEpoch(element + 30 * 60 * 1000)));
    }
  }

  void getBookingAvailableList(List<BookingInfoApi> bookingInfoApiList) {
    for (var i = 0; i < bookingInfoApiList.length; i++) {
      if (bookingInfoApiList[i].isBooked == false) {
        final startPeriodTimestamp = bookingInfoApiList[i].startTimestamp;
        bookingAvailablePeriodTimestampList.add(startPeriodTimestamp!);
      }
    }

    for (var element in bookingAvailablePeriodTimestampList) {
      bookingAvailableOptionList.add(DateTimeRange(
          start: DateTime.fromMillisecondsSinceEpoch(element),
          end: DateTime.fromMillisecondsSinceEpoch(element + 30 * 60 * 1000)));
    }
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 0, 0),
          end: DateTime(now.year, now.month, now.day, 23, 0))
    ]);
  }

  BookingInfoApi? findScheduleId(DateTimeRange dateTimeRange) {
    for (var i = 0; i < bookingInfoApiList.length; i++) {
      if (bookingInfoApiList[i].startTimestamp ==
          dateTimeRange.start.millisecondsSinceEpoch) {
        return bookingInfoApiList[i];
      }
    }
    return null;
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));

    // bookedOptionList.add(DateTimeRange(
    //     start: newBooking.bookingStart, end: newBooking.bookingEnd));

    // Booking booking = Booking();

    // booking.userId = widget.user.userId;
    // // booking.teacher = widget.tutorApi.name ?? '';
    // booking.bookingStart = newBooking.bookingStart;
    // booking.bookingEnd =
    //     newBooking.bookingEnd.subtract(const Duration(minutes: 5));
    // booking.request = requestController.text;

    // widget.bookingRepository.add(booking);

    String? scheduleID = findScheduleId(DateTimeRange(
            start: newBooking.bookingStart, end: newBooking.bookingEnd))
        ?.scheduleId;

    Future<dynamic> future = BookingClassRequest.bookingClass(
        tokens.access?.token, scheduleID, requestController.text);

    await future.then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              BookingCalendarScreen(tutorApi: widget.tutorApi),
        ),
      );

      CoolAlert.show(
        confirmBtnText: 'OK',
        context: context,
        type: CoolAlertType.success,
        text: 'Booking successfuly!',
      );
    });

    requestController.clear();
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    return bookedOptionList;
  }

  List<DateTimeRange> generatePauseSlots(List<DateTimeRange> bookingDates,
      List<DateTimeRange> bookingAvailableDates) {
    List<DateTimeRange> pauseSlots = [];

    DateTime now = DateTime.now();

    // Add pause slots for the entire day except for booking dates
    List<DateTimeRange> allDates = bookingDates + bookingAvailableDates;

    allDates.sort((a, b) => a.start.compareTo(b.start));

    pauseSlots.add(DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 0, 0),
        end: allDates[0].start));

    for (var i = 1; i < allDates.length; i++) {
      pauseSlots.add(
          DateTimeRange(start: allDates[i - 1].end, end: allDates[i].start));
    }

    return pauseSlots;
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    widget.user = user;
    BookingRepository bookingRepository = context.watch<BookingRepository>();
    widget.bookingRepository = bookingRepository;
    // String? name = widget.teacher.name;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tutorApi.name ?? ''),
        ),
        body: !_isLoading
            ? Column(
                children: [
                  Expanded(
                    child: Center(
                      child: BookingCalendar(
                        bookingService: mockBookingService,
                        convertStreamResultToDateTimeRanges:
                            convertStreamResultMock,
                        getBookingStream: getBookingStreamMock,
                        uploadBooking: uploadBookingMock,
                        pauseSlots: generatePauseSlots(
                            bookedOptionList, bookingAvailableOptionList),
                        hideBreakTime: false,
                        loadingWidget: const Text('Fetching data...'),
                        uploadingWidget: const CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                        locale: 'hu_HU',
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        wholeDayIsBookedWidget: const Text(
                            'Sorry, for this day everything is booked'),
                        bookingButtonColor: Colors.blue,
                        availableSlotColor: Colors.blue,

                        //disabledDates: [DateTime(2023, 1, 20)],
                        //disabledDays: [6, 7],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: requestController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter your note here',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ));
  }
}
