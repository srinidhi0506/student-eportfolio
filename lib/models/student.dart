// MODEL: a plain Dart class that holds the student's details.
// Change the values at the bottom of this file to show YOUR information.
class Student {
  final String name;
  final String rollNo;
  final String course;
  final String institution;
  final String year;
  final String cgpa;
  final String tenth;
  final String twelfth;

  const Student({
    required this.name,
    required this.rollNo,
    required this.course,
    required this.institution,
    required this.year,
    required this.cgpa,
    required this.tenth,
    required this.twelfth,
  });
}

// Sample data used by the whole app (edit these values).
const Student currentStudent = Student(
  name: 'Srinidhi Bhonagiri',
  rollNo: '24WH1A05A4',
  course: 'B.Tech – Computer Science and Engineering',
  institution: 'BVRIT Hyderabad College of Engineering for Women',
  year: 'III Year – I Semester',
  cgpa: '9.19',
  tenth: '9.8',
  twelfth: '98.5% (MPC – Narayana Jr College)',
);
