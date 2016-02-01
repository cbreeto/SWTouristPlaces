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
    @IBOutlet weak var newWordField: UITextField!
    
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var fieldDescripcion: UITextField!
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var buttonGuardar: UIButton!
    
    //Variables de localización del usuario
    private let manager = CLLocationManager()
    private var locationPrev = CLLocation()
    private var first = true
    private var mLugar = ""
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
    
    override func viewWillAppear(animated: Bool) {
        self.disappearFields()
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
        var lugar = getAddress()
        print("==en actionGuardar === \(lugar)")
        if lugar == "" {
            self.appearFields()
            
        }
        
     
    }
    
    func getAddress()->String{
        var lugar = ""
        
        //Obteniendo la dirección
        CLGeocoder().reverseGeocodeLocation(locationPrev) { (myPlacements, mError) -> Void in
            
            if mError != nil {
                //Error
            }
            if let myPlacement = myPlacements?.first {
                _ = "\(myPlacement.locality)  -  \(myPlacement.country)  - \(myPlacement.postalCode)"
               
                let mP = myPlacement.areasOfInterest
                if let mP = myPlacement.areasOfInterest {
                    print(mP)
                }
                else {
                   //self.setAddress()
                    print("====interest : \(mP)")
                }
                
            }
            
            
        }
        print ("=== lugar:  \(lugar) ==")
        return lugar
    }
    
    func setAddress(){
        //Preguntar al usuario por el nombre del lugar
        let newWordPrompt = UIAlertController(title: "Agregar Nuevo", message: "¿Cómo se llama éste lugar?", preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "Guardar", style: UIAlertActionStyle.Default, handler: inputLugar))
        presentViewController(newWordPrompt, animated: true, completion: nil)
    }
    
    func inputLugar(alert: UIAlertAction!){
        mLugar = self.newWordField.text!
    }
    func addTextField(textField: UITextField!){
        textField.placeholder = "Lugar"
        self.newWordField = textField
    }

    
    func disappearFields() {
        labelNombre.text = ""
        labelDescripcion.text = ""
        fieldName.hidden = true
        fieldDescripcion.hidden = true
        buttonGuardar.hidden = true
    }
    
    
    func appearFields() {
        labelNombre.text = "Nombre"
        labelDescripcion.text = "Descripción"
        fieldName.hidden = false
        fieldDescripcion.hidden = false
        buttonGuardar.hidden = false
    }
    
   

}
