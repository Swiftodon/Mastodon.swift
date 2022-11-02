# MastodonClient

![GitHub](https://img.shields.io/github/license/Swiftodon/Mastodon.swift)

![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/Swiftodon/Mastodon.swift/Run%20tests/main)

## Howto

This client is designed to connect to any Mastodon instance and interact with it.

`MastodonClient` contains a few convenience methods to create Apps (OAuth Clients) and interact with the API but you should use the URLSession TargetTypes directly for the time being (as those are feature complete), e.g. for getting your Home Timeline:

```swift
let request = try MastodonClient.request(
    for: URL(string: "https://mastodon.social")!,
    target: Mastodon.Timelines.home(nil, nil),
    withBearerToken: token
)

let (data, _) = try await session.data(for: request)

let result = try JSONDecoder().decode([Status].self, from: data)
```

Given you've got an OAuth Client

```swift
let app = App(clientId: "…", clientSecret: "…")
```

Logging in is as easy as this then:

```swift
let client = MastodonClient(baseURL: URL(string: "https://mastodon.tld")!)

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

Provided login was successful and you've retrieved an `AccessToken` you're free to use all the other APIs, e.g. to retrieve your home timeline using `MastodonClientAuthenticated` e.g.:

```swift
let client = MastodonClient(baseURL: URL(string: "https://mastodon.tld")!)
    .getAuthenticated(token: token)

let result = try await client.getHomeTimeline()
```

## Requirements

- `Xcode 14 / Swift 5`

## Authors

- Marcus Kida <@marcus@bearologics.social>
- Thomas Bonk <@thbonk@mastodon.online>

## License

MastodonClient is available under the MIT license. See the LICENSE file for more info.
