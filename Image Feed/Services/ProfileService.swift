import Foundation

struct ProfileResult: Decodable {
    
    var username: String
    var firstName: String
    var lastName: String?
    var bio: String?
    
    }

struct Profile {
    
    let username: String
    let name: String
    let loginName: String?
    let bio: String?
    
    }

final class ProfileService {
    static let shared = ProfileService()
    private init() {}
    
    private let decoder = JSONDecoder()
        private(set) var profile: Profile?
        
        private enum RequestError: Error { // Ошибки сети, потом УДАЛИТЬ
            case invalidRequest
            case invalidBaseURL
            case invalidURLComponents
            case badRequest
        }
        
        private enum ParsingJSONServiceError: Error { // Ошибки декодирования, потом УДАЛИТЬ
            case decodeError
            case invalidJson
            case incorrectObject
        }
    
    private func makeProfileRequest(token: String) -> URLRequest? {
        guard let baseUrl = URL(string: Constants.defaultBaseURL!.absoluteString) else {
            preconditionFailure("Invalid base URL \(ErrorsList.RequestError.invalidBaseURL)")
        }
        guard let url = URL(string:
                                "/me",
                            relativeTo: baseUrl
        ) else {
            preconditionFailure("Invalid URL Components \(ErrorsList.RequestError.invalidURLComponents)")
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return request
    }
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
                assert(Thread.isMainThread)
                
                guard let request = makeProfileRequest(token: token) else {
                    return completion(.failure(RequestError.invalidRequest))
                }
                
                let task = URLSession.shared.data(for: request) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.decoder.keyDecodingStrategy = .convertFromSnakeCase
                        do {
                            guard let response = try self?.decoder.decode(ProfileResult.self, from: data) else {
                                print("Parsing JSON error:\(ParsingJSONServiceError.invalidJson)")
                                    return
                            }
                            let profile = Profile(username: response.username,
                                                  name: response.firstName + " " + (response.lastName ?? ""),
                                                  loginName: "@" + response.username,
                                                  bio: response.bio ?? "")
                            self?.profile = profile
                            completion(.success(profile))
                        } catch {
                            print("\(ParsingJSONServiceError.decodeError)")
                        }
                    case .failure(let error):
                        print("Network error: \(error)")
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            }
            
        }
    
