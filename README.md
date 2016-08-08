# DRObservableArray

[![Version](https://img.shields.io/cocoapods/v/DRObservableArray.svg?style=flat)](http://cocoapods.org/pods/DRObservableArray)
[![License](https://img.shields.io/cocoapods/l/DRObservableArray.svg?style=flat)](http://cocoapods.org/pods/DRObservableArray)
[![Platform](https://img.shields.io/cocoapods/p/DRObservableArray.svg?style=flat)](http://cocoapods.org/pods/DRObservableArray)
[![codebeat](https://codebeat.co/badges/5fc91c6c-8c53-4fb0-8a01-bef10c473ad2)](https://codebeat.co/projects/github-com-darrarski-drobservablearray)
[![Build Status](https://travis-ci.org/darrarski/DRObservableArray.svg?branch=master)](https://travis-ci.org/darrarski/DRObservableArray)

> Observable array and observable mutable array protocols with generic implementations in Objective-C.

`DRObservableArray` helps to create bindings with mutable ordered collecions. For example, you can bind _(view)_models array to `UITableView`, so it automaticlally updates with animation whenever you modify the array.

## Usage

__TL;DR:__ Check out included example project.

Library consists of three base protocols:

Protocol | Description
--- | ---
[`DRObservableArray`](DRObservableArray/Common/DRObservableArray.h) | Defines ordered collection that you can subscribe to in order be notified whenever its content changes. 
[`DRObservableMutableArray`](DRObservableArray/Common/DRObservableMutableArray.h) | Defines ordered collection that you can modify using provided methods.
[`DRObservableArrayObserver`](DRObservableArray/Common/DRObservableArrayObserver.h) | Defines ordered collection observer that gets notified whenever collection changes.

You can implement your own collection, or use provided one:

Collection | Description
--- | ---
[`DRGenericObservableArray`](DRObservableArray/Common/DRGenericObservableArray.h) | Acts like `NSMutableArray`. Implements both `DRObservableArray` and `DRObservableMutableArray` protocols.

You can implement your own observer, or use provided one:

Observer | Description
--- | ---
[`DRObservableArrayTableViewUpdater`](DRObservableArray/iOS/DRObservableArrayTableViewUpdater.h) | Updates `UITableView` section automatically whenever observable array is modified. **iOS only**.
[`DRObservableArrayCollectionViewUpdater`](DRObservableArray/iOS/DRObservableArrayCollectionViewUpdater.h) | Updates `UICollectionView` section automatically whenever observable array is modified. **iOS only**.

When you need to subscribe for collection changes, add an observer to collection like this:

```Objective-C
id <DRObservableArray> collection = ...
id <DRObservableArrayObserver> observer = ...
[collection.observers addObserver:observer];
```

To avoid retain cycle issues, adding observer to collection creates __weak__ reference between collection and observer.

Collection will notify its observers using `DRObservableArrayObserver` protocol methods when an object is added to, removed from, replaced or moved in collection.

## Instalation

You can integrate `DRObservableArray` with your project using CocoaPods. To do so, you will need to add the following line to your Podfile:

    pod 'DRObservableArray', '~> 1.0'

Which creates dependecy for version `>= 1.0.0` and `< 2.0.0`

You can also download zip archive of given release from [releases page](https://github.com/darrarski/DRObservableArray/releases).

## License

The MIT License (MIT) - check out included [LICENSE](LICENSE) file
