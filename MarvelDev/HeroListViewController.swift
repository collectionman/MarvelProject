//
//  ViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import UserNotifications

class HeroListViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    // Crea un arreglo opcional de heroes
    var heroes: [ Hero? ]? = []
    
    // Tiene referenciado la tableView y la searchBar dentro del storyboard
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let center = UNUserNotificationCenter.current()
    
    var searching = false
    var searchHero: [ Hero? ]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadHeroesTable()
        notificationStart( content: setContentData( title: "My Notification", subtitle: "Local Notification", body: "This is a notification" ) )
    }
    
    private func notificationStart( content: UNMutableNotificationContent ) {
        let date = Date( timeIntervalSinceNow: 10 )
        let dateComponents = Calendar.current.dateComponents( [ .year, .month, .day, .hour, .minute, .second ],
                                                              from: date )
        let trigger = UNCalendarNotificationTrigger( dateMatching: dateComponents, repeats: false )
        let request = UNNotificationRequest( identifier: "content", content: content, trigger: trigger )
        
        center.add( request ) { ( error ) in
            if error != nil {
                print( error as Any )
            }
        }
    }
    
    private func setContentData( title: String, subtitle: String, body: String ) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifications temp"
        
        return content
    }
    
    
    
    // Cuando se hace click en una celda, la tableView detecta que celda fue tocada y envia
    // a la vista de descripcion la informacion de la celda seleccionada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // El destino sera al "DescriptionViewController"
        guard let destination = segue.destination as? DescriptionViewController else {
            return // Si el destination es nil
        }
        guard let row = tableView.indexPathForSelectedRow?.row else {
            return // Si la fila es nil
        }
        // Envia a la instancia hero que esta dentro de destination el heroe de la fila seleccionada
        destination.hero = heroes![ row ]
    }
    
    private func reloadHeroesTable() -> Void {
        APIManager().getHero() { ( retrievedHero ) in
            self.heroes = retrievedHero
            self.tableView.reloadData()
        }
    }
    
}

extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchHero?.count ?? 0 // contador de heroes encontrados
        } else {
            return heroes?.count ?? 0 // contador de todos los paises cargados
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! HeroCellTableViewCell
        if searching {
            cell.hero = searchHero?[ indexPath.row ]
        } else {
            cell.hero = heroes?[ indexPath.row ]
        }
        return cell
    }
    
}

extension HeroListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHero = ( heroes?.filter( { ($0?.name?.hasPrefix( searchText ))! } ) )! as! [Hero]
        searching = true
        tableView.reloadData()
    }
    
}

