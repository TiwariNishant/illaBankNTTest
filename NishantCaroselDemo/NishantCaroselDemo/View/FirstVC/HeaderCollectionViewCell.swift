//
//  HeaderCollectionViewCell.swift
//  NishantCaroselDemo
//
//  Created by webwerks on 23/04/22.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet declaration
    @IBOutlet weak var headerImage: UIImageView!
    
    // MARK: - Configure cell class
    func configureCell(_ model: FirstModel) {
        if let name = model.imageUrl {
            let url = URL(string: name)
            ImageLoader.downloadImage(url: url!, completion: { [weak self] (image,nil) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.headerImage.image = image
                }
            })
        }
    }
}
