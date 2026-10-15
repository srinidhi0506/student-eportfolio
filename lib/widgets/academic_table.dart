import 'package:flutter/material.dart';
import '../models/student.dart';
import 'app_card.dart';

// CUSTOM WIDGET: academic details shown with Flutter's Table widget.
// FlexColumnWidth makes the columns share width by ratio (2 : 3),
// so the table adapts to any screen size (responsive, no fixed pixels).
class AcademicTable extends StatelessWidget {
  final Student student;
  const AcademicTable({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final rows = <MapEntry<String, String>>[
      MapEntry('Name', student.name),
      MapEntry('Roll No', student.rollNo),
      MapEntry('Course', student.course),
      MapEntry('Institution', student.institution),
      MapEntry('Year', student.year),
      MapEntry('CGPA', student.cgpa),
      MapEntry('10th', student.tenth),
      MapEntry('12th / Intermediate', student.twelfth),
    ];

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(color: scheme.outlineVariant),
        ),
        children: [
          for (final row in rows)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    row.key,
                    style: textTheme.labelLarge?.copyWith(color: scheme.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(row.value, style: textTheme.bodyMedium),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
