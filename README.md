# HealthInterviewTakeHomeProblem

## Running the App

This app does take advantage of one pod from CocoaPods, so if you don't have CocoaPods installed, you may need to do so, which you can follow instructions for here: https://cocoapods.org

The podfile is set up correctly already.

## Architecture

### General
I stuck to the two tab design in an interest of time. However I think that there are likely some creative ways that the tracking and visualization tabs could be combined into one using clever design.

### Visual Design
I tried to model the visual design of the app to be similar to that of Health in iOS 13. I made sure to use system colors so that the app would work in both light and dark modes, and also included images for both modes as well.

### Data
I used both Core Data and User Defaults for this project. Your current goal is really just a single integer we need to store for the app, so it made more sense to save it into UserDefaults than go through the hassle of creating a core data entity just to store a single int. Daily intake data is more complex: it has a date associate with it, the amount of water that was drunk on said date, and an associated goal for what your goal was set to on that day. Therefore, it made more sense in this case to use a Core Data entity to house the information.

To faciliate a single point of interaction for both defaults and core data, I created a shared class, DataManager, that other classes could use to access the data without having to worry about where it was coming from.

### Random Tidbits
* The fonts are for the most part static. There's some work to be done to support dynamic type.
* The accessibility is only okay, by my high standards ;)
* It would be nice to make the quick add shortcuts more dynamic and adapt to user behavior. So if the app found the user was entering 2oz a lot, it would show up there as a quick add shortcut.

## RingProgressView

If I'd had time, I would have loved to take a stab at creating a ring view similar to what can be found on Apple Watch. However, felt that was beyond the scope of this take home assignment. I still wanted that visual look for tracking progress though, so I found this open source view that I was able to take advantage of that did exactly what I needed.

I accessed this view through CocoaPods, and it requires installation for use. It can be found here: https://github.com/maxkonovalov/MKRingProgressView

## Enhancement

I picked the enhancement to add a water intake goal and visualize its progress. I chose this one specifically because to me it felt like a core function of the app that just couldn't be left out, and allowed me to play around with making the UI visually interesting with the ring view.

## References
* Loading data based on date range from Core Data: https://stackoverflow.com/questions/40312105/core-data-predicate-filter-by-todays-date
* Adding 'Done' button to numeric keyboard: https://stackoverflow.com/questions/28338981/how-to-add-done-button-to-numpad-in-ios-using-swift
* Ring Progress View: https://github.com/maxkonovalov/MKRingProgressView

