# PixabaySearch

A small iOS application in Swift that shows a gallery of images from a search input using the https://pixabay.com API. Has a view controller for the searchField and searchButton, and a view controller for the table view that shows the search results. The app uses a custom cache solution instead of NSCache for storing the search results and the images in memory, there is no caching on the disk.

## How to run the app

There are no third party dependencies, just launch the app in Xcode. The app supports iPhones and both landscape and portrait mode. There is no iPad support yet, however you should still be able to run it on an iPad in simulator mode.

## My main goals with the project

I wanted to have a simple app with a few view controllers, a simple design and an even simpler caching. At this stage, I wasn't looking into the extra features like unit tests or data persistence.

## Challenges and notable turning points

The first version for testing the API calls had a UISearchController simply because of the faster setup, changed it later when I started to work on the design.

At first I used a UICollectionView for the images but when I changed the design to one image / row it felt like it made more sense to use a table view.

Never worked with custom cache before, and tried to make it as simple as possible. Because I only store a limited number of searches/images and it needs to delete the oldest items when it reaches the treshold, I used arrays. This means performance can be an issue, but with a really limited storage (and my limited knowledge in this field!) this works fine at this point.

