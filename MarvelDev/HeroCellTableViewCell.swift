//
//  HeroCellTableViewCell.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import AlamofireImage

class HeroCellTableViewCell: UITableViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var hero: Hero? {
        didSet {
            nameLabel.text = hero?.name
            if let path = hero?.thumbnail?.path,
                let ext = hero?.thumbnail?.imageExtension,
                let url = URL( string: "\(path.replacingOccurrences(of: "http", with: "https")).\(ext)" ) {
                
                heroImage.af_setImage( withURL: url )
                heroImage.layer.cornerRadius = heroImage.bounds.size.width / 2
            }
        }
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        heroImage.image = nil
    }
}
