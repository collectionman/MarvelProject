//
//  DescriptionViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit


class DescriptionViewController: UIViewController {
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    var hero: Hero?
    var comics: [ Comic? ]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heroName.text = hero?.name // carga el nombre del heroe recibido desde la tableView
        if let path = hero?.thumbnail?.path,
            let ext = hero?.thumbnail?.imageExtension,
            let url = URL( string: "\(path.replacingOccurrences(of: "http", with: "https")).\(ext)" ) {
            
            heroImage.af_setImage(withURL: url)
            // redondear imagen
            heroImage.layer.cornerRadius = 20
        }
        heroDescription.text = hero?.description // descripcion del heroe " " "
        
        guard comics != nil else {
            return
        }
        
        APIManager().getComic(by: hero?.id ?? 0) { [weak self] (comics) in
            self?.comics = comics
            self?.comicsCollectionView.reloadData()
            
        }
        
    }
    
}

extension DescriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // desencola una celda que se puede volver a utilizar ( que tiene el identificador "comicCell" )
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCollectionViewCell
        if let path = comics?[indexPath.row]?.thumbnail?.path, let ext = comics?[indexPath.row]?.thumbnail?.imageExtension,
            let url = URL(string: "\(path.replacingOccurrences(of: "http", with: "https")).\(ext)") {
            cell.comicImage.af_setImage(withURL: url)
        }
        return cell
    }
}
