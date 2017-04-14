# MastodonClient

[![CI Status](http://img.shields.io/travis/kimar/Mastodon.swift.svg?style=flat)](https://travis-ci.org/git/MastodonClient)
[![License](https://img.shields.io/cocoapods/l/MastodonClient.svg?style=flat)](http://cocoapods.org/pods/MastodonClient)
[![Platform](https://img.shields.io/cocoapods/p/MastodonClient.svg?style=flat)](http://cocoapods.org/pods/MastodonClient)

## Howto

This client is designed to connect to any Mastodon instance and interact with it. As of the time of writing this (08th April 2017) the Moya Providers are feature complete with [tootsuite/mastodon](https://github.com/tootsuite/mastodon).

`MastodonClient` contains a few convenience methods to create Apps (OAuth Clients) and interact with the API but you should use the Moya Targets directly for the time being (as those are feature complete).

**Do not forget** to setup you Mastodon base url by setting it in the `Settings` singleton before trying to use any of the APIs:

```swift
Settings.shared.baseURL = NSURL(string: "https://mastodon.social")!
```

Given you've got an OAuth Client

```swift
let app = App(clientId: "…", clientSecret: "…")
```

Logging in is as easy as this then:

```swift
RxMoyaProvider<Mastodon.OAuth>()
.request(.authenticate(app, username, password))
.mapObject(type: AccessToken.self)
.subscribe { even in … }
```

Provided login was successful and you've retrieved an `AccessToken` you're free to use all the other APIs, e.g. to retrieve your home timeline:

```swift
RxMoyaProvider<Mastodon.Timelines>(plugins: [AccessTokenPlugin(token: accessToken.token)])
.request(.home)
.mapArray(type: Status.self)
.subscribe { even in … }
```

## Requirements

* `Xcode 8.3 / Swift 3.1`
* `Alamofire`
* `Moya`
* `Gloss`
* `RxSwift`

## Installation

### Using Carthage

```
github "Swiftodon/Mastodon.swift"
```

## Authors

* Marcus Kida <kidmar@mastodon.kida.io>
* Thomas Bonk

## License

MastodonClient is available under the MIT license. See the LICENSE file for more info.
