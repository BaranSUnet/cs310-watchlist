import 'package:flutter/material.dart';

import '../movie.dart';
import '../theme.dart';
import '../widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.movie,
    required this.saved,
    required this.onToggle,
  });
  final Movie movie;
  final bool saved;
  final VoidCallback onToggle;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _saved = widget.saved;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      appBar: AppBar(title: const Text('Movie details')),
      body: ScreenBody(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poster(movie: movie, width: 110, height: 164),
              const SizedBox(width: gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${movie.year} · ${movie.genre}',
                      style: const TextStyle(color: muted),
                    ),
                    const SizedBox(height: gap),
                    ScoreBadge(movie: movie),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('Overview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            movie.overview.isEmpty
                ? 'No description available.'
                : movie.overview,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              widget.onToggle();
              setState(() => _saved = !_saved);
              showFeedback(
                context,
                _saved ? 'Added to watchlist' : 'Removed from watchlist',
              );
            },
            icon: Icon(
              _saved
                  ? Icons.bookmark_remove_outlined
                  : Icons.bookmark_add_outlined,
            ),
            label: Text(_saved ? 'Remove from watchlist' : 'Add to watchlist'),
          ),
          const SizedBox(height: 8),
          const Text(
            'You can rate saved movies in Watchlist.',
            style: TextStyle(color: muted),
          ),
        ],
      ),
    );
  }
}
