
# Quasar
An iOS app that displays various space related content feeds.
- NASA's Astronomy Picture of the Day
- Mars Rovers - Perseverance, Opportunity, Curiosity, Spirit
- Space related news
- SpaceX rocket aunches
- More to come!

> Built with SwiftUI and UIKit.

> Uses Kingfisher for asynchronous image loading and caching.

> Utilizes MVVM architecture.

![Homepage](GifDemo/homepage.gif)
![PictureOfTheDay](GifDemo/potd.gif)
![MarsRovers](GifDemo/rovers.gif)
![HubbleNews](GifDemo/hubblenews.gif)

## Priority 
- [ ] Ability to 'favorite' images and view favorited images
- [ ] Trivia game
- [ ] NASA live streams
- [ ] Media feeds (e.g. Twitter, Instagram)
- [ ] Expand news feed feature
- [ ] Milky Way planet info+animation interactive feature

## In the future
- [ ] Rework image magnification, (double tap, pinch to zoom, swipe to return to normal)
- [ ] Implement notifications for Picture of the Day, news articles
- [ ] Implement TheSpaceDevs API features
- [ ] Save images to photo album
- [ ] Share images (email, text, etc)
- [ ] Implement Updating homepage image buttons
- [ ] Gray-out unavilable rover dates in picker

## Waiting for iOS15
- [ ] Implement skeleton loader to present before get request completes
- [ ] Pull to refresh all image feeds
- [ ] Fix preset email color change bug

## Completed
- [X] Redesign homepage UI
- [X] Info modal with privacy/terms/app info
- [X] Refactor horizontal tab paging
- [X] Fix SpaceX sub-tabview remote image bug (images get stuck paging while loading remotely)
- [X] Implement grid vs column page view button
