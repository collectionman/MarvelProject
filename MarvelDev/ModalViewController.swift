//
//  ModalViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 26/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    @IBOutlet weak var coverPageImage: UIImageView!
    @IBOutlet weak var comicDescription: UILabel!
    
    var comic: Comic?
    
    override func viewDidLoad() {
        coverPageImage.image = UIImage.init( named: comic?.thumbnail?.asString() ?? "" )
        super.viewDidLoad()
    }
}
