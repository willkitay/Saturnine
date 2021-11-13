
# Saturnine
Explore the galaxy with Saturnine - trek through Mars alongside NASA's rovers, catch up on events such as spacewalks, engine tests, and landings, or browse through the picture of the day gallery. 

Features include:
- Mars rover image feeds
- NASA picture of the day gallery
- Learn about our solar system
- Discover the spacecraft and astronauts we rely on
- Save or share your favorite images

> Built with SwiftUI and UIKit.

> Uses Kingfisher for asynchronous image loading and caching.

> MVVM architecture.

Join beta testing at https://testflight.apple.com/join/X0nu4Efb
![homescreen](/screenshots/homescreen.jpg)|![potd](/screenshots/potd.jpg)|![spacecraft](/screenshots/spacecraft.jpg)
| :-------------------------:|:-------------------------:|:-------------------------:|
![rover](/screenshots/rover.jpg)|![venus](/screenshots/venus.jpg)|![favorites](/screenshots/favorites.jpg)

## TODO 
- [ ] Alert when user has poor connection
- [ ] Notifications for new photos
- [ ] Trivia game
- [ ] NASA live streams
- [ ] Media feeds (e.g. Twitter, Instagram)
- [ ] Rework image magnification, (double tap, pinch to zoom, swipe to return to normal)
- [ ] Implement notifications for Picture of the Day, news articles
- [ ] Implement Updating homepage image buttons
- [ ] Gray-out unavilable rover dates in picker

## Completed
- [X] Redesign homepage UI
- [X] Info modal with privacy/terms/app info
- [X] Refactor horizontal tab paging
- [X] Fix SpaceX sub-tabview remote image bug (images get stuck paging while loading remotely)
- [X] Implement grid vs column page view button
- [X] Save images to photo album
- [X] Share images (email, text, etc)
- [X] Ability to 'favorite' images and view favorited images
- [X] Spacecraft feature
- [X] Astronaut feature
- [X] Expand news feed feature
- [X] Implement TheSpaceDevs API features: ~~spacecraft~~, ~~astronauts~~, ~~space stations~~, ~~events~~
- [X] ~~Implement TheSpaceDevs news api feature~~
- [X] Implement skeleton loader to present before GET request completes
