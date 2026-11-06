# Watchlist

CS310 Mobile Application Development - Group 15

Watchlist is a planned Flutter movie-discovery app built around a simple swipe deck.
Choose a genre and optional minimum TMDB score/release-year filters, or use random
mode to shuffle the matching movies. Swipe right to save a movie to your watchlist;
swipe left to skip it. The watchlist tracks what you want to watch, watched status,
personal stars, and planned reminders to watch saved movies.

## Current design direction - 6 November 2026

- One movie card at a time: poster, title, year and TMDB score.
- Swipe left = skip; swipe right = save. Matching Skip and Save buttons provide the same actions.
- Filters: genre, minimum TMDB score and release-year lower bound.
- Random mode shuffles the current matching set; with no filters, it samples the available set.
- Movie details show the overview and offer saving/removal.
- The watchlist prevents duplicate movie IDs, supports removal, watched/unwatched status, and editable/clearable 1-5 personal stars.
- Title search remains available from the Step 1 core scope.
- Reminders are part of the intended app. In-app reminders versus scheduled phone notifications are still being decided; notifications are not implemented.
- Login and sign-up screens are UI-only in Step 2, as required by the assignment.

These design changes correct the earlier browse-list description. The submitted
Step 1 PDF is preserved. The revised interaction design still needs group/TA review;
this README does not claim TA approval of added scope.

## Implementation approach and status

The Flutter app has not been implemented. The existing local browser wireframe
preview is a design experiment and is being revised for the swipe flow; it is not
runnable Flutter code or a finished milestone submission.

Use simple Dart model objects, lists, reusable Flutter widgets and setState.
Use Flutter's built-in Dismissible for left/right swipes rather than a card-stack
package. Dismissible is an explicitly accepted extension beyond the lessons checked.
List shuffling, models, cards, state updates, input handling and basic navigation
are supported by the posted Week 1-6 materials/examples.

TMDB supplies movie data and its own score (0-10), not IMDb ratings. Personal stars
(1-5) are separate. The accepted first-version filters use TMDB score, genre and year.

The Step 1 data plan uses HTTP/JSON plus SQLite through sqflite and path. Networking
and persistence are later-course topics, not claims of already-taught or completed
implementation. Firebase is required in Step 3; its specification must be reviewed
before finalizing authentication and data responsibilities. Real phone notifications
would require additional scheduling/permission work and explicit scope approval.

An authenticated standalone TMDB check passed on 25 October 2026 for genre browsing,
title search, combined genre/year/score filters, details and a poster. It does not
verify Flutter integration, local storage, authentication or reminders.

Never commit API credentials. Include the provider's required attribution.
No shared-rating analytics, generated review summaries or recommendation engine
are planned.

## Next project steps

1. Agree on the reminder behavior and review the corrected swipe-first wireframes.
2. Submit Step 2.1 by 8 November, 23:59; obtain TA feedback before UI implementation.
3. Implement approved Flutter UI incrementally with each member's own contributions and commits.
4. Test filtering, skip/save, duplicate prevention, details/back navigation and watchlist controls.
5. Integrate and test API, persistence, authentication and reminders when their scope is approved.

## Group and Step 1 responsibilities

| Member | Student ID | Assigned tasks |
| --- | --- | --- |
| Baran Aksoy | 33575 | All Step 1 tasks jointly with Adar: proposal, scope, API feasibility, data requirements, challenges, repository setup and final review; Step 1 coordinator. |
| Adar Doğru | 34269 | All Step 1 tasks jointly with Baran: proposal, scope, API feasibility, data requirements, challenges, repository setup and final review. |
| Ozan Barış Turgut | 32200 | Review the revised scope and user-input features; write or revise the final data/storage and technical-challenges sections; review the final proposal and README. |

Step 1 coordinator: **Baran Aksoy (33575)**. A different member will coordinate
the next step. These are assigned responsibilities; all members must review the
final submission and be able to explain their own work.

## Repository and references

Public repository: https://github.com/BaranSUnet/cs310-watchlist

Owner: BaranSUnet (formerly baran33575). Adar-21 and ozanbaristurgutt accepted
collaborator access, verified 25 October 2026.

- [TMDB movie discovery and filters](https://developer.themoviedb.org/reference/discover-movie)
- [TMDB title search](https://developer.themoviedb.org/reference/search-movie)
- [Flutter Dismissible](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
- [Flutter SQLite guide](https://docs.flutter.dev/cookbook/persistence/sqlite)
