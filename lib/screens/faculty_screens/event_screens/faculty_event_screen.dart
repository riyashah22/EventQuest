import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/event_services.dart';

import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class FacultyEventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const FacultyEventScreen({Key? key}) : super(key: key);

  @override
  State<FacultyEventScreen> createState() => _FacultyEventScreenState();
}

class _FacultyEventScreenState extends State<FacultyEventScreen> {
  int? _value;
  List<Event> events = [
    // Event(
    //   eventId: "abc132",
    //   eventCategory: "UG",
    //   eventName: "BASIC FIRST AI",
    //   eventDescription:
    //       "Hi there! 👋\nExciting news! We're hosting a Certificate Programme in Basic First Aid on Thursday, 25 January 2024. It's a fantastic opportunity to learn life-saving skills, presented in collaboration with St. John's National Academy of Health Sciences and Christ University, Bangalore.\n🚀 Key Details:\nFee: Rs. 250/- only\nTime: 1:30 PM - 4:30 PM\nVenue: St. John's Medical College\nPlaces are limited to 35 per batch, so make sure to secure your spot ASAP!\n🔗 Scan the QR codes in the attached poster to register for Batch 2 or Batch 3.\nDon't miss out on this chance to become a part of the Rapid Action First Aid Team (RAFT) and make a difference! 🚑\nSee you there!",
    //   eventLink: "https://basicfirstaid.org",
    //   eventPublishedOn: DateTime.now(),
    //   eventImage: "assets/images/BASICFIRSTAI.jpeg",
    //   eventAmount: 0,
    //   eventContactPerson: "Helen K Joy",
    //   eventContactPersonNo: 9099897859,
    //   eventNoOfParticipants: 2,
    //   eventRegistrationDeadline: DateTime(2024, 2, 15),
    // ),
    // Event(
    //   eventId: "def456",
    //   eventCategory: "PG",
    //   eventName: "NRITTA",
    //   eventDescription:
    //       "Greetings from Student Welfare Office✨✨\n🕺💃 Ready to groove and show off your moves? We're hosting auditions for NRITTA, and we want YOU to be a part of the rhythm! 🌟 \n📅 Date: 12th, 13th and 14th  February 2024\n🕰️ Time: 4pm onwards \n📍 Location: Dance Studio, IVY Basement, Audi block \nDon't miss your chance to shine and be a part of Nritta! Spread the word, bring your friends, and let's make this audition a dance party to remember!",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 5)),
    //   eventImage: "assets/images/NRITTA.jpeg",
    //   eventLink: "https://codingcompetition.com",
    //   eventAmount: 0,
    //   eventContactPerson: "John Doe",
    //   eventContactPersonNo: 9876543210,
    //   eventNoOfParticipants: 6,
    //   eventRegistrationDeadline: DateTime(2024, 2, 18),
    // ),
    // Event(
    //   eventId: "ghi789",
    //   eventCategory: "PG",
    //   eventName: "INHSA",
    //   eventDescription:
    //       "🚀 INHSA 2024: Digital Health Innovation Conclave \nCalling all healthtech startups!\nUnlock your potential at the Innovate Health South Asia 2024 conclave and compete for The Best Startup Award!\n🗓️ Date: 3rd February 2024\n Venue: VRR Hotels & Convention Hall, E-City Phase 1, Bangalore\nBenefits include:\nStage time for presentation\nCash reward\nOpportunity to exhibit\nNetworking with investors and industry leaders\nMentorship and incubation support\nDon't miss this chance to shine amongst the best in the digital healthcare industry.\n👉 Register now by scanning the QR code or contact us at +91 9606904387 or admire.dighealth@iihmrbangalore.edu.in\nBest of luck, and we hope to see you there!",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/INHSA.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 2, 20),
    // ),
    // Event(
    //   eventId: "ghi799",
    //   eventCategory: "UG",
    //   eventName: "PITCHFIRK",
    //   eventDescription:
    //       "🚀 Pitchfork Event Alert at CHRIST University!\n🎓 The Department of Economics and Agasthya - The Entrepreneurship Cell presents an incredible opportunity for innovative minds!\n📍 *Venue:* Skyview Central Block\n *Date:* 15th February 2024\n⏰ *Submission Deadline:* 8th February 2024\n💡 Get ready to pitch your groundbreaking ideas and stand a chance to win amazing cash prizes:\n🥇 1st Place: ₹3500 INR\n🥈 2nd Place: ₹2500 INR\n🥉 3rd Place: ₹1500 INR\nFor more information and to submit your ideas, scan the QR code on the poster or contact:\n- Chaitanya: 7489813136\n- Swastika: 9438733368\n\nDon't miss out on this chance to showcase your entrepreneurial talent and win big! 🏆",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/PITCHFIRK.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 2, 28),
    // ),
    // Event(
    //   eventId: "ghi719",
    //   eventCategory: "UG",
    //   eventName: "PRAYAS",
    //   eventDescription:
    //       "🌟 *PRAYAS 2024 at CHRIST University presents KALEIDO-QUEST!*\n\n✨ Join the Department of Commerce for a thrilling adventure and a variety of exciting events:\n\n🚀 *Among Us IRL* - 29th January\n🔴 *Red Light, Green Light* - 30th January\n⚪ *Monochrome Hues* - 31st January\n🎲 *Gganbu* - 1st February\n🔓 *Escape Room* - 2nd February\nGet ready to level up with these immersive experiences!\n\n📣 *Register Now* for an unforgettable journey filled with challenges and fun!\n\n🚀 Don't miss out on the action - seize the opportunity to be part of something extraordinary!\n\nFor additional details and registration, make sure to get in touch or follow the updates. Let's make PRAYAS 2024 a remarkable event together! 🌌",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/PRAYAS.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 2, 29),
    // ),
    // Event(
    //   eventId: "ghi729",
    //   eventCategory: "PG",
    //   eventName: "PRISMATRIX",
    //   eventDescription:
    //       "🌟 Exciting News! 🌟\n\nKristu Jayanti College Autonomous, Bengaluru, is proud to present PRISMATRIX 2024 – our National Level Intercollegiate Fest, organised by the Department of Physical Sciences!\n\nJoin us for a day of intellectual challenge and fun across various events:\n🔍 ALGOQUEST (Computer Science)\n🔧 ZAPZEST (Electronics)\n📊 STATINTRICA (Statistics)\n🌌 CELESTILUME (Physics)\n📐\nARCHI_MATICS (Mathematics)\n💹 ECOFLATION (Economics)\n\n🗓️ Mark your calendars:\nDate: 23rd January 2024\nTime: 8:30 AM - 4:30 PM\n\n📍 Venue:\nKristu Jayanti College Autonomous\nBengaluru - 77\n\nFor more details and to register, contact us at +91 7204315460 or prismatrix@kristujayanti.com. You can also scan the QR code in the attached poster.\n\nDon’t miss out on this opportunity to showcase your talents and win exciting prizes! 🏆\n\nSpread the word and let's make PRISMATRIX 2024 a grand success! 🚀",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/PRISMATRIX.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 3, 3),
    // ),
    // Event(
    //   eventId: "ghe729",
    //   eventCategory: "UG",
    //   eventName: "RAINING GEN",
    //   eventDescription:
    //       "Hey there! 👋\n\nAre you ready for an extraordinary theatrical experience? Potter & Clay Productions, the creators of \"HEY\", proudly present \"ROH - Remembrance of Him\" 🎭\n\nJoin us for a captivating journey on the 30th & 31st January 2024, starting at 4:30 PM, at the KE Auditorium, 4th Block, CHRIST (Deemed to be University), Central Campus, Bangalore.\n\nDon't miss this remarkable production that's sure to leave you spellbound! Mark your calendars and grab your seats. See you there! 🌟\n\n#ROH #Theatre #ChristUniversity #BangaloreEvents #PotterAndClayProductions",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/RAININGGEN.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 3, 3),
    // ),
    // Event(
    //   eventId: "ghe029",
    //   eventCategory: "UG",
    //   eventName: "RAINING GEN",
    //   eventDescription:
    //       "Greetings, tech enthusiasts! 🚀\n\nKristu Jayanti College's Department of Computer Science [PG] proudly presents \"Shells 2024 - Digital Horizon - Unleashing Tech Frontiers,\" the grand national intercollegiate IT fest. 🎉\n\nMark your calendars for an exhilarating digital adventure on the 8th (Online) and 9th February 2024, and compete for an attractive cash prize! 🏆\n\n🔹 Events include:\n\nDigital Tapestry\n\nTechnotrek\n\nBitquest\n\nBitquest 2024\n\nDigital Tapestry 2\nAnd many more...\n\n�� Venue:\nKristu Jayanti College's Department of ComputerComputer\n📍 Venue: Kristu Jayanti College [Autonomous], Bengaluru\nBengaluru - 56\n\nFor more information and to register, contact\nDon't miss out on the opportunity to showcase your skills and connect with fellow tech aficionados. Register now by scanning the QR code on the poster!\n\nFor more information, please reach out to the faculty and student coordinators listed on the poster.\n\nLet's ride the wave of innovation together at Shells 2024! 💻🌐\n\n#Shells2024 #ITFest #TechEvent #KristuJayantiCollege #IEEE #ACMW #BengaluruTech",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/SHELLS.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 3, 3),
    // ),
    // Event(
    //   eventId: "ghe024",
    //   eventCategory: "PG",
    //   eventName: "THE CLASSICS SOCIETY",
    //   eventDescription:
    //       "Hello everyone!\n\nWe're thrilled to announce a guided field visit to the National Gallery of Modern Art, organized by The Classics Society of the School of Arts & Humanities. This enlightening excursion is an excellent opportunity for all art enthusiasts to delve into modern art marvels.\n\n🗓️ Date: 20th January 2024\n⏰ Time: 2:00 PM - 4:30 PM\n💷 Fee: ₹225/- (includes transport)\n\nSpots are limited, so please RSVP soon to secure your place. For more details or to confirm your attendance, reach out to the student coordinators Yatin or Poorvi at the numbers provided on the poster.\n\nDon't miss out on this cultural adventure! 🎨✨",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/THECLASSICSSOCIETY.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 3, 3),
    // ),
    // Event(
    //   eventId: "ize024",
    //   eventCategory: "UG",
    //   eventName: "ZENITH",
    //   eventDescription:
    //       "Good day, folks!\n\nWe're excited to announce the 'Zenith HR Fest 2024' on 19th January, centred around the cutting-edge theme of Industry 5.0. This fest is a fantastic platform for future HR leaders to showcase their talents and learn through competition.\n\n🗓️\nDate: 19th January 2024\n🎯 Events: Quiz, Treasure Hunt, Role-Play, Debate, and much more!\n💰 Win: Cash prizes up to ₹25,000!\n📚 Special Feature: Training Module Development\n\nDon't miss out on this exciting event! \nThere's a mix of group and individual events, ensuring there's something for everyone. Plus, you can participate in an online meme-making contest from the comfort of your home!\n\n📲 To register, simply scan the QR code on the poster or reach out to the student coordinators, Paridhi Saxena or Hari Prakash, for any queries.\n\nLet's make this a memorable event with your enthusiastic participation! 🌟🏆",
    //   eventPublishedOn: DateTime.now().subtract(const Duration(days: 10)),
    //   eventImage: "assets/images/ZENITH.jpeg",
    //   eventLink: "https://artexhibition.com",
    //   eventAmount: 50,
    //   eventContactPerson: "Alice Smith",
    //   eventContactPersonNo: 1234567890,
    //   eventNoOfParticipants: 30,
    //   eventRegistrationDeadline: DateTime(2024, 3, 3),
    // ),
  ];
  EventServices eventServices = EventServices();
  Future<List<Event>> getAllPost() async {
    events = await eventServices.getAllEvents(context);
    // setState(() {});
    return events;
  }

  @override
  void initState() {
    super.initState();
    getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = _value == null
        ? events
        : events
            .where((event) => event.eventCategory == getCategory(_value!))
            .toList();

    return Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TopBar(),
              UserBar(),
              const SizedBox(
                height: 8,
              ),
              filterOption(context),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      return buildEventCard(filteredEvents[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddEventScreen.routeName,
            );
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  Navigator.pushNamed(context, EventDetailsScreen.routeName,
                      arguments: event);
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, EditEventScreen.routeName,
                      arguments: event);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality here
                },
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              event.eventImage,
              height: 224,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  color: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.eventRegistrationDeadline.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          event.eventRegistrationDeadline.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        event.eventDescription,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filterOption(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Text(
            'Select your preference:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 20.0,
            children: List<Widget>.generate(
              2,
              (int index) {
                String optionText = '';

                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;

                  default:
                    optionText = '';
                    break;
                }

                return ChoiceChip(
                  label: Text(
                    optionText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  String getCategory(int? index) {
    if (index == null) {
      return '';
    }

    switch (index) {
      case 0:
        return 'UG';
      case 1:
        return 'PG';

      default:
        return '';
    }
  }
}

extension MonthToString on DateTime {
  String get monthShort {
    return [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][month];
  }
}
