import Foundation

enum Constants {
    
    static let accessKey = "6wTGHiALhnNsrUfnsuTDKjyQl2iU-aRMknFPeAfJHWU"
    static let secretKey = "CH38Ke5G85Cmv5EoR9ZMltbRe5zDpJCYRUAiYLmaHYA"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
    
    enum UserDefaults {
        static let bearerTokenKey = "bearerToken"
    }
}
