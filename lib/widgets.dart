import 'package:flutter/material.dart';

import 'movie.dart';
import 'theme.dart';

class ScreenBody extends StatelessWidget {
  const ScreenBody({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [wash, white, Color(0xFFFFEEF8)],
        stops: [0, .52, 1],
      ),
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: ListView(
          padding: const EdgeInsets.all(gutter),
          children: children,
        ),
      ),
    ),
  );
}

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });
  final Movie movie;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(
      'assets/images/poster-placeholder.png',
      fit: BoxFit.cover,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          movie.posterUrl,
          fit: BoxFit.cover,
          semanticLabel: '${movie.title} poster',
          frameBuilder: (context, child, frame, synchronous) =>
              frame == null && !synchronous ? fallback : child,
          errorBuilder: (context, error, stack) => fallback,
        ),
      ),
    );
  }
}

class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xFFFCE0EF),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'TMDB  ${movie.scoreText}/10',
        style: const TextStyle(
          color: ink,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    ),
  );
}

class MovieRow extends StatelessWidget {
  const MovieRow({super.key, required this.movie, required this.onOpen});
  final Movie movie;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: onOpen,
    child: Padding(
      padding: const EdgeInsets.all(gap),
      child: Row(
        children: [
          Poster(movie: movie, width: 58, height: 84),
          const SizedBox(width: gap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 3),
                Text(
                  '${movie.year} · ${movie.genre}',
                  style: const TextStyle(color: muted),
                ),
                const SizedBox(height: 8),
                ScoreBadge(movie: movie),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: blue),
        ],
      ),
    ),
  );
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });
  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      child: Column(
        children: [
          Icon(icon, color: blue, size: 32),
          const SizedBox(height: gap),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: muted),
          ),
          if (action != null) ...[const SizedBox(height: gap), action!],
        ],
      ),
    ),
  );
}

void showFeedback(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
}
