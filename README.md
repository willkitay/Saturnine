
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

## TODO
- [X] Redesign homepage UI
- [X] Info modal with privacy/terms/app info
- [X] Refactor horizontal tab paging
- [ ] Pull to refresh all features
- [ ] Rework image magnification, (double tap, pinch to zoom, swipe to return to normal)
- [ ] Implement notifications for Picture of the Day, news articles
- [ ] Implement TheSpaceDevs API features
- [ ] Save images to photo album
- [ ] Share images (email, text, etc)\
- [X] Fix SpaceX sub-tabview remote image bug (images get stuck paging while loading remotely)
- [ ] Fix preset email color change bug
- [ ] Implement skeleton loader to present before get request completes
- [ ] Implement grid vs column page view button
- [ ] Implement Updating homepage image buttons
- [ ] Gray-out unavilable rover dates in picker
- [ ] Implement "likes" for images which save image in local storage
