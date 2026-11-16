# Watchlist

CS310 Mobile Application Development · Group 15 · Step 2.2 review

Watchlist is a Flutter app for browsing movies and keeping a personal watchlist. This review implements the six Step 2.1 screens with sample movies. Login and signup demonstrate validation and navigation. Watchlist changes are kept in memory during the session.

## Run locally

Tested with Flutter 3.47.9 and Dart 3.13.7. Start an Android emulator or an iOS simulator and run:

```sh
flutter pub get
flutter devices
flutter run -d <device-id>
```

Use `demo@example.com` and `movie123` in the preview form. Tap **Continue** in the dialog. Film posters load over HTTPS and have a bundled fallback.

```sh
flutter analyze
flutter test
```

## Walk through the app

1. Try an empty login, then enter a valid-looking email and password. **Sign up** leads to the second form.
2. On **Discover**, choose a filter or shuffle the remaining movies. Swipe right or tap **Save**. Swipe left or tap **Skip**.
3. Search for a title. Open a result, then return to your search.
4. On **Watchlist**, mark a movie watched, give it stars, clear the rating, or remove the saved card.

The catalogue is in `lib/movie.dart`. The access form uses Flutter's `Form` and standard validators. The tabs share a watchlist in `HomeScreen`, which calls `setState` when the list changes. `Dismissible` handles gestures and calls the same function as the Skip and Save buttons. `lib/theme.dart` contains the shared colours, typography and spacing.

The review uses the blue, white and pink [Step 2.1 wireframes](https://www.figma.com/design/Z5BcaVANKpbIeOm2TuV1kV/CS310-Group-15---Watchlist-wireframes?node-id=3-508). Real authentication and persistence are later steps. Reminders are deferred.

## Credits

- Movie posters are hosted by [TMDB](https://www.themoviedb.org). Scores and descriptions are sample fixtures. This product uses the TMDB API but is not endorsed or certified by TMDB.
- The TMDB logo by Travis Bell is [from Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Tmdb.new.logo.svg), [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). It was converted to PNG.
- [DM Sans](https://github.com/google/fonts/tree/main/ofl/dmsans) is licensed under the [SIL Open Font License](assets/fonts/OFL.txt).

## Team

Baran Aksoy · Adar Doğru · Ozan Barış Turgut

The team will record each member's actual implementation and commits in the Step 2.2 report. This review does not assign credit for work.
