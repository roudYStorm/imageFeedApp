import Foundation
import SwiftKeychainWrapper
final class OAuth2TokenStorage {
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: "AuthToken")
        }
        set {
            guard let token = newValue else {
                print("Не находит токен")
                return
            }
            let isSuccess = KeychainWrapper.standard.set(token,forKey: "AuthToken")
            guard isSuccess else {
                print ("Ошибка при сохранении токена")
                return
            }
        }
    }
    func removeToken() {
           KeychainWrapper.standard.removeObject(forKey: "Auth token")
       }
}
