//
//  CustomCell.swift
//  lastMinute_GV
//
//  Created by Gualberto on 21/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit

class CustomCell:UITableViewCell {
    //Variable
    var nameHotel : String?
    var mainImage : UIImage?
    var cityHotel : String?
    var starsHotel : Int?
    var reviewHotel : Float?
    var seeInsideHotel : String?

    //Create one single View for each information
    var nameHotelView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false

        //Style to name Hotel
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)

        //Set background to check the correct position
        //textView.backgroundColor = UIColor.green
        return textView
    }()
    var seeInsideHotelView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        //Style to name Hotel
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)
        textView.textColor = UIColor.white

        //Set background to check the correct position
        textView.backgroundColor = hexStringToUIColor(hex: "#009FE3")
        textView.textAlignment = NSTextAlignment.center;
        
        //Corner radius bounding view
        textView.layer.cornerRadius = 15.0
        textView.layer.borderWidth = 0.1
        textView.layer.borderColor = UIColor.white.cgColor
        textView.clipsToBounds = true
       
        return textView
    }()
    
    var cityHotelView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false

        //Style to city Hotel
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)
        //Set background to check the correct position
        //textView.backgroundColor = UIColor.red
        return textView
    }()
    var starsHotelView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false

        //Style to stars Hotel
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)
        //Set background to check the correct position
        //textView.backgroundColor = UIColor.blue

        return textView
    }()
    var reviewHotelView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false

        //Style to review Hotel
        textView.font = UIFont.boldSystemFont(ofSize: 12.0)
        //Set background to check the correct position
        //textView.backgroundColor = UIColor.yellow

        return textView
    }()
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //Aspect fit of the image into  subview
        //imageView.contentMode = .scaleAspectFit
        //imageView.contentMode = .scaleToFill
        //imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainImageView)
        self.addSubview(nameHotelView)
        self.addSubview(reviewHotelView)
        self.addSubview(starsHotelView)
        self.addSubview(cityHotelView)
        self.addSubview(seeInsideHotelView)
        //Adding constrain
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameHotelView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        nameHotelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //nameHotelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //nameHotelView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameHotelView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        reviewHotelView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        reviewHotelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //cityHotelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        reviewHotelView.topAnchor.constraint(equalTo: self.nameHotelView.bottomAnchor).isActive = true
        reviewHotelView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        reviewHotelView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        cityHotelView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        cityHotelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //cityHotelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cityHotelView.topAnchor.constraint(equalTo: self.reviewHotelView.bottomAnchor).isActive = true
        cityHotelView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        starsHotelView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        //starsHotelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //cityHotelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        starsHotelView.topAnchor.constraint(equalTo: self.cityHotelView.bottomAnchor).isActive = true
        starsHotelView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        starsHotelView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        seeInsideHotelView.leftAnchor.constraint(equalTo: self.starsHotelView.rightAnchor).isActive = true
        //starsHotelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //cityHotelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seeInsideHotelView.topAnchor.constraint(equalTo: self.cityHotelView.bottomAnchor).isActive = true
        seeInsideHotelView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        seeInsideHotelView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    //Init layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        if let nameHotel = nameHotel {
            nameHotelView.text = "     \(nameHotel.uppercased())"
        }
        if let image = mainImage {
            mainImageView.image = image
        }
        if let reviewHotel = reviewHotel {
            reviewHotelView.text = "     Review: \(reviewHotel)"
        }
        if let cityHotel = cityHotel {
            cityHotelView.text = "     City: \(cityHotel)"
        }
        if let starsHotel = starsHotel {
            starsHotelView.text = "     Stars: \(starsHotel)"
        }
        if let seeInsideHotel = seeInsideHotel {
            seeInsideHotelView.text = seeInsideHotel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
