import Foundation
import UIKit

final class SplashViewController: UIViewController {
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let showGallerySegueId = "showGallery"
    private let showAuthSegueId = "showAuthorization"
    
    private let oauth2Service = OAuth2Service.shared
    private let oauth2TokenStorage = OAuth2TokenStorage()
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
          showNextScreen()
      }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setNeedsStatusBarAppearanceUpdate()
        }
    
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        .lightContent
    //    }
    
    private func showNextScreen() {
        if let token = oauth2TokenStorage.token, !token.isEmpty {
            print("gallery showed")
            performSegue(withIdentifier: showGallerySegueId, sender: self)
        } else {
            performSegue(withIdentifier: showAuthSegueId, sender: self)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

//extension SplashViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
//            guard
//                let navigationController = segue.destination as? UINavigationController,
//                let viewController = navigationController.viewControllers[0] as? AuthViewController
//            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
//            viewController.delegate = self
//        } else {
//            super.prepare(for: segue, sender: sender)
//        }
//    }
//}

extension SplashViewController: AuthViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthSegueId {
            let navigationController = segue.destination as? UINavigationController
            guard let authViewController = navigationController?.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthSegueId)")
                return
            }
            
            authViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        switchToTabBarController()
    }
}

//    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
//        dismiss(animated: true) { [weak self] in
//            guard let self = self else { return }
//            self.fetchOAuthToken(code)
//        }
//    }

//    private func fetchOAuthToken(_ code: String) {
//
//        oauth2Service.fetchOAuthToken(code: code) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success:
//                self.switchToTabBarController()
//            case .failure:
//                // TODO [Sprint 11]
//                break
//            }
//        }
//    }
//}
