//
//  hotelPage.swift
//  lastMinute_GV
//
//  Created by Gualberto on 21/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import MapKit

class MapPageVC: UIViewController {
    //Create Singleton
    static let shared = MapPageVC()
    
    @IBAction func goBackclick(_ sender: Any) {
        self.performSegue(withIdentifier: "goBackSinglePage", sender: Any?.self)
    }
    
    //Label recap
    @IBOutlet weak var nameHotelRecap: UILabel!
    @IBOutlet weak var addressHotelRecap: UILabel!
    @IBOutlet weak var cityHotelRecap: UILabel!
   
    var indexClicked: Int!
    var mapView:GMSMapView?

    var latitudeTransportToMap:Double!
    var longitudeTransportToMap:Double!
    var nameHotelTransportToMap:String!
    var starsHotelTransportToMap:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        //call google key api
        GMSServices.provideAPIKey(EndPointApi.shared.authGMaps)
        
        //Adding information labels
        nameHotelRecap.text = ApiService.shared.arrayNameHotel[indexClicked]
        addressHotelRecap.text = ApiService.shared.arrayAddressHotel[indexClicked]
        cityHotelRecap.text = ApiService.shared.arrayCityHotel[indexClicked]

        //Call data
        self.latitudeTransportToMap = ApiService.shared.arrayLatitudeHotel[indexClicked]
        self.longitudeTransportToMap = ApiService.shared.arrayLongitudeHotel[indexClicked]
        self.nameHotelTransportToMap = ApiService.shared.arrayNameHotel[indexClicked]
        self.starsHotelTransportToMap = ApiService.shared.arrayStarHotel[indexClicked]
        
        //Create map
        //TODO ===> Handling if lat, long or baloon informations doesn't exist
        //TODO ===> Responsive
        mapView = GMSMapView.map(withFrame: CGRect(x: 0.0,
                                                   y: 0.0,
                                                   width: 414,
                                                   height: 719), 
                                 camera: GMSCameraPosition.camera(withLatitude: latitudeTransportToMap,
                                                                  longitude: longitudeTransportToMap,
                                                                  zoom: 18))
        mapView?.center =  CGPoint(x:207,y:550)
        
        //Baloon Editable as much UX/UI want
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitudeTransportToMap,
                                                 longitude: longitudeTransportToMap)
        marker.title =  self.nameHotelTransportToMap
        marker.snippet = "STARS : \(String(self.starsHotelTransportToMap))"
        marker.map = mapView
        
        //Adding view map
        self.view.addSubview(mapView!)
    }
    
    //Segue to passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //Control identifier
        if (segue.identifier == "goBackSinglePage"){
            let singleHotelVC = segue.destination as! SingleHotelVC
            singleHotelVC.indexClicked = indexClicked
        }
    }
}
