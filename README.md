# MastodonClient

[![License](https://img.shields.io/cocoapods/l/MastodonClient.svg?style=flat)](http://cocoapods.org/pods/MastodonClient)
[![Platform](https://img.shields.io/cocoapods/p/MastodonClient.svg?style=flat)](http://cocoapods.org/pods/MastodonClient)

## Howto

This client is designed to connect to any Mastodon instance and interact with it. As of the time of writing this (08th April 2017) the Moya Providers are feature complete with [tootsuite/mastodon](https://github.com/tootsuite/mastodon).

`MastodonClient` contains a few convenience methods to create Apps (OAuth Clients) and interact with the API but you should use the Moya Targets directly for the time being (as those are feature complete).

Given you've got an OAuth Client

```swift
let app = App(clientId: "…", clientSecret: "…")
```

Logging in is as easy as this then:

```swift
let client = MastodonClient(baseURL: URL(string: "https://host.tld")!)

let app = App(
    clientId: "a1a2a3a4a5",
    clientSecret: "s3cr3t"
)

let response = try await client.getToken(
    app,
    username: "test+account@host.tld",
    password: "pa4w0rd",
    scope: ["read", "write", "follow"]
)
```

Provided login was successful and you've retrieved an `AccessToken` you're free to use all the other APIs, e.g. to retrieve your home timeline:

```swift
let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!)

let result = try await client.getHomeTimeline(token)
```

Please note that the endpoint provided by teh operator overrides the URL stored in the settings singleton.

## Requirements

- `Xcode 14 / Swift 5`

## Authors

- Marcus Kida <@marcus@bearologics.social>
- Thomas Bonk <@thbonk@mastodon.online>

## License

MastodonClient is available under the MIT license. See the LICENSE file for more info.
