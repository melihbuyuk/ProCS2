# iMDB Popular TV Shows

## Version

1.0

## Build and Runtime Requirements

+ Xcode 11.0 or later
+ iOS 10.0 or later

## Configuring the Project

Configuring the Xcode project requires Cocoapod, pod install and run the project.

## About

It's a sample code project for iOS. In this sample, users can view popular tv show list and details, add them to their favlist.

## Architecture & Features

This sample is written in Swift and architecture is designed as MVVM pattern. Cocoapod is used as package manager, 5 pods inclueded;
+ Hero (to change screen with animation)
+ Kingfisher (to download and cache images)
+ Moya (network layer)
+ ObjectMapper (to convert json to object)
+ RealmSwift (database to save favorites)
+ SwiftyTimer (to schedule repeating timer)

All strings are in localizable file, all fixed values are in constants file to manage easily. DBManager (Realm) is for favorite actions, network manager (Moya) is for communication layer. Project has two screens, first one is listing page and other one is detail page. Listing page is infinite scroll, when user is end of screen it automatically requests for next page. Users also can like tv show on detail screen. Listing page is always up to date (checking every minute), when sorting changes user sees a refresh button to renew data.

## Unit Tests

There are two classes to test business layer (ViewModels). List and detail screens can test for all circumstances.

## UI Tests

UI test scenerio;
+ Launch app 
+ Scroll list
+ Tap one of cells
+ View detail screen
+ Like tv show
