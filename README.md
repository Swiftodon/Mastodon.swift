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

### Using OAuth Login

To use OAuth Login, [configure your application to handle a custom URL scheme](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app). If using Application Sandboxing, be sure to enable Outgoing Connections.

Then use the following progression:

```swift

    let scopes = ["read", "write", "follow"]; //Define your scopes

    let client = MastodonClient(baseURL: URL(string: urlString)!)
    //Create a client instance for the server URL you want to reach

    do {
        //Create an application definition, including your custom URI, and register it with the server:
        guard let app = try await client.createApp(named: "Your App Name", redirectUri: "your-url-scheme://", scopes: scopes, website: URL(string: "https://your-url")!) else {
            return
        }

        let response = try await client.authenticate(app: app, scope: scopes )
        //Trigger the authentication flow
        
        let token = response?.oauthToken as? MastodonSwift.Token
        //Capture the auth token
        
        let authedClient = client.getAuthenticated(token: self.token!)
        //Create an authenticated client instance
        
        let result = try await authedClient.getHomeTimeline()
        //Load some content
    }

```

Additionally, ensure a handler is set up for your custom URL:

```swift 
    ContentView()
        .onOpenURL { url in
            MastodonClient.handleOAuthResponse(url: url)
        }

```



## Requirements

- `Xcode 14 / Swift 5`

## Authors

- Marcus Kida <@marcus@bearologics.social>
- Thomas Bonk <@thbonk@mastodon.online>

## License

MastodonClient is available under the MIT license. See the LICENSE file for more info.
