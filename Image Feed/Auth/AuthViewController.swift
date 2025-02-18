//
//  AuthViewController.swift
//  Image Feed
//
//  Created by Yulianna on 22.11.2024.
//
import UIKit
/*final class AuthViewController: UIViewController {
 let showWebViewSegueIdentifier = "ShowWebView"
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 configureBackButton()
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == showWebViewSegueIdentifier {
 guard
 let webViewViewController = segue.destination as? WebViewViewController
 else {
 assertionFailure("Failed to prepare for \(showWebViewSegueIdentifier)")
 return
 }
 webViewViewController.delegate = self
 } else {
 super.prepare(for: segue, sender: sender)
 }
 }
 
 private func configureBackButton() {
 navigationController?.navigationBar.backIndicatorImage = UIImage(resource: .navBackButton)
 navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(resource: .navBackButton)
 navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 navigationItem.backBarButtonItem?.tintColor = UIColor(resource: .ypBlack)
 }
 }
 
 extension AuthViewController: WebViewViewControllerDelegate {
 func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
 OAuth2Service.shared.fetchOAuthToken(code: code) { [weak self] result in
 guard let self = self else { return }
 self.navigationController?.popViewController(animated: true)
 
 switch result {
 case .success(let bearerToken):
 self.oauth2TokenStorage.token = bearerToken
 delegate?.didAuthenticate(self)
 case .failure(let error):
 print("failure with error - \(error)")
 }
 }
 }
 
 func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
 vc.dismiss(animated: true)
 }
 }
 */



import UIKit

protocol AuthViewControllerDelegate: NSObject {
    func didAuthenticate(_ vc: AuthViewController)
}

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared
    private let oauth2TokenStorage = OAuth2TokenStorage()
    weak var delegate: AuthViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension AuthViewController: WebViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
            
            switch result {
            case .success(let bearerToken):
                self.oauth2TokenStorage.token = bearerToken
                delegate?.didAuthenticate(self)
            case .failure(let error):
                print("failure with error - \(error)")
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true, completion: nil)
    }
}
