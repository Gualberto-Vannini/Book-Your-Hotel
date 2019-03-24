//
//  apiServices.swift
//  lastMinute_GV
//
//  Created by Gualberto on 21/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ApiService {

    //Create Singleton 
    static let shared = ApiService()
    
    //Global variables:
    var arrayNameHotel = [String]()
    var arrayStarHotel = [Int]()
    var arrayRatingHotel = [Float]()
    var arrayLongitudeHotel = [Double]()
    var arrayLatitudeHotel = [Double]()
    var arrayCityHotel = [String]()
    var arrayAddressHotel = [String]()
    var multidimArrayImageHotel = [[String]]()
    var arraySingleImageHotel = [String]()
    var arrayEmailHotel = [String]()
    var arrayPhoneHotel = [String]()
    var arrayCheckInFromHotel = [String]()
    var arrayCheckInToHotel = [String]()
    var arrayCheckOutFromHotel = [String]()
    var arrayCheckOutToHotel = [String]()

    func hotelsApi( completed: @escaping ()-> ()){

        //Import end point api
        let importApi = EndPointApi.shared.hotelsInformations
        
        Alamofire.request(importApi, method: .get,encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET")
                    print(response.result.error!)
                    return
                }
                //Simple check response API
                //print(response.result.value)
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get object as JSON from API")
                    print("TO DO: handle error")
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                // get list of hotels
                guard let getHotelsList = json["hotels"] as? NSArray else {
                    print("TO DO: handle error")
                    return
                }
                // get numbers of item into array
                guard let nameHotelCount = getHotelsList.count as? Int else {
                    print("TO DO: handle error")
                    return
                }
                //Checking count items
                //print(nameHotelCount, "count")
                
                //Get hotels'name
                for i in 0...(nameHotelCount-1){
                    guard let nameHotels = getHotelsList[i] as? [String: Any] else {
                        print("TO DO: handle error")
                        return
                    }
                    let name = nameHotels["name"] as! String
                    let star = nameHotels["stars"] as! Int
                    let rating =  nameHotels["userRating"] as! NSNumber
                    self.arrayNameHotel.append(name)
                    self.arrayStarHotel.append(star)
                    self.arrayRatingHotel.append(Float(truncating: rating))
                    
                    //for location:
                    //TO DO -> handling no result
                    let location =  nameHotels["location"] as! [String:Any]
                    let longitude = location["longitude"] as! Double
                    let latitude = location["latitude"] as! Double
                    let city = location["city"] as! String
                    let adddress = location["address"] as! String
                    self.arrayLongitudeHotel.append(longitude)
                    self.arrayLatitudeHotel.append(latitude)
                    self.arrayCityHotel.append(city)
                    self.arrayAddressHotel.append(adddress)
                    
                    //Get Mail and Teleph
                    //TO DO -> handling no result
                    let contact =  nameHotels["contact"] as! [String:Any]
                    let phoneNumber = contact["phoneNumber"] as! String
                    let email = contact["email"] as! String
                    self.arrayPhoneHotel.append(phoneNumber)
                    self.arrayEmailHotel.append(email)
                    
                    //Get checkIn
                    //TO DO -> handling no result
                    let checkIn =  nameHotels["checkIn"] as! [String:Any]
                    let checkInFrom = checkIn["from"] as! String
                    let checkInTo = checkIn["to"] as! String
                    self.arrayCheckInFromHotel.append(checkInFrom)
                    self.arrayCheckInToHotel.append(checkInTo)
                   
                    //Get checkOut
                    //TO DO -> handling no result
                    let checkOut =  nameHotels["checkOut"] as! [String:Any]
                    let checkOutFrom = checkOut["from"] as! String
                    let checkOutTo = checkOut["to"] as! String
                    self.arrayCheckOutFromHotel.append(checkOutFrom)
                    self.arrayCheckOutToHotel.append(checkOutTo)
                    
                    //For Images:
                    //TO DO -> handling no result
                    //Multidimensional array to get all immages
                    let images =  nameHotels["images"] as! [String]
                    //All immage to create corousel to SingleHotelVC
                    self.multidimArrayImageHotel.append(images)
                    
                    // Check if at least one image exist else append
                    //noImage.jpeg to have image always into the ListHotelsVC
                    guard let getImageSingle = images[0] as? String else {
                        self.arraySingleImageHotel.append("noimage.jpeg")
                        return
                    }
                    
                    //I noticed that same immage are for different hotel.
                    //Control and change immage with other if available
                    if self.arraySingleImageHotel.contains(images[0]) {
                        if images.count > 1{
                        self.arraySingleImageHotel.append(images[1])
                        } else{
                            self.arraySingleImageHotel.append(images[0])
                        }
                    } else {
                        self.arraySingleImageHotel.append(images[0])
                    }
                    
                }
                //Checking hotels information arrays
                //print(self.arrayNameHotel, "Array of all hotels' naming")
                //print(self.arrayStarHotel, "Array of all hotels' star")
                //print(self.arrayRatingHotel, "Array of all hotels' rating")
                //print(self.arrayLongitudeHotel, "Array of all hotels' longitude")
                //print(self.arrayLatitudeHotel, "Array of all hotels' latitude")
                //print(self.arrayCityHotel, "Array of all hotels' city")
                //print(self.arrayAddressHotel, "Array of all hotels' address")
                //print(self.arrayImageHotel, "Array of all hotels' image")
        }
    }
}
