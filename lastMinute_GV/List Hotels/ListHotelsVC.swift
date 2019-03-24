//
//  listHotels.swift
//  lastMinute_GV
//
//  Created by Gualberto on 21/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit

//Addind struct for the info's cell
struct cellData {
    let image : UIImage?
    let nameHotel : String?
    let cityHotel : String?
    let starsHotel : Int?
    let reviewHotel : Float?
    let seeInsideHotel : String?
}

class ListHotelsVC: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    //Create Singleton
    static let shared = ListHotelsVC()
    
    @IBOutlet weak var buttonStarsOutlet: UIButton!
    @IBOutlet weak var buttonReviewOutlet: UIButton!
    @IBOutlet weak var arrowReviews: UIImageView!
    @IBOutlet weak var arrowStars: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    //============>>>>>>> TO DO  =========>>>>>>>
    //WHEN I FILTER THEN I NEED TO UPDATE INDEX ELEMENT
    //ACTUALLY ON CLICK THERE ARE OLD ELEMENTS
    
    //On click filter list and change image arrow
    @IBAction func buttonActionReview(_ sender: Any) {
        if buttonStarsOutlet.isSelected{
            buttonStarsOutlet.sendActions(for: .touchUpInside)
            //print("button selected and arrow is present")
            arrowStars.image = nil
        } else {
            //print("button is deselected and arrow is present")
            arrowStars.image = nil
        }
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                //Setting image
                let imageName = "arrow_up.png"
                let image = UIImage(named: imageName)
                arrowReviews.image = image
                
                data.sort{ $1.reviewHotel! > $0.reviewHotel!}
                self.tableView.reloadData()
                button.isSelected = false
            } else {
                // set selected
                 //Setting image
                let imageName = "arrow_down.png"
                let image = UIImage(named: imageName)
                arrowReviews.image = image
                data.sort{ $0.reviewHotel! > $1.reviewHotel!}
                self.tableView.reloadData()
                button.isSelected = true
            }
        }
    }
    @IBAction func buttonActionStars(_ sender: Any) {
       // buttonReviewOutlet.sendActions(for: .touchUpInside)
        if buttonReviewOutlet.isSelected{
            //print("button selected and arrow is present")
            buttonReviewOutlet.sendActions(for: .touchUpInside)
            arrowReviews.image = nil
        } else {
            //print("button is deselected and arrow is present")
            arrowReviews.image = nil
        }
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                //Setting image
                let imageName = "arrow_up.png"
                let image = UIImage(named: imageName)
                arrowStars.image = image
                data.sort{ $1.starsHotel! > $0.starsHotel!}
                self.tableView.reloadData()
                button.isSelected = false
            } else {
                // set selected
                //Setting image
                let imageName = "arrow_down.png"
                let image = UIImage(named: imageName)
                arrowStars.image = image
                
                data.sort{ $0.starsHotel! > $1.starsHotel!}
                self.tableView.reloadData()
                button.isSelected = true
            }
        }
    }
    
    
    var data = [cellData]()
    var indexClickedCell:Int?
    var indexPathTransport: Int?
    var sortingStars: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Clean index cell clicked
        indexClickedCell = nil
 
        var nameHotelTransport = ApiService.shared.arrayNameHotel
        var cityHotelTransport = ApiService.shared.arrayCityHotel
        var starsHotelTransport = ApiService.shared.arrayStarHotel
        var reviewHotelTransport = ApiService.shared.arrayRatingHotel
        var singleImageHotelTransport = ApiService.shared.arraySingleImageHotel
        

        //setting dataElements as empty
        data = [ ]
        
        //TO DO: be certain about counting information hotel array.
        //I should be certain that the numbers of all items is the same.
        //In case of e.g one name doeasn't exist, should be filled with "no name"
        //so all arrays about hotel informations must have same numbers!
        //Here I take the main element information cell "nameHotel"
        for i in 0...(nameHotelTransport.count-1){
            
            //Resizing image into subview:
            let size = CGSize(width: 100, height: 150)
            let imageUrlString = singleImageHotelTransport[i]
            let imageUrl = URL(string: imageUrlString)!
            let image = try? UIImage(withContentsOfUrl: imageUrl)?.crop(to: size)
            
            var insertData = cellData.init(image: image!,
                                           nameHotel: nameHotelTransport[i],
                                           cityHotel: cityHotelTransport[i],
                                           starsHotel: starsHotelTransport[i],
                                           reviewHotel: reviewHotelTransport[i],
                                           seeInsideHotel: "Vedi l'offerta")
            
            //print(insertData, "insertData")
            data.append(insertData)
        }

        // Assign custom reuse identifier and associate to CustomCellClass
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        
        //Resize of cell:
        //1.setting to fit the content
        self.tableView.rowHeight = UITableView.automaticDimension
        //2.fix to 200
        self.tableView.estimatedRowHeight = 200
        
        //Avoid empty cells into table View
        tableView.tableFooterView = UIView()
        
        //Extensions delegat to use hex
        tableView.separatorColor = UIColor.white
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell

        //Avoid color click on cell
        //of course the color is customized
        //cell.selectionStyle = .none

        //Extensions delegate to use hex
        cell.backgroundColor = hexStringToUIColor(hex: "#FEBA02")
        
        //global variable of the indexPath clicked cell
        self.indexPathTransport = indexPath.row
        
        cell.mainImage = data[indexPath.row].image
        cell.nameHotel = data[indexPath.row].nameHotel
        cell.cityHotel = data[indexPath.row].cityHotel
        cell.starsHotel = data[indexPath.row].starsHotel
        cell.reviewHotel = data[indexPath.row].reviewHotel
        cell.seeInsideHotel = data[indexPath.row].seeInsideHotel

        //mantain layout of subview during scrolling
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        self.indexClickedCell = indexPath.row
        self.performSegue(withIdentifier: "singleHotelSegue", sender: Any?.self)
        //Deselect row and color of row's selection
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //Create custom color on click of cell
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let selectionColor = UIView() as UIView
        selectionColor.layer.borderWidth = 1
        selectionColor.layer.borderColor = hexStringToUIColor(hex: "#009FE3").cgColor
        selectionColor.backgroundColor = hexStringToUIColor(hex: "#009FE3")//UIColor.blue
        cell.selectedBackgroundView = selectionColor
    }
    
    //singleHotelSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       //Control identifier
        if (segue.identifier == "singleHotelSegue"){
            let singleHotelVC = segue.destination as! SingleHotelVC
            singleHotelVC.indexClicked = indexClickedCell
        }
    }
}
