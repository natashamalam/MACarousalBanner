//
//  CarousalViewCell.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/11.
//

import UIKit

class MACarousalViewCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(imageView)
        addLayoutConstraints()
    }
    
    convenience init(_ image: UIImage) {
        self.init(frame: .zero)
        imageView.image = image
    }
    
    func addLayoutConstraints() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
