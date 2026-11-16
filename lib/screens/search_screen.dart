import 'package:flutter/material.dart';

import '../movie.dart';
import '../theme.dart';
import '../widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onOpen});
  final ValueChanged<Movie> onOpen;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _input = TextEditingController();
  String? _query;
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _search() {
    final value = _input.text.trim();
    setState(() {
      _error = value.isEmpty ? 'Enter a movie title.' : null;
      _query = value.isEmpty ? null : value;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query;
    final results = query == null
        ? <Movie>[]
        : sampleMovies
              .where(
                (movie) =>
                    movie.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    return ScreenBody(
      children: [
        Text(
          'Search by title',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _input,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: 'Movie title',
            prefixIcon: const Icon(Icons.search),
            errorText: _error,
          ),
          onSubmitted: (_) => _search(),
        ),
        const SizedBox(height: gap),
        FilledButton(onPressed: _search, child: const Text('Search')),
        const SizedBox(height: 20),
        if (query == null)
          const Text('Enter a movie title.', style: TextStyle(color: muted))
        else if (results.isEmpty)
          const EmptyCard(
            icon: Icons.search_off,
            title: 'No movies found',
            message: 'Try a different movie title.',
          )
        else ...[
          Text(
            'Results for “$query”',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: gap),
          for (final movie in results) ...[
            Card(
              child: MovieRow(movie: movie, onOpen: () => widget.onOpen(movie)),
            ),
            const SizedBox(height: gap),
          ],
        ],
      ],
    );
  }
}
