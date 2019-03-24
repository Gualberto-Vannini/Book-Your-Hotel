//
//  EndPointApi.swift
//  lastMinute_GV
//
//  Created by Gualberto on 22/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit

class EndPointApi{

    //Singleton to share EndPointApi class
    static let shared = EndPointApi()

    //Api to get all informations about all hotels.
    let hotelsInformations: String = "https://services.lastminute.com/mobile/stubs/hotels"

    
    //Insert your google api
    var authGMaps = "INSERT_YOUR_GOOGLE_API"
}
