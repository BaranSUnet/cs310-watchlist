import 'package:flutter/material.dart';

import '../movie.dart';
import '../theme.dart';
import '../widgets.dart';
import 'detail_screen.dart';
import 'filter_dialog.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  MovieFilters _filters = const MovieFilters();
  List<Movie> _deck = [...sampleMovies];
  final List<SavedMovie> _saved = [];

  bool _isSaved(Movie movie) =>
      _saved.any((entry) => entry.movie.id == movie.id);

  void _add(Movie movie) {
    if (!_isSaved(movie)) _saved.add(SavedMovie(movie));
  }

  void _remove(Movie movie) =>
      _saved.removeWhere((entry) => entry.movie.id == movie.id);

  void _advance(Movie movie, {required bool save}) {
    if (_deck.isEmpty || _deck.first.id != movie.id) return;
    final added = save && !_isSaved(movie);
    setState(() {
      if (save) _add(movie);
      _deck.removeAt(0);
    });
    if (save) {
      showFeedback(
        context,
        added ? 'Added to watchlist' : 'Already in watchlist',
      );
    }
  }

  void _apply(MovieFilters filters) => setState(() {
    _filters = filters;
    _deck = sampleMovies.where(filters.matches).toList();
  });

  Future<void> _openFilters() async {
    final draft = await showDialog<MovieFilters>(
      context: context,
      builder: (_) => FilterDialog(filters: _filters),
    );
    if (!mounted || draft == null) return;
    _apply(draft);
  }

  void _openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          movie: movie,
          saved: _isSaved(movie),
          onToggle: () => setState(() {
            if (_isSaved(movie)) {
              _remove(movie);
            } else {
              _add(movie);
            }
          }),
        ),
      ),
    );
  }

  Widget _discover() {
    final movie = _deck.firstOrNull;
    return ScreenBody(
      children: [
        Text(
          'Find your next watch',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Swipe left to skip or right to save.',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _openFilters,
                icon: const Icon(Icons.tune),
                label: const Text('Filters'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _deck.length < 2
                    ? null
                    : () {
                        setState(_deck.shuffle);
                        showFeedback(context, 'Remaining movies shuffled');
                      },
                icon: const Icon(Icons.shuffle),
                label: const Text('Randomize'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _filters.summary,
          style: const TextStyle(color: muted, fontSize: 12),
        ),
        const SizedBox(height: gap),
        if (movie == null)
          EmptyCard(
            icon: Icons.movie_filter_outlined,
            title: 'No more matching movies',
            message: 'Change your filters or reset the list.',
            action: TextButton(
              onPressed: () => _apply(const MovieFilters()),
              child: const Text('Reset filters'),
            ),
          )
        else ...[
          Dismissible(
            key: ValueKey(movie.id),
            direction: DismissDirection.horizontal,
            resizeDuration: null,
            background: _swipeCue(
              'Save',
              Icons.bookmark_add_outlined,
              Alignment.centerLeft,
            ),
            secondaryBackground: _swipeCue(
              'Skip',
              Icons.close,
              Alignment.centerRight,
            ),
            onDismissed: (direction) =>
                _advance(movie, save: direction == DismissDirection.startToEnd),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(gap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Poster(movie: movie, width: double.infinity, height: 255),
                    const SizedBox(height: gap),
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 10,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${movie.year} · ${movie.genre}',
                          style: const TextStyle(color: muted),
                        ),
                        ScoreBadge(movie: movie),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _openMovie(movie),
                        icon: const Icon(Icons.chevron_right),
                        label: const Text('Details'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: gap),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _advance(movie, save: false),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Skip'),
                ),
              ),
              const SizedBox(width: gap),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _advance(movie, save: true),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _swipeCue(String label, IconData icon, Alignment alignment) =>
      Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFCCCE7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), Text(label)],
        ),
      );

  Widget _watchlist() => ScreenBody(
    children: [
      Text('Your watchlist', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 8),
      Text('${_saved.length} saved', style: const TextStyle(color: muted)),
      const SizedBox(height: 16),
      if (_saved.isEmpty)
        EmptyCard(
          icon: Icons.bookmark_border,
          title: 'Your watchlist is empty',
          message: 'Save a movie from Discover to see it here.',
          action: FilledButton(
            onPressed: () => setState(() => _tab = 0),
            child: const Text('Browse movies'),
          ),
        ),
      for (final entry in _saved) ...[
        Card(
          key: ValueKey('saved-${entry.movie.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MovieRow(
                movie: entry.movie,
                onOpen: () => _openMovie(entry.movie),
              ),
              const Divider(height: 1, color: line),
              CheckboxListTile(
                title: const Text('Watched'),
                value: entry.watched,
                onChanged: (value) =>
                    setState(() => entry.watched = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(gap, 0, gap, gap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.rating == null
                          ? 'Your rating: Unrated'
                          : 'Your rating: ${entry.rating}/5',
                    ),
                    Wrap(
                      children: [
                        for (int star = 1; star <= 5; star++)
                          IconButton(
                            tooltip: 'Rate ${entry.movie.title} $star out of 5',
                            onPressed: () =>
                                setState(() => entry.rating = star),
                            icon: Icon(
                              star <= (entry.rating ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: blue,
                            ),
                          ),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        if (entry.rating != null)
                          TextButton(
                            onPressed: () =>
                                setState(() => entry.rating = null),
                            child: const Text('Clear rating'),
                          ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() => _remove(entry.movie));
                            showFeedback(context, 'Removed from watchlist');
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Remove'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: gap),
      ],
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(const ['Discover', 'Search', 'Watchlist'][_tab]),
      actions: [
        IconButton(
          tooltip: 'Credits',
          icon: const Icon(Icons.info_outline),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Credits'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/tmdb.png', width: 85),
                  const SizedBox(height: gap),
                  const Text(
                    'Movie posters from The Movie Database. This product uses the TMDB API but is not endorsed or certified by TMDB.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Movie details and scores in this version are sample data.',
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    body: IndexedStack(
      index: _tab,
      children: [
        _discover(),
        SearchScreen(onOpen: _openMovie),
        _watchlist(),
      ],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _tab,
      onDestinationSelected: (index) => setState(() => _tab = index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore),
          label: 'Discover',
        ),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark),
          label: 'Watchlist',
        ),
      ],
    ),
  );
}
