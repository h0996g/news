import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/const/colors.dart';

class NewsFilterWidget extends StatefulWidget {
  final bool isEverything;
  final DateTime? initialFrom;
  final DateTime? initialTo;
  final String? initialSource;

  final Function({
    required DateTime? from,
    required DateTime? to,
    required String? source,
  })
  onApply;

  const NewsFilterWidget({
    super.key,
    required this.onApply,
    this.initialFrom,
    this.initialTo,
    this.initialSource,
    required this.isEverything,
  });

  @override
  State<NewsFilterWidget> createState() => _NewsFilterWidgetState();
}

class _NewsFilterWidgetState extends State<NewsFilterWidget> {
  DateTime? fromDate;
  DateTime? toDate;
  late TextEditingController sourceController;

  @override
  void initState() {
    super.initState();
    fromDate = widget.initialFrom;
    toDate = widget.initialTo;
    sourceController = TextEditingController(text: widget.initialSource ?? '');
  }

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    DateTime initialDate =
        isFrom
            ? fromDate ?? DateTime.now()
            : toDate ?? fromDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: isFrom ? 'Select Start Date' : 'Select End Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: primaryColor),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
          if (toDate != null && picked.isAfter(toDate!)) {
            toDate = null; // reset end date if before start
          }
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _onApply() {
    widget.onApply(
      from: fromDate,
      to: toDate,
      source:
          sourceController.text.trim().isEmpty
              ? null
              : sourceController.text.trim(),
    );
  }

  void _onReset() {
    setState(() {
      fromDate = null;
      toDate = null;
      sourceController.clear();
    });
  }

  Widget _buildDateTile(String label, DateTime? date, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                date != null
                    ? DateFormat('MM/dd/yyyy').format(date)
                    : 'Select date',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Filter News',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildDateTile(
                  'From',
                  fromDate,
                  () => _selectDate(context, true),
                ),
                const SizedBox(width: 12),
                _buildDateTile('To', toDate, () => _selectDate(context, false)),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: sourceController,
              decoration: InputDecoration(
                labelText: 'News Source (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.public),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _onReset,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
