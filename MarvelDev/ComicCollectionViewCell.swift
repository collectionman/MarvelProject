//
//  ComicCollectionViewCell.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comicImage: UIImageView!
    
    var comic: Comic? {
        didSet {
            // comicPageImage.image = UIImage( named: ( comic?.coverPageImage )! )
        }
    }
}
