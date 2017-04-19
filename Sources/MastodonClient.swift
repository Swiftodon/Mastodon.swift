import Foundation
import Alamofire
import Moya
import RxSwift
import RxMoya
import MoyaGloss
import RxMoyaGloss

public typealias Scope = String
public typealias Scopes = [Scope]

public class MastodonClient {
    public init() {
    }
    
    public var plugins = [PluginType]()

    public func createApp(_ serverUrl: URL, _ name: String, redirectUri: String = "urn:ietf:wg:oauth:2.0:oob", scopes: Scopes, url: URL) -> Observable<App> {
        return RxMoyaProvider<Mastodon.Apps>(plugins: plugins)
            .request(.register(
                serverUrl, name, redirectUri,
                scopes.reduce("") { $0 == "" ? $1 : $0 + " " + $1},
                url.absoluteString
            ))
            .mapObject(type: App.self)
    }
    
    public func getToken(_ serverUrl: URL, _ app: App, username: String, _ password: String) -> Observable<AccessToken> {
        return RxMoyaProvider<Mastodon.OAuth>(plugins: plugins)
            .request(.authenticate(serverUrl, app, username, password))
            .mapObject(type: AccessToken.self)
    }

    public func getHomeTimeline(_ token: String, maxId: StatusId? = nil, sinceId: StatusId? = nil) -> Observable<[Status]> {
        let accessToken = AccessTokenPlugin(token: token)
        return RxMoyaProvider<Mastodon.Timelines>(
                plugins: [plugins, [accessToken]].flatMap { $0 }
            )
            .request(.home(maxId, sinceId))
            .mapArray(type: Status.self)
    }

    public func getPublicTimeline(_ token: String, isLocal: Bool = false, maxId: StatusId? = nil, sinceId: StatusId? = nil) -> Observable<[Status]> {
        let accessToken = AccessTokenPlugin(token: token)
        return RxMoyaProvider<Mastodon.Timelines>(
                plugins: [plugins, [accessToken]].flatMap { $0 }
            )
            .request(.pub(isLocal, maxId, sinceId))
            .mapArray(type: Status.self)
    }

    public func getTagTimeline(_ token: String, tag: String, isLocal: Bool = false, maxId: StatusId? = nil, sinceId: StatusId? = nil) -> Observable<[Status]> {
        let accessToken = AccessTokenPlugin(token: token)
        return RxMoyaProvider<Mastodon.Timelines>(
                plugins: [plugins, [accessToken]].flatMap { $0 }
            )
            .request(.tag(tag, isLocal, maxId, sinceId))
            .mapArray(type: Status.self)
    }
}
