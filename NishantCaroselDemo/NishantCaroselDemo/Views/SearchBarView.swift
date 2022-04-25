//
//  SearchBarView.swift
//  CarouselApp
//
//  Created by Apple on 03/03/22.
//

import UIKit

class SearchBarView: UIView {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchBar.setCenteredPlaceHolder()
    }

}
