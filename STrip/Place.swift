//
//  Place.swift
//  CPlaces
//
//  Created by Carlos Brito on 30/01/16.
//  Copyright © 2016 Carlos Brito. All rights reserved.
//

import Foundation


class Place {
    
    var name : String
    var latitud : Double
    var longitud : Double
    
    init (name: String, latitud: Double, longitud: Double) {
        self.name = name
        self.latitud = latitud
        self.longitud = longitud
    }
    
}

class Places {
    
    var details = [Place (name: "Auditorio Nacional", latitud: 19.424772, longitud: -99.194942), Place (name: "Feria de Chapultepec", latitud: 19.416564, longitud: -99.195734), Place (name: "Angel de la Independencia", latitud: 19.427099, longitud: -99.167653)]
    
}