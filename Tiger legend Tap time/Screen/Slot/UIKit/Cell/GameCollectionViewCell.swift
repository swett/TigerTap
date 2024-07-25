//
//  GameCollectionViewCell.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    var backgroundImage: UIImageView!
    var tittle: UILabel!
    override init(frame: CGRect) {
                 super.init(frame: frame)
                 setupUI()
             }
             
             required init?(coder: NSCoder) {
                 super.init(coder: coder)
                 setupUI()
             }
}


extension GameCollectionViewCell {
    func setupUI() {
        backgroundImage = UIImageView().then({ image in
            contentView.addSubview(image)
            image.contentMode = .scaleToFill
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        })
        contentView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
    }
}

extension GameCollectionViewCell {
    func setupImage(with model: Symbol) {
        backgroundImage.image = UIImage(named: model.image)
    }
}

extension GameCollectionViewCell {
    static let id = GameCollectionViewCell.description()
}
