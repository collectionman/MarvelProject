//
//  TrailerViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 24/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TrailerViewController: AVPlayerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        playVideo()
    }
    
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "Video/trailer", ofType: "mp4") else {
            debugPrint( "video not founded" )
            return
        }
        let player = AVPlayer( url: URL(fileURLWithPath: path) ) // al AVPlayer se le pasa la URL del archivo en el inicializador
        self.player = player // al la instancia player del "TrailerViewController" se le asigna el player inicializado
        self.player?.play() // el video arranca automaticamente
    }
}
