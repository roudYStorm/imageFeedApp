//
//  ImagesListViewPresenterSpy.swift
//  Image FeedTests
//
//  Created by Yulianna on 02.03.2025.
//

@testable import Image_Feed
import Foundation

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    func tapLike(for photo: Photo, completion: @escaping (Result<Bool, any Error>) -> Void) {}
    
    var viewDidLoadCalled: Bool = false
    
    var imagesListService: ImagesListServiceProtocol?
    
    var view: ImagesListViewControllerProtocol?
    
    var photos: [Image_Feed.Photo] = []
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateTableViewAnimated() {
    }
    
    func loadImages() {
    }
}
