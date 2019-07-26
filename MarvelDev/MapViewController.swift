//
//  MapViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 24/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var annotations: [ MarvelAnnotation ] = []
    private let initialLocation = CLLocation( latitude: -37.997694, longitude: -57.5494153 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( requestForTracking() ) {
            locationManager.delegate = true as? CLLocationManagerDelegate
        }
        
        loadGeolocalization()
        startLocationManager()
        setInitialLocation()
        loadAnnotations()
        
        // Core Data fetch
        let coreDataManager = CoreDataManager()
        let comicStores: [ ComicStore ] = coreDataManager.fetch()
        
        comicStores.forEach( { comicStore in
            addAnnotation( annotation: createAnnotation(title: comicStore.title, subtitle: comicStore.subtitle, coordinate: CLLocationCoordinate2D( latitude: comicStore.latitude, longitude: comicStore.longitude ) ) )
        } )
    }
    
    // Request to the user authorization for tracking his localization
    private func requestForTracking() -> Bool {
        var status = false
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
            status = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        return status
    }
    
    // Load the city localization
    private func loadGeolocalization() -> Void {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation( initialLocation, completionHandler: { ( placemarks, error ) in
            guard error == nil else { return }
            guard let thePlaceMark = placemarks?.first else { return }
            
            let alertController = UIAlertController( title: "Mar del Plata", message: thePlaceMark.locality ?? "",
                                                     preferredStyle: .alert )
            alertController.addAction( UIAlertAction( title: "Ok", style: .cancel, handler: nil ) )
            self.present( alertController, animated: true, completion: nil )
        } )
    }
    
    // Set the initial location on the map
    private func setInitialLocation() -> Void {
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  span: MKCoordinateSpan( latitudeDelta: 0.2, longitudeDelta: 0.2 ) )
        
        mapView.setRegion( coordinateRegion, animated: true )
    }
    
    // Made use of a CLLocationManager's instance
    private func startLocationManager() -> Void {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Create a MarvelAnnotation
    private func createAnnotation( title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D ) -> MarvelAnnotation {
        let marvelAnnotation = MarvelAnnotation( title: title, subtitle: subtitle, coordinate: coordinate )
        return marvelAnnotation
    }
    
    // Add the annotation to the mapView
    private func addAnnotation( annotation: MarvelAnnotation ) -> Void {
        mapView.addAnnotation( annotation )
    }
    
    // Add each annotation one by one to the mapView
    private func addAllAnnotations( annotations: [ MarvelAnnotation ] ) -> Void {
        annotations.forEach() {
            addAnnotation( annotation: $0 )
        }
    }
    
    // Load a set of random points on the map
    private func loadAnnotations() -> Void {
        annotations.append(
            createAnnotation(title: "Globant", subtitle: "Software Company",
                             coordinate: CLLocationCoordinate2D( latitude: -38.0109161, longitude:-57.5356699 )))
        
        annotations.append(
            createAnnotation(title: "Arkana Comics Store", subtitle: "Tienda de Comics",
                             coordinate: CLLocationCoordinate2D(latitude: -38.0047711, longitude: -57.549699)))
        
        annotations.append(
            createAnnotation(title: "Ozoranime", subtitle: "Tienda de Comics",
                             coordinate: CLLocationCoordinate2D(latitude: -37.9993644, longitude: -57.5473067)))
        
        annotations.append(
            createAnnotation(title: "Gallifrey", subtitle: "Tienda de Comics", coordinate: CLLocationCoordinate2D(latitude: -38.0046362, longitude: -57.5464208)))
        
        annotations.append(
            createAnnotation(title: "Rayos y Centellas", subtitle: "Tienda de Comics", coordinate: CLLocationCoordinate2D(latitude: -38.0003465, longitude: -57.5447871)))
        
        annotations.append(
            createAnnotation(title: "Factor Comic", subtitle: "FC", coordinate: CLLocationCoordinate2D(latitude: -37.9977992, longitude: -57.5556529)))
        
        addAllAnnotations( annotations: annotations )
    }
    
    @IBAction func longPressGesture(_ sender: Any) {
        guard let longPress = sender as? UILongPressGestureRecognizer else { return }
        let touchPoint = longPress.location( in: mapView )
        let newCoordinates = mapView.convert( touchPoint, toCoordinateFrom: mapView )
        let alert = UIAlertController( title: "Info", message: nil, preferredStyle: .alert )
        alert.addAction( UIAlertAction( title: "Cancel", style: .cancel, handler: nil ) )
        alert.addTextField( configurationHandler: { ( textField ) in
            textField.placeholder = "Insert the title"
        } )
        alert.addTextField( configurationHandler: { ( textField ) in
            textField.placeholder = "Insert the subtitle"
        } )
        alert.addAction( UIAlertAction( title: "OK", style: .default, handler: { [ weak self ] ( action ) in
            // self?.mapView.addAnnotation( (self?.createAnnotation( title: alert.textFields?.first?.text,
            //                                                      subtitle: alert.textFields?[ 1 ].text, coordinate: newCoordinates ))! )
            let annotation = self?.createAnnotation( title: alert.textFields?.first?.text, subtitle: alert.textFields?[ 1 ].text, coordinate: newCoordinates )
            
            // Core Data Storage ...z
            
            let coreDataManager = CoreDataManager()
            coreDataManager.saveComicStore(name: (annotation?.title)!, address: (annotation?.subtitle)!, latitude: newCoordinates.latitude, longitude: newCoordinates.longitude)
            
            self?.mapView.addAnnotation( annotation! )
            
        } ) )
        
        self.present( alert, animated: true )
        
    }
}

// Class MapViewController extends MKMapViewDelegate ...

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MarvelAnnotation else { return nil }
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView( withIdentifier: "marker" ) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView( annotation: annotation, reuseIdentifier: "marker" )
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton( type: .detailDisclosure )
        }
        return view
    }
    
    // When the info button is tapped ...
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! MarvelAnnotation
        let alertController = UIAlertController(title: annotation.title, message: annotation.subtitle,
                                                preferredStyle: .alert)
        alertController.addAction( UIAlertAction( title: "OK", style: .default ) )
        present( alertController, animated: true )
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return
        }
        self.mapView.showsUserLocation = true
    }
}
