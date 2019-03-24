//
//  SingleHotelVC.swift
//  lastMinute_GV
//
//  Created by Gualberto on 23/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SingleHotelVC: UIViewController {
   
    //Singleton
    static let shared = SingleHotelVC()

    @IBAction func goingBackListHotel(_ sender: Any) {
        print("ciao")
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "listHotels") as! ListHotelsVC;
        self.present(vc, animated: true, completion: nil);
    }
    @IBAction func goingToMap(_ sender: Any) {
        //Chenge View Controller
        self.performSegue(withIdentifier: "mapHotelSegue", sender: Any?.self)
    }
    
    var indexClicked: Int!
    var imageArray = [UIImage]()
    @IBOutlet weak var scrollViewImages: UIScrollView!
    @IBOutlet weak var nameHotel: UILabel!
    @IBOutlet weak var reviewsHotel: UILabel!
    @IBOutlet weak var starsHotel: UILabel!
    @IBOutlet weak var locationCityHotel: UILabel!
    @IBOutlet weak var locationAddressHotel: UILabel!
    @IBOutlet weak var mobileHotel: UILabel!
    @IBOutlet weak var emailHotel: UILabel!
    @IBOutlet weak var checkInFromHotel: UILabel!
    @IBOutlet weak var checkInToHotel: UILabel!
    @IBOutlet weak var checkOutToHotel: UILabel!
    @IBOutlet weak var checkOutFromHotel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewImages.frame = view.frame
        
        var imagesCarousel = ApiService.shared.multidimArrayImageHotel[indexClicked]
        
        let size = CGSize(width: self.scrollViewImages.frame.width, height: 200)
        
        for i in 0...(imagesCarousel.count-1){
            let url = URL(string: imagesCarousel[i])
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                imageArray.append(image!)
            }
        }
        print(imageArray)
        
        for i in 0...(imageArray.count-1){
            let imageView = UIImageView()
            imageView.image = imageArray[i].crop(to: size)
            let xPosition = self.view.frame.width * CGFloat(i)
            self.scrollViewImages.isPagingEnabled = true

            imageView.frame = CGRect(x:xPosition, y:0, width:self.scrollViewImages.frame.width, height:200)
            scrollViewImages.contentSize.width =  scrollViewImages.frame.width * CGFloat(i + 1)
            scrollViewImages.addSubview(imageView)
        }
        nameHotel.text = ApiService.shared.arrayNameHotel[indexClicked]
        reviewsHotel.text = String(ApiService.shared.arrayRatingHotel[indexClicked])
        starsHotel.text = String(ApiService.shared.arrayStarHotel[indexClicked])
        locationCityHotel.text = ApiService.shared.arrayCityHotel[indexClicked]
        locationAddressHotel.text = ApiService.shared.arrayAddressHotel[indexClicked]
        mobileHotel.text = ApiService.shared.arrayPhoneHotel[indexClicked]
        emailHotel.text = ApiService.shared.arrayEmailHotel[indexClicked]
        checkInFromHotel.text = ApiService.shared.arrayCheckInFromHotel[indexClicked]
        checkInToHotel.text = ApiService.shared.arrayCheckInToHotel[indexClicked]
        checkOutToHotel.text = ApiService.shared.arrayCheckOutToHotel[indexClicked]
        checkOutFromHotel.text = ApiService.shared.arrayCheckInFromHotel[indexClicked]
    }
    
    //singleHotelSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //Control identifier
        if (segue.identifier == "mapHotelSegue"){
            
            let mapPageVC = segue.destination as! MapPageVC
            
            mapPageVC.indexClicked = indexClicked
            
        }
    }
}
