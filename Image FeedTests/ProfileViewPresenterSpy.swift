//
//  ProfileViewPresenterSpy.swift
//  Image FeedTests
//
//  Created by Yulianna on 27.02.2025.
//

import Foundation
import Image_Feed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var didUpdateProfileDetailsCalled: Bool = false
    var didUpdateAvatarCalled: Bool = false
    
    var view: ProfileViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateProfileDetails() -> Image_Feed.Profile? {
        didUpdateProfileDetailsCalled = true
        return nil
    }
    
    func didUpdateAvatar() -> URL? {
        didUpdateAvatarCalled = true
        return nil
    }
    
    func didLogout() {
    }
}
