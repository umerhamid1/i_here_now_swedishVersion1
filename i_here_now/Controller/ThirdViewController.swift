//
//  ThirdViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-21.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var meditationTimeLabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.shared.backgroundColor()
        
        
        //Chnage background of statusbar, feeels like a hack if you ask me...
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = AppColors.shared.ColorOne()
        //statusBarView.tintColor = AppColors.shared.ColorOne()
        view.addSubview(statusBarView)
        
        
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 44)) //44 never beeing used
        
        
        navBar.isTranslucent = false //Without this it's not correct color.
        navBar.barTintColor = AppColors.shared.ColorOne()
        
        // navBar.tintColor  = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBar.titleTextAttributes = textAttributes
        
        self.view.addSubview(navBar);
        
        
        let iHereText = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let navItem = UINavigationItem(title: str("Statistics"));
        
        navItem.titleView?.tintColor = UIColor.white
        
        //Done Button
        //let done = UINavigationItem(
        
        navBar.setItems([navItem], animated: false);
        
        topLabel.text = str("you_have_completed")
        bottomLabel.text = str("of_meditation")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if let listenDurationTotal = defaults.value(forKey: "listenDurationTotal") as? CGFloat{
            
            //var unit = "";
            var duration = Int(listenDurationTotal)
            
            //Debug Only
            
            
           // duration = 32
            /*
            if duration < 60{ //Seconds
                
                unit = str("seconds")
                
                if duration == 1{
                    unit = str("second")
                }
                
            }else if duration < 60*60{ //It's Minutes
                
                unit = str("minutes")
                duration = duration/60
                
                if duration == 1{
                    unit = str("minute")
                }
                
            }else if duration < 60*60*24{ //It's Hours
                
                unit = str("hours")
                duration = duration/60/60
                
                if duration == 1{
                    unit = str("hour")
                }
                
            }else{
                
                unit = str("days");
                duration = duration/60/60/24
                
                if duration == 1{
                    unit = str("day")
                }
                
            }
             */
            var days:Int = 0
            var hours:Int = 0
            var minutes:Int = 0
            var seconds:Int = 0
            
            days = duration/60/60/24 //Days
            
            duration = duration - (days*60*60*24); //Remove Days
            
  
            
            if(duration > 60*60){ //To hours
                
                hours = duration/60/60; //Minutes
                duration = duration - (hours*60*60); //Remove Hours
                
            }
            
            if(duration > 60){ //To Minutes
                
                minutes = duration/60; //Minutes
                duration = duration - (minutes*60); //Remove Days
            }
            
            if(duration > 0){ //Make Seconds
                seconds = duration;
            }
            

            var outText = "";
            if(days != 0){
                
                outText = "\(str("days")): \(days.description) \(str("hours")): \(hours.description)  \(str("minutes")): \(minutes.description) \(str("seconds")): \(seconds.description)"
                
            }else if(hours != 0){
                
                outText = "\(str("hours")): \(hours.description)  \(str("minutes")): \(minutes.description) \(str("seconds")): \(seconds.description)"
            
            }else if(minutes != 0){
                
                outText = "\(str("minutes")): \(minutes.description) \(str("seconds")): \(seconds.description)"
                
            }else{
                  outText = "\(str("seconds")): \(seconds.description)"
                
            }
            
            meditationTimeLabel.text = outText
            
        }else{
            
            meditationTimeLabel.text = 0.description
            
        }
        
        super.viewWillAppear(animated)
        
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
