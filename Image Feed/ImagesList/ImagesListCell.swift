import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!

    static let reuseIdentifier = "ImagesListCell" // создаем идентификатор для переиспользования ячейки
    let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradient()
    }
    
    // MARK: - Private
    private func configureGradient() {
        
        let firstColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 0.3)
        let secondColor = firstColor
        let clearColor = UIColor.clear
        
        gradientLayer.frame = dateLabel.bounds // устанавливаем размер подложки как и у UILabel
        gradientLayer.bounds.size.height = 31
        gradientLayer.bounds.size.width = bounds.width
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor, clearColor.cgColor] // задаем цвпета градиента
        gradientLayer.locations = [0.0, 0.2, 1.0] // выставляем стоп градиента на 20%
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        dateLabel.layer.insertSublayer(gradientLayer, at: 0)
    }
}
