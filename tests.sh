#!/bin/bash

xcodebuild test -project DRObservableArrayExample.xcodeproj -scheme 'Tests iOS' -destination 'platform=iOS Simulator,name=iPhone 5s,OS=latest' ONLY_ACTIVE_ARCH=NO | xcpretty
