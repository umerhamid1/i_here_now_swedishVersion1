//
//  CustomTabBarController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-10.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let modelName = UIDevice.modelName
        
       // view.backgroundColor = AppColors.shared.ColorOne()
        
        //Icon Color
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = AppColors.shared.ColorOne()
        self.tabBar.isTranslucent = false
        
        //self.tabBarController?.tabBar.tintColor = AppColors.shared.ColorOne()
        //self.tabBarController?.tabBar.barTintColor = AppColors.shared.ColorOne()
        
        //Set Title Of Item Bars
        
        /*
        if BuildConfig.currentLanguage == Language.Swe{
        
            self.tabBar.items?[0].title = "Kompass"
            self.tabBar.items?[1].title = "Meditation"
            
        }
        
        if BuildConfig.currentLanguage == Language.Eng{
            
            self.tabBar.items?[0].title = "Compass"
            self.tabBar.items?[1].title = "Meditation"
            
        }
        */
        self.tabBar.items?[0].title = str("Compass")
        self.tabBar.items?[1].title = str("Meditation")
        self.tabBar.items?[2].title = str("Statistics")
        

        

        //print(modelName)
        if modelName == "iPhone 5s" || modelName == "iPhone SE"{
        //if modelName == "Simulator iPhone 5s" || modelName == "iPhone SE"{
            self.viewControllers?.remove(at: 0)
        }
        
        
        self.selectedIndex = 0
        // Do any additional setup after loading the view.
    
    UITabBar.appearance().unselectedItemTintColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.6)
        
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
