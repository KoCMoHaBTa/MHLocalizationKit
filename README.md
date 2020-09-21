# MHLocalizationKit
[![Build Status](https://app.bitrise.io/app/a71104b9ca60c8dc/status.svg?token=DSPum5gnwY2pbUR8gZonpQ&branch=master)](https://app.bitrise.io/app/a71104b9ca60c8dc)

[method swizzling]:
https://www.google.bg/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwiC5POo3dbSAhWF1hoKHSWuAswQFggaMAA&url=http%3A%2F%2Fnshipster.com%2Fmethod-swizzling%2F&usg=AFQjCNGmVmqs_9prQvsgkkXKW2lT5HM-YA

MHLocalizationKit is an utility and infrastructure library that can be used for runtime language changes by modifying the behavior of the standard iOS localization system and using the same translation resources.

In short - you continue to use `.strings` files and `NSLocalizedString` macros/functions with the ability to specify and change the language at runtime.

## How it works
The standard `NSLocalizedString` macros/functions are actually using the `Bundle.localizedString(forKey:value:table:)`. Internally this method loads the needed `.strings` files based on the system's language.

What this library does is, by using [method swizzling], to alter the default behaviour of `Bundle` to force it to load `.strings` from a bundle pointing directly to the directory of the `.strings` files for the applied language at runtime.

## Installation

[Embed]:
https://developer.apple.com/library/content/technotes/tn2435/_index.html#//apple_ref/doc/uid/DTS40017543-CH1-PROJ_CONFIG-APPS_WITH_MULTIPLE_XCODE_PROJECTS

#### [Carthage](https://github.com/Carthage/Carthage)

Add `github "KoCMoHaBTa/MHLocalizationKit"` to your `Cartfile`, then [Embed] the framework directly into your project.

#### [Cocoapods](https://cocoapods.org)

Add `pod 'MHLocalizationKit'` to your  `Podfile`

#### [Submodules](http://git-scm.com/docs/git-submodule)

[Add a submodule](https://git-scm.com/docs/git-submodule#git-submodule-add-bltbranchgt-f--force--nameltnamegt--referenceltrepositorygt--depthltdepthgt--ltrepositorygtltpathgt) to your repostiroy, then [Embed] the framework directly into your project

#### Manually

[Download](https://github.com/KoCMoHaBTa/MHLocalizationKit/releases), then [Embed] the framework directly into your project

## How to use

### Basics
- in you `UIViewController` subclasses that you wish to handle runtime language changes - conform to the `Localizable` protocol
- implement `languageDidChange(from:to:)` and load your localized string from there using the standard `NSLocalizedString` macros/functions.
- when your app launches - set the desired value to `Bundle.language` - this will call `languageDidChange(from:to:)` on all alive view controllers that conform to the `Localizable` protocol.

### NSLocalizedString functions

As of Xcode 11, `genstrings` now works with the swift version of `NSLocalizedString`, so the overload functions has been removed due to their incompatibility with the updated `genstrings`.

### Details
The language setting is persisted between application launches.

UIViewController subclasses that conforms to `Localizable` protocol will receive `languageDidChange(from:to)` call automatically upon `viewDidLoad()`. This is achieved using [method swizzling].

You could opt-in for automatic system language and locale tracking by setting to `true` respectively `Bundle.trackSystemLanguageChanges` and `Bundle.trackSystemLocaleChanges`

You could subscribe for language change notifications by using `LanguageWillChangeNotificationName` and `LanguageDidChangeNotificationName`

## Changelog

#### 1.0.0
- initial documented version
