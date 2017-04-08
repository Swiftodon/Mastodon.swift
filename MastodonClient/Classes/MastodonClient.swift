import RxSwift
import Moya
import Moya_Gloss

typealias Scope = String
typealias Scopes = [Scope]

class MastodonClient {
    
    var plugins = [PluginType]()

    func createApp(_ name: String, redirectUri: String = "urn:ietf:wg:oauth:2.0:oob", scopes: Scopes, url: URL) -> Observable<App> {
        return RxMoyaProvider<Mastodon.Apps>(plugins: plugins)
            .request(.register(
                name, redirectUri,
                scopes.reduce("") { $0 == "" ? $1 : $0 + " " + $1},
                url.absoluteString
            ))
            .mapObject(type: App.self)
    }
    
    func getToken(_ app: App, username: String, _ password: String) -> Observable<AccessToken> {
        return RxMoyaProvider<Mastodon.OAuth>(plugins: plugins)
            .request(.authenticate(app, username, password))
            .mapObject(type: AccessToken.self)
    }
    
    func getHomeTimeline(_ token: String) -> Observable<[Status]> {
        let accessToken = AccessTokenPlugin(token: token)
        return RxMoyaProvider<Mastodon.Timelines>(
                plugins: [plugins, [accessToken]].flatMap { $0 }
            )
            .request(.home)
            .mapArray(type: Status.self)
    }
}
