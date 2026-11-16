import 'package:flutter/material.dart';

import '../movie.dart';
import '../theme.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.filters});
  final MovieFilters filters;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _form = GlobalKey<FormState>();
  late String _genre = widget.filters.genre;
  late double _score = widget.filters.score;
  late final _year = TextEditingController(
    text: widget.filters.year?.toString() ?? '',
  );

  @override
  void dispose() {
    _year.dispose();
    super.dispose();
  }

  void _apply() {
    if (!_form.currentState!.validate()) return;
    Navigator.pop(
      context,
      MovieFilters(
        genre: _genre,
        year: int.tryParse(_year.text.trim()),
        score: _score,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    title: const Text('Filters'),
    content: Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _genre,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Genre'),
            items: ['All genres', ...sampleMovies.map((m) => m.genre).toSet()]
                .map(
                  (genre) => DropdownMenuItem(value: genre, child: Text(genre)),
                )
                .toList(),
            onChanged: (genre) =>
                setState(() => _genre = genre ?? 'All genres'),
          ),
          const SizedBox(height: gap),
          TextFormField(
            controller: _year,
            decoration: const InputDecoration(
              labelText: 'Released in or after',
              hintText: 'Any year',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) return null;
              final year = int.tryParse(text);
              return year == null || year < 1888 || year > 2100
                  ? 'Enter a year from 1888 to 2100'
                  : null;
            },
          ),
          const SizedBox(height: gap),
          Text('Minimum TMDB score: ${_score.toStringAsFixed(1)} / 10'),
          Slider(
            value: _score,
            max: 10,
            divisions: 20,
            label: _score.toStringAsFixed(1),
            onChanged: (score) => setState(() => _score = score),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _apply, child: const Text('Apply')),
    ],
  );
}
