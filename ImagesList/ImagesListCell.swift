//
//  ImagesListCell.swift
//  imageFeedApp
//
//  Created by Yulianna on 02.04.2024.
//
import UIKit
final class ImagesListCell: UITableViewCell {
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var Button: UIButton!
    @IBOutlet var dateLabel: UILabel!
    static let reuseIdentifier = "ImagesListCell" 
} 
