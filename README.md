# README

This project is intended to demonstrate some of the capabilities of the Songkick
public API.

It calls three endpoints of the API:
  - `/users/{username}/artists/tracked.json` (gets a user's tracked artists)
  - `/users/{username}/events.json` (gets a user's event attendances)
  - `/artists/{artist_id}/similar_artists.json` (gets artists similar to a given artist)

The project is a social concert discovery application that recommends concerts by:

  1. Getting a given user's tracked artists
  2. Getting the concert attendances marked by the user's friends
  3. For any of these events that the user does not track the headline artist for (and as
     such may not know about the event already), check if there is any overlap between the
     headliner and the user's tracked artists
  4. If there is an overlap of artists, we assume that this is a good recommendation
