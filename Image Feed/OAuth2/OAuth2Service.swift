import UIKit

final class OAuth2Service {
    // MARK: - Public Properties
    var authToken: String? {
        get {
            OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    static let shared = OAuth2Service()
    // MARK: - Private Properties
    private var task: URLSessionTask? // для того чтобы смотреть выполняется ли сейчас поход в сеть за токеном
    private var lastCode: String? // для того чтобы запомнить последний токен и потом сравнивать полученный с ним
    private let decoder = JSONDecoder()
    private let urlSession = URLSession.shared
    private enum AuthServiceError: Error {
        case invalidRequest
        case codeError
        case tokenError
    }
    
    private enum OAuth2ServiceConstants {
        static let unsplashGetTokenURLString = "https://unsplash.com/oauth/token"
    }
    
    private init() {
    }
    
    func fetchOAuthToken(_ code: String, handler: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil {
            if lastCode != code {
                task?.cancel()
            } else {
                handler(.failure(AuthServiceError.invalidRequest))
                return
            }
        } else {
            if lastCode == code {
                handler(.failure(AuthServiceError.invalidRequest))
                return
            }
        }
        lastCode = code
        guard
            let request = makeOAuthTokenRequest(code: code)
        else {
            print("реквест не найден")
            handler(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { (result: Result<OAuthTokenResponseBody, Error>) in
            
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let token = data.accessToken
                else {
                    handler(.failure(AuthServiceError.tokenError))
                    print("Токен не найден")
                    return
                }
                handler(.success(token))
            case .failure(let error):
                print("Error: \(error)")
                handler(.failure(error))
            }
        }
        task.resume()
    }
}

private func makeOAuthTokenRequest(code: String) -> URLRequest? {
    let baseURL = URL(string: "https://unsplash.com")
    guard
        let url = URL(string: "/oauth/token"
                      + "?client_id=\(Constants.accessKey)"
                      + "&&client_secret=\(Constants.secretKey)"
                      + "&&redirect_uri=\(Constants.redirectURI)"
                      + "&&code=\(code)"
                      + "&&grant_type=authorization_code",
                      relativeTo: baseURL)
    else {
        print("OAuth2Service url - error")
        return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request
}



/*/ private let urlSession = URLSession.shared
 
 private var task: URLSessionTask?
 private var lastCode: String?
 
 private func createOAuthRequest(code: String) -> URLRequest? {
 var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")
 urlComponents?.queryItems = [
 URLQueryItem(name: "client_id", value: Constants.accessKey),
 URLQueryItem(name: "client_secret", value: Constants.secretKey),
 URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
 URLQueryItem(name: "code", value: code),
 URLQueryItem(name: "grant_type", value: "authorization_code")
 ]
 guard let url = urlComponents?.url else {
 assertionFailure("Failed to create URL")
 return nil
 }
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 print(request)
 return request
 }
 */

