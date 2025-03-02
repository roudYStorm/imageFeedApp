//
//  ProfileViewTests.swift
//  Image FeedTests
//
//  Created by Yulianna on 27.02.2025.
//

import Foundation
import XCTest
@testable import Image_Feed

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenterSpy = ProfileViewPresenterSpy()
        profileViewController.presenter = profileViewPresenterSpy
        profileViewPresenterSpy.view = profileViewController
        
        //when
        _ = profileViewController.view
        
        //then
        XCTAssertTrue(profileViewPresenterSpy.viewDidLoadCalled)
    }
    
    
    
    func testViewControllerCallsDidUpdateAvatar() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenterSpy = ProfileViewPresenterSpy()
        profileViewController.presenter = profileViewPresenterSpy
        profileViewPresenterSpy.view = profileViewController
        
        //when
        profileViewController.updateAvatar()
        
        //then
        XCTAssertTrue(profileViewPresenterSpy.didUpdateAvatarCalled)
    }
}
