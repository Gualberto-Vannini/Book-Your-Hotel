//
//  ViewController.swift
//  lastMinute_GV
//
//  Created by Gualberto on 21/03/19.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import Foundation
import UIKit

class SplashPageVC: UIViewController {

    //Create Singleton
    static let shared = SplashPageVC()
    
    @IBOutlet weak var buttonEnterStyle: UIButton!
    @IBOutlet weak var buttonSupport: UIButton!
    @IBOutlet weak var startLogo: UIImageView!
    
    //Button on click => enter to app
    @IBAction func buttonEnterOnClick(_ sender: Any) {
        //Chenge View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "listHotels") as! ListHotelsVC;
        self.present(vc, animated: true, completion: nil);
    }
    
    //Support Button
    @IBAction func buttonSupportOnClick(_ sender: Any) {
        let alert = UIAlertController(title: "oooooops!", message: "If there are some problems, don't hesistate to contact me to my personal phone number 0039 348 051 45 76", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    //on viewDidAppear start the main animation logo
    let animationElementLogin = 0.9
    override func viewDidAppear(_ animated: Bool) {
        
        //Immediate start to download api informations
        //Using animation's logo to reach all info necessaries to next pages
        ApiService.shared.hotelsApi {}
        
        //Logo animation
        UIView.animate(withDuration: animationElementLogin,
                       delay: 0.1,
                       options: [.curveEaseOut], //smootly animation when logo is close to stopping
                       animations: { self.startLogo.frame.origin.y += 300 },
                       completion: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide elements until there is logo animation
        buttonEnterStyle.isHidden = true
        buttonSupport.isHidden = true

        //Style to Button Login
        buttonEnterStyle.layer.cornerRadius = 20.0
        
        //Show all element in the end of animation
        delayWithSeconds(self.animationElementLogin) {
            self.buttonEnterStyle.isHidden = false
            self.buttonSupport.isHidden = false
        }
    }
    
    //Closure to offer a simple delay
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
