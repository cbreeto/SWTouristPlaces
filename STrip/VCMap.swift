//
//  VCMap.swift
//  STrip
//
//  Created by Carlos Brito on 31/01/16.
//  Copyright © 2016 Carlos Brito. All rights reserved.
//

import UIKit
import MapKit

class VCMap: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Mapa"
        map.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
