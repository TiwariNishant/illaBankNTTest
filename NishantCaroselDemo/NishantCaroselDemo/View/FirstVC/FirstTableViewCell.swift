//
//  FirstTableViewCell.swift
//  NishantCaroselDemo
//
//  Created by webwerks on 23/04/22.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    // MARK: - Outlet declaration
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var imgName: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Cell configuration
    func configureCell(_ model: FirstModel) {
        self.selectionStyle = .none
        lableName.text = model.name
        if let name = model.imageName {
            imgName.image = UIImage(named: name)
        }
    }

}
