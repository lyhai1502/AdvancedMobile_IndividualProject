import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_app/model/booking.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/network/models/tutor_api.dart';
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

  @override
  void initState() {
    initializeDateFormatting();

    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Booking Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));

    Booking booking = Booking();

    booking.userId = widget.user.userId;
    // booking.teacher = widget.tutorApi.name ?? '';
    booking.bookingStart = newBooking.bookingStart;
    booking.bookingEnd =
        newBooking.bookingEnd.subtract(const Duration(minutes: 5));
    booking.request = requestController.text;

    widget.bookingRepository.add(booking);

    requestController.clear();

    // ignore: use_build_context_synchronously
    CoolAlert.show(
      confirmBtnText: 'OK',
      context: context,
      type: CoolAlertType.success,
      text: 'Booking successfuly!',
    );

    // print(widget.bookingRepository.list.first.bookingStart);
    // print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: BookingCalendar(
                bookingService: mockBookingService,
                convertStreamResultToDateTimeRanges: convertStreamResultMock,
                getBookingStream: getBookingStreamMock,
                uploadBooking: uploadBookingMock,
                pauseSlots: generatePauseSlots(),
                hideBreakTime: false,
                loadingWidget: const Text('Fetching data...'),
                uploadingWidget: const CircularProgressIndicator(),
                locale: 'hu_HU',
                startingDayOfWeek: StartingDayOfWeek.tuesday,
                wholeDayIsBookedWidget:
                    const Text('Sorry, for this day everything is booked'),
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
      ),
    );
  }
}
