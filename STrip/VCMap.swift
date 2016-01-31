//
//  VCMap.swift
//  STrip
//
//  Created by Carlos Brito on 31/01/16.
//  Copyright © 2016 Carlos Brito. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class VCMap: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var map: MKMapView!
    
    //Variables de localización del usuario
    private let manager = CLLocationManager()
    private var locationPrev = CLLocation()
    private var first = true
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Mapa"
        //map.delegate = self
        manager.delegate = self
        
        //Configuración de ubicación del usuario
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.distanceFilter = 50.0
        
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            map.showsUserLocation = true
           // manager.startUpdatingHeading()
        }
        else {
            manager.stopUpdatingLocation()
            map.showsUserLocation = false
           // manager.stopUpdatingHeading()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if first == true {
            locationPrev = locations[0]
        }
        
        let span = MKCoordinateSpanMake(0.010, 0.010)
        var dot = CLLocationCoordinate2D()
        
        dot.latitude = manager.location!.coordinate.latitude
        dot.longitude = manager.location!.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dot.latitude, longitude: dot.longitude), span: span)
        
        //distance
        let distance = locations[0].distanceFromLocation(locationPrev)
        locationPrev = locations[0]
        
        //pin
        /*
        let pin = MKPointAnnotation()
        pin.title = "Lat: \(manager.location!.coordinate.latitude) Long: \(manager.location!.coordinate.longitude))"
        pin.subtitle = "Distance: \(distance)"
        pin.coordinate = dot
        print("\(manager.location!.coordinate.latitude)")
        print("\(distance)")
        */
        
        
        
        let pin = MKPointAnnotation()
        pin.title = "Lat: \(manager.location!.coordinate.latitude) Long: \(manager.location!.coordinate.longitude))"
        pin.subtitle = "Distance: \(distance)"
        pin.coordinate = dot
        print("\(manager.location!.coordinate.latitude)")
        print("\(distance)")
        
        
        if first == true {
            first = false
            pin.title = "Punto de partida"
            pin.subtitle = ""
            
            
            map.addAnnotation(pin)
        }
        
        
        map.setRegion(region, animated: true)
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        let alert = UIAlertController(title: "Error", message: "Error\(error.code)", preferredStyle: .Alert)
        let actionOk = UIAlertAction(title: "Ok", style: .Default, handler: {
            action in
            //..
        })
        alert.addAction(actionOk)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //compass reading
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        // norteMgn.text = "\(newHeading.magneticHeading)"
        // norteGeo.text = "\(newHeading.trueHeading)"
    }

    
    
    
    @IBAction func actionGuardarLugar() {
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
