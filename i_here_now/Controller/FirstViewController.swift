//
//  FirstViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-09.
//  Copyright © 2018 Livheim AB. All rights reserved.
//



extension String {
    func localized(lang:String) -> String? {
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        
        return nil;
    }
    
    
    
    
}

import UIKit
import UserNotifications

class FirstViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {

    var dotArray:[CGFloat] = []
    var labelArray:[String] = []
    
    var iHereNowLabel:UILabel!
    
    var lc:NSLayoutConstraint!
    var chartWrapper:UIView!
    var spiderWeb:SpiderWeb!
    
    var textField:UITextField!
    var sliderWrapper:CustomSlideer!
    var saveBtn:UIButton!
    
    var currentEditID = 0
    
    var currentReminderID = 0
    
    let step:Float=10 // If you want UISlider to snap to steps by 10
    
    let defaults = UserDefaults.standard
    
    var reminderView:ReminderView!
    var backdrop:UIView!
    
    let lcInitState:CGFloat = 90
    
    var lifecompassLogoView:UILabel!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        

        
        
        
        
        /*
        print("Did load")
        if let reminderDateTime = self.defaults.value(forKey: "reminderDateTime") as? Date{
            print(reminderDateTime)
        }
        
        print(self.defaults.value(forKey: "reminderDateTime"))
        */
        
        //Set Background Color
        //1f99a9
        //let backgroundColor = UIColor(displayP3Red: 31/255, green: 153/255, blue: 169/255, alpha: 1)
        
        view.backgroundColor = AppColors.shared.backgroundColor()
        
        
        //Debug Only
        if let listenDurationTotal = defaults.value(forKey: "listenDurationTotal") as? CGFloat{
            print("We have listen \(listenDurationTotal) seconds")
        }
        
        // set UNUserNotificationCenter delegate to self
        UNUserNotificationCenter.current().delegate = self
        
        //Remove data for debug Only
        //defaults.removeObject(forKey: "compassDots")
        
        /*
         NotificationCenter.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
         
         })
         */
        
        
        //Ask Use If it's OK to Send Notification
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        
        
        initCompassDotArray()
        initCompassLabelArray()
        
        
        //creating the notification content
        //
        
        
        
        //content.categoryIdentifier =
        
        //adding title, subtitle, body and badge
        /*
         
         let content = UNMutableNotificationContent()
         
         content.title = "Reminder"
         //content.subtitle = "Remember this"
         content.body = "Feel the present in the shower"
         //content.badge = 1
         
         //getting the notification trigger
         //it will be called after 5 seconds
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
         
         //getting the notification request
         let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
         
         //adding the notification to notification center
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         */
        
        // Create a content
        
        //Debug Only
        
        
        /*
         
         //Notification #Notification
        let notificationTitle = "iHereStats"
        var notificationBody = "";
        
        if let listenDurationTotal = defaults.value(forKey: "listenDurationTotal") as? CGFloat{
            notificationBody = "We have listen \(listenDurationTotal) seconds"
        }
        
        let content = UNMutableNotificationContent.init()
        content.title = NSString.localizedUserNotificationString(forKey: notificationTitle, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: notificationBody, arguments: nil)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "categoryIdentifier"
 
        // Create a unique identifier for each notification
        let identifier = UUID.init().uuidString
        
        // Notification trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        
        // Notification request
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        // Add request
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        */
        
        
        //Save And Get User Data
        //let defaults = UserDefaults.standard
        //defaults.set(25, forKey: "Age")
        //print(defaults.value(forKey: "Age") as! Int)
        
        
        
        /*
         print("welcome".localized(lang: "en") )
         print("Next")
         print(NSLocalizedString("welcome", comment: ""))
         print("End")
         */
        
        //let greetingsMessage = NSLocalizedString("tust", comment: "")
        //print(greetingsMessage)
        
        /*
        iHereNowLabel = UILabel();
        iHereNowLabel.translatesAutoresizingMaskIntoConstraints = false
        iHereNowLabel.textColor = UIColor.white
        iHereNowLabel.font = iHereNowLabel.font.withSize(24)
        iHereNowLabel.textAlignment = .center
        
        iHereNowLabel.text = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        
        view.addSubview(iHereNowLabel)
        

        lc = NSLayoutConstraint(item: iHereNowLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: lcInitState)
        
        let lc2 = NSLayoutConstraint(item: iHereNowLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)

        let lc3 = NSLayoutConstraint(item: iHereNowLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        NSLayoutConstraint.activate([lc,lc2,lc3])
        */

        //--------------------------------------------------
        // Chart View
        //--------------------------------------------------
        chartWrapper = UIView()
        
        //chartWrapper.backgroundColor = UIColor.green;
        chartWrapper.translatesAutoresizingMaskIntoConstraints = false
        chartWrapper.backgroundColor = UIColor.clear
        
        //chartWrapper.clipsToBounds = true
        
        view.addSubview(chartWrapper)
        
 
        
        
        //let chart_1 = ChartView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        //let chart_1 = ChartView()
        
        //chart_1.counterColor = UIColor.blue
        //chart_1.degree
        
        //chart_1.backgroundColor = UIColor.red
        
        
        //self.view.addSubview(chart_1)
        
        
        lc = NSLayoutConstraint(item: chartWrapper, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: lcInitState)
        
        let c2 = NSLayoutConstraint(item: chartWrapper, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        
        let c3 = NSLayoutConstraint(item: chartWrapper, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let c4 = NSLayoutConstraint(item: chartWrapper, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280)
        
        let c5 = NSLayoutConstraint(item: chartWrapper, attribute: .height, relatedBy: .equal, toItem: chartWrapper, attribute: .width, multiplier: 1, constant: 0)
        
        let c6 = NSLayoutConstraint(item: chartWrapper, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        c4.priority = .required
        c6.priority = .required
        
        c2.priority = .defaultHigh
        c3.priority = .defaultHigh
        
        
        chartWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([lc,c2,c3,c4,c5,c6])
        
        //Need this so we get current Bounds Width and Height
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        /*
         UIView.animate(withDuration: 4.5, animations: {
         c1.constant = 250 // Some value
         self.view.layoutIfNeeded()
         })
         */
        //Delay Something 5 seconds
        
        /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         
         self.c1.constant = -100 // Some value
         UIView.animate(withDuration: 1, animations: {
         
         self.view.layoutIfNeeded()
         })
         
         
         }
         */
        
        //Add Right Top Chart View
        createChartPart(view: chartWrapper, startAngle: 4.71, endAngle: 0.0, color: AppColors.shared.ColorTwo())
        createChartPart(view: chartWrapper, startAngle: 1.57, endAngle: 3.14, color: AppColors.shared.ColorThree())
        createChartPart(view: chartWrapper, startAngle: 3.14, endAngle: 4.71, color: AppColors.shared.ColorFour())
        createChartPart(view: chartWrapper, startAngle: 0.0, endAngle: 1.57, color: AppColors.shared.ColorFive())
        
        //Create Thin Lines
        createChartThinLines(view: chartWrapper)
        
        //Create Thick Lines
        createChartThickLines(view: chartWrapper)
        
        //#old
        //initRotateLabels()
    
        
        //Add Center Logo
        var logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.backgroundColor = UIColor.clear
        
        let logoImage = UIImage(imageLiteralResourceName: "logo_small_green").withRenderingMode(.alwaysTemplate)
        
        logo.image = logoImage
        logo.tintColor = UIColor.white
        
        chartWrapper.addSubview(logo)
        
        NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: chartWrapper, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: chartWrapper, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        
        
        //Spider Web
        createSpiderWeb(view: chartWrapper)
    
        //Add Soider dots
        initSpiderWebDots();
        
        
        initRotateLabels()
        //
        //createBell(id:1, view: chartWrapper, degrees: 45)
        
        //Init Bells
        initBells()
        
        //createRotateLabel(id:i, view: chartWrapper, text: labelArray[i-1], angle: anglesArray[i-1], degrees: degreesArray[i-1], aligment: aligmentArray[i-1])
        
        //Debug
        
        createSubjectLabel(text: str("Health"), view: chartWrapper, side:3)
        createSubjectLabel(text: str("Work / Employment"), view: chartWrapper, side:4)
        createSubjectLabel(text: str("Leisure"), view: chartWrapper, side:1)
        createSubjectLabel(text: str("Relationships"), view: chartWrapper, side:2)
        
        
        
        //Add The Logo Image View for Lifecompass
        lifecompassLogoView = UILabel()
        
        lifecompassLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        lifecompassLogoView.textColor = UIColor.white
        lifecompassLogoView.text = str("Life compass");
        lifecompassLogoView.textAlignment = .center
        lifecompassLogoView.font = lifecompassLogoView.font.withSize(22)
        
        lifecompassLogoView.backgroundColor = UIColor.clear
        
        self.view.addSubview(lifecompassLogoView)
        
        
        NSLayoutConstraint(item: lifecompassLogoView, attribute: .centerX, relatedBy: .equal, toItem: chartWrapper, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: lifecompassLogoView, attribute: .top, relatedBy: .equal, toItem: chartWrapper, attribute: .bottom, multiplier: 1, constant: 100).isActive = true
        
        NSLayoutConstraint(item: lifecompassLogoView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 240).isActive = true
        
        NSLayoutConstraint(item: lifecompassLogoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60).isActive = true
        
        
        /*
         var dotArray:[CGFloat] = []
         
         dotArray.insert(0.2, at: 0)
         dotArray.insert(0.6, at: 1)
         */
        
        
        
        //let defaults = UserDefaults.standard
        //defaults.set(dotArray, forKey: "compassDots")
        //print(defaults.value(forKey: "Age") as! Int)
        
        // if var dotArray = defaults.value(forKey: "compassDots") as? [CGFloat]{
        //  self.spiderWeb.dot_1_value = dotArray[0]
        //   print(dotArray[0])
        //}
        
        
        
        //Show Edit Window Below
        
        
        
        
        /*
         let mySlider = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
         mySlider.minimumValue = 0
         mySlider.maximumValue = 100
         mySlider.isContinuous = true
         mySlider.tintColor = UIColor.green
         mySlider.addTarget(self, action: #selector(FirstViewController.sliderValueDidChange(_:)), for: .valueChanged)
         
         self.view.addSubview(mySlider)
         */
        
        //createEditElements(id:0)
        //textFieldTapped
        
        /*
         //Create Rotate Labels Left Top
         createRotateLabel(view: chartWrapper, angle: 73, label: "Test och bad", aligment:.right, xPos: 46, yPos: 0)
         
         createRotateLabel(view: chartWrapper, angle: 45, label: "Cool", aligment:.right, xPos: 6, yPos: 20)
         
         createRotateLabel(view: chartWrapper, angle: 15, label: "Another one here", aligment:.right, xPos: -25, yPos: 70)
         
         //Create Rotate Labels Left Bottom
         createRotateLabel(view: chartWrapper, angle: -15, label: "Test hej hej", aligment:.right, xPos: -36, yPos: 130)
         
         createRotateLabel(view: chartWrapper, angle: -45, label: "Skola", aligment:.right, xPos: -10, yPos: 180)
         
         createRotateLabel(view: chartWrapper, angle: -73, label: "Another one here soo long", aligment:.right, xPos: 46, yPos: 200)
         
         //Create Rotate Lavels Right Top
         createRotateLabel(view: chartWrapper, angle: -73, label: "Test och bad", aligment:.left, xPos: 100, yPos: 0)
         
         createRotateLabel(view: chartWrapper, angle: -45, label: "Cool", aligment:.left, xPos: 145, yPos: 20)
         
         createRotateLabel(view: chartWrapper, angle: -15, label: "Another one here", aligment:.left, xPos: 180, yPos: 70)
         
         //Create Rotate Labels Right Bottom
         createRotateLabel(view: chartWrapper, angle: 15, label: "What is this", aligment:.left, xPos: 180, yPos: 130)
         
         createRotateLabel(view: chartWrapper, angle: 45, label: "Cool Cool", aligment:.left, xPos: 145, yPos: 170)
         
         createRotateLabel(view: chartWrapper, angle: 73, label: "I am making this one now", aligment:.left, xPos: 100, yPos: 200)
         
         */
        
        

        
        //let customSlider = CustomSlideer(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        //view.addSubview(customSlider)
        
       // let customView = Custom
        
      //  Bundle.main.loadNibNamed("CustomSlider", owner: self, options: self)
        
        //let customView = CustomSlideer.loadNib() as! CustomSlideer
        //customView.frame = CGRect(x: 0, y: 0, width: 200, height: 200))
        //view.addSubview(customView)
        
        /*
        let customView = CustomSlideer()
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.backgroundColor = UIColor.red
        
        view.addSubview(customView)
        
        
        NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200).isActive = true
        
        NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        
        NSLayoutConstraint(item: customView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: customView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        */
        
        
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
        let navItem = UINavigationItem(title: iHereText);
        
        navItem.titleView?.tintColor = UIColor.white
        
        //Done Button
        //let done = UINavigationItem(
        
        navBar.setItems([navItem], animated: false);
     
        
        //Add Left Button
        var questionButton:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain,target:self, action:#selector(FirstViewController.questionButtonClicked(sender:)))
        
        questionButton.image = UIImage(named: "question-mark")?.withRenderingMode(.alwaysTemplate)
        questionButton.tintColor = UIColor.white
        
        navBar.items?.first?.leftBarButtonItem = questionButton
        
        //Add Right Button
        var informationButton:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain,target:self, action:#selector(FirstViewController.informationButtonClicked(sender:)))
        
        informationButton.image = UIImage(named: "information-button")?.withRenderingMode(.alwaysTemplate)
        informationButton.tintColor = UIColor.white
        
        navBar.items?.first?.rightBarButtonItem = informationButton
        
        
    }
    
    @objc func informationButtonClicked(sender:Any!){
       

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        //Use this maybe
        //let controller = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        
        let controller = storyboard.instantiateViewController(withIdentifier: "information")
    
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func questionButtonClicked(sender:Any!){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        //Use this maybe
        //let controller = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        
        let controller = storyboard.instantiateViewController(withIdentifier: "questions")
        
        self.present(controller, animated: true, completion: nil)
    
    
    //questions
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
        
        
        //var k = Resolution.init(width: 10, height: 5)
    
        
        //print("Slider value changed")
        
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        //let roundedStepValue = sender.value
        
        let stepValue = roundedStepValue/10
        
        print("\(currentEditID) Slider step value \(Int(stepValue))")
        
        
        //Set Dot Value
        var dotValue:CGFloat = CGFloat(stepValue/10)
        dotArray[currentEditID] = dotValue
        
        initSpiderWebDots()
        defaults.set(dotArray, forKey: "compassDots") //Save The Dots
        
        sliderWrapper.sliderLabel.text = Int(stepValue).description
        
    }
    
    
    @objc func close(sender:Any?){
        
        closeEdit {
            
        }
        
    }
    
    func closeEdit(completionHandler2:@escaping () -> ()){
        
        //Show Logo Again
        self.lifecompassLogoView.alpha = 1
        
        if self.textField != nil{
        self.textField.removeFromSuperview()
        self.sliderWrapper.removeFromSuperview()
        self.saveBtn.removeFromSuperview()
        }
        
        moveCompassToInitLocation()
        

        
        setAllBellsHidden(completionHandler: {
            
            //DispatchQueue.main.async { //Main Thread

                completionHandler2() //Set Complete Handler
            //}
            
        })
      
        //setAllBellsHidden {
            
          //  DispatchQueue.main.async { //Main Thread
              //  completionHandler2() //Set Complete Handler
            //}
            
        //}
        
        
        
        
        
        
    }
    
    func  createBackdrop(){
        
        backdrop = UIView()
        
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        
        
        backdrop.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(backdrop)
        
        NSLayoutConstraint(item: backdrop, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backdrop, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backdrop, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backdrop, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
    }
    
    
    func createReminderView(){
        //let reminderView = ReminderView()
        reminderView = ReminderView()
        reminderView.backgroundColor = UIColor.white

        reminderView.translatesAutoresizingMaskIntoConstraints = false
    
        self.view.addSubview(reminderView)

        NSLayoutConstraint(item: reminderView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: reminderView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: reminderView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: reminderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350).isActive = true

        //Button
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.doneReminderAction(sender:)))
        
        reminderView.doneBtn.addGestureRecognizer(tapGesture)
        reminderView.doneBtn.isUserInteractionEnabled = true
        
        
        
        reminderView.backgroundColor = AppColors.shared.backgroundColor()
        
        //Set Varibles
        //print("Current treminder id i : \(currentReminderID)")
        
        //Set Switch To active if reminder is set
        getActiveBellID { (id) in
            
            if id != nil && id == self.currentReminderID{ //We have active Reinder
                
                self.reminderView.reminderSwitch.isOn = true
                
                //Set DatePicker Date
                //let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm"
                
                //let date = dateFormatter.date(from: "2018-12-24 18:00")
                
                if let reminderDateTime = self.defaults.value(forKey: "reminderDateTime") as? Date{
                    self.reminderView.reminderDatePicker.date = reminderDateTime
                }
                
                
            }
            
        }
        
        
        
    }
    
    
    
    func createEditElements(id:Int){
    
        
        //Hide Logo
        self.lifecompassLogoView.alpha = 0
        
        //Debug Only
        /*
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = UIColor.white
        */

        /*
        dummyViewController.view.addSubview(reminderView)
        
        //let reminderView = ReminderView()
        self.present(dummyViewController, animated: true, completion: nil)
        */

 
        //Wrapepr For Slider
        sliderWrapper = CustomSlideer()
        sliderWrapper.backgroundColor = UIColor.clear
        sliderWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        //sliderWrapper.sliderLabelBackground.backgroundColor = AppColors.shared.ColorFive()
        sliderWrapper.sliderLabelBackground.backgroundColor = UIColor.clear
        
        sliderWrapper.slider.thumbTintColor = AppColors.shared.ColorThree()
        sliderWrapper.slider.minimumTrackTintColor = AppColors.shared.ColorOne()
        sliderWrapper.slider.maximumTrackTintColor = UIColor.white
        
        sliderWrapper.sliderLabel.textColor = UIColor.white
        
        //let currentMinimumTrackImage = sliderWrapper.slider.currentMaximumTrackImage!
        //sliderWrapper.slider.setMinimumTrackImage(currentMinimumTrackImage, for: .normal)
        
        self.view.addSubview(sliderWrapper)
        
        sliderWrapper.topAnchor.constraint(equalTo: self.chartWrapper.bottomAnchor, constant:40).isActive = true
        //NSLayoutConstraint(item: sliderWrapper, attribute: .top, relatedBy: .equal, toItem: self.textField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: sliderWrapper, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250).isActive = true
        
        NSLayoutConstraint(item: sliderWrapper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 65).isActive = true
        
        NSLayoutConstraint(item: sliderWrapper, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        //Add Slider to Slider Wrapper
        
        
        //let mySlider = UISlider(frame:CGRect(x: 0, y: 0, width: 200, height: 20))
        sliderWrapper.slider.minimumValue = 0
        sliderWrapper.slider.maximumValue = 100
        sliderWrapper.slider.isContinuous = true
        //mySlider.tintColor = UIColor.green
        
        sliderWrapper.slider.addTarget(self, action: #selector(FirstViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        
        //Get and set Slider Value
        let sliderValue:CGFloat = (self.dotArray[id] * 100)
        sliderWrapper.slider.setValue(Float(sliderValue), animated: false)
        
        //sliderWrapper.addSubview(mySlider)
        //Add Correct Slider Value
        sliderWrapper.sliderLabel.text = Int(sliderValue/10).description;
        
        
        let t = NSLocale.current
        
    
        
        
        let localizedContent = NSLocalizedString("testing", comment: "")
        
       // print(localizedContent)
        
        
        /* Text Field */
        self.textField = UITextField()
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        //self.textField.layer.borderWidth = 1
        //self.textField.layer.borderColor = AppColors.shared.ColorFive().cgColor
        self.textField.textAlignment = .center
        self.textField.textColor = UIColor.white
        self.textField.backgroundColor = AppColors.shared.ColorFive()
        
        self.textField.text = labelArray[currentEditID]
        
        view.addSubview(self.textField)
        
        self.textField.topAnchor.constraint(equalTo: sliderWrapper.bottomAnchor, constant:10).isActive = true
        
        NSLayoutConstraint(item: self.textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        
        NSLayoutConstraint(item: self.textField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250).isActive = true
        
        NSLayoutConstraint(item: self.textField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        //textField.addTarget(self, action: "textFieldDidChange:", for: UIControl.Event.editingChanged)
        self.textField.addTarget(self, action: "textFieldEditingDidBegin:", for: UIControl.Event.editingDidBegin)
  
        self.textField.addTarget(self, action: "textFieldEditingDidChange:", for: UIControl.Event.editingChanged)
        
        self.textField.delegate = self
        self.textField.returnKeyType = .done
        
        

        
        
        
        //Wrapepr For UIView
        saveBtn = UIButton()
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.backgroundColor = AppColors.shared.ColorFour()
        
        saveBtn.setTitle(str("Done"), for: .normal);
        
        saveBtn.setBackgroundColor(AppColors.shared.ColorFive(), for: .highlighted)
        
        saveBtn.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(saveBtn)
        
        NSLayoutConstraint(item: saveBtn, attribute: .top, relatedBy: .equal, toItem: self.textField, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        
        NSLayoutConstraint(item: saveBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250).isActive = true
        
        NSLayoutConstraint(item: saveBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: saveBtn, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        
        //Show All The Bells, Even Those who hasn't any alarms
        setAllBellsVisible()
        
        //Debug Only
       // createBackdrop()
       // createReminderView()
        

    }
    
    func moveCompassToInitLocation(){
        
        self.lc.constant = lcInitState // Back to init Value
        UIView.animate(withDuration: 1, animations: {
            
            self.view.layoutIfNeeded()
        })
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        moveCompassToInitLocation()

        
        return true
    }
    

    func setInactiveBell(id:Int){
        
        if let bell = self.view.viewWithTag(id) as? BellView{
            bell.image = UIImage(named: "musical-bell-outline")?.withRenderingMode(.alwaysTemplate)
            //bell.tintColor = AppColors.shared.ColorFour()
            bell.tintColor = UIColor.white
            bell.alpha = 0.5
        
        }
        
    }
    
    func setBellVisibility(id:Int, visible:Bool){
        
        let bellID = 20+id //This is the Active Bell ID
        
            if let bell = self.view.viewWithTag(bellID) as? BellView{
                
                //Update Bell
                if visible == false{
                    
                    bell.isHidden = true

                }else{
                    
                    //DispatchQueue.main.async { //Main Thread
                        bell.isHidden = false
                    //}
      
                }
                
                
            }
            
        
        
    }
    
    func setAllBellsHidden(completionHandler:@escaping () -> ()){
        
        // FIXME: Only get called when have an active
        getActiveBellID { (activeBellID) in
            
            print("Active bell is \(activeBellID)")

            for index in 0...12{
                
                let tmpBellID = 20+index
                
                if activeBellID != nil && index == activeBellID!{
                    print("We should keeep it")
                    //If We find Active Bell Id exists and index is that we dont do anyting.
                }else{
                
                    if let bell = self.view.viewWithTag(tmpBellID) as? BellView{
                        self.setBellVisibility(id: index, visible: false)
                        
                        self.setInactiveBell(id: (20+index)) //Make Sure it gets inactive even after reminder gone off
                    }
                    
                }
                
            }
            
            
            completionHandler() //Set Complete
            
        }
        
    }
    
    func setAllBellsVisible(){
        
        for index in 0...12{

            let tmpBellID = 20+index
            
            if let bell = self.view.viewWithTag(tmpBellID) as? BellView{
                setBellVisibility(id: index, visible: true)
            }
        
        }
            
    }
    
    func setActiveBell(id:Int){
        
        let bellID = 20+id //This is the Active Bell ID
        
        //Remove All Old Bells First
        for index in 0...12{
            
            let tmpBellID = 20+index
            
            setInactiveBell(id: tmpBellID)
            setBellVisibility(id: id, visible: true)
            
            /*
            if let bell = self.view.viewWithTag(tmpBellID) as? BellView{
                bell.image = UIImage(named: "musical-bell-outline") //Standard Image
                print("Only Happens ONe")
            }
            */
            
        }
        
        
        
        if let bell = self.view.viewWithTag(bellID) as? BellView{
            
            //Update Bell
            let bellImage = UIImage(named: "bell-musical-tool")?.withRenderingMode(.alwaysTemplate)
            bell.image = bellImage
            bell.tintColor = UIColor.white
            
            
        }
        
    }
    
    @objc func klikPlay(sender:UITapGestureRecognizer){
        
 
        
        if let rotateLabel = sender.view as? RotateLabel{
            
            self.closeEdit { //Wait Until Close Is finished
                
                //Set ID for Label
                self.currentEditID = (rotateLabel.tag-1)
                
                self.createEditElements(id:self.currentEditID)
                
            } //Remove Old View If Any
            
            //rotateLabel.text = "MR CLickO"
            //print("MR Click \(rotateLabel.tag)")
            

            
            
            
        }
        
        //screateEditElements()
        
  
    }
    
    func setReminder(time:Double, id:Int){
        
        //Notification #Notification
        let notificationTitle = str("Life compass")
        let notificationBody = str("Reminder for your life compass task");
        
        /*
        if let listenDurationTotal = defaults.value(forKey: "listenDurationTotal") as? CGFloat{
            notificationBody = "We have listen \(listenDurationTotal) seconds"
        }
        */
        
        let content = UNMutableNotificationContent.init()
        content.title = NSString.localizedUserNotificationString(forKey: notificationTitle, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: notificationBody, arguments: nil)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "categoryIdentifier"
        
        // Create a unique identifier for each notification
        //let identifier = UUID.init().uuidString //This one is good if we have multiple Notifications
        let identifier = "iHereReminder_\(id)"
        
        
        // Notification trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: time, repeats: false)
        
        // Notification request
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        // Add request
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        //Remove Request
        //UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        
        
    }
    
    func removeAllReminder(){
     
        for index in 0...12{
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["iHereReminder_\(index)"])
        }
        
    }
    
    func removeReminder(id:Int){
        
        //Remove Request
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["iHereReminder_\(id)"])
        
        
        
    }
    
    
    @objc func doneReminderAction(sender:UITapGestureRecognizer){
        
        
        let id = currentReminderID //0 to 12
        
        //reminderView.reminderDatePicker.
        
        let reminderIsActive = reminderView.reminderSwitch.isOn

        let datePickerDate = reminderView.reminderDatePicker.date
        let dateInSeconds = datePickerDate.timeIntervalSinceNow
        
        
        ///print(datePickerDate)

        
        
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss Z"
        
        
       // let m = "2018-12-24 17:00:00 +0000"
        //let date = dateFormatter.date(from: datePickerDate.description)
        
        
        
        /*
        print(dateInSeconds)
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
            
                print(request.identifier)
                
            }
        })
        */
        

        
        //setReminder(time: 5) //For Debug Only
        if(dateInSeconds > 0 && reminderIsActive){
            
          
            print("It's on! Set the Reminder #active")
            
            removeAllReminder() //Remove all old
            setReminder(time: dateInSeconds, id:id) //Set New Reminder
            
            setActiveBell(id:id)
            
            //Save Date So we Can Use it later in the DatePicke
            defaults.set(datePickerDate, forKey: "reminderDateTime") //Save The Dots
            
        }
        
        if reminderIsActive == false{
            
            self.setInactiveBell(id: (20+id)) //Make Sure it gets inactive even after
            removeReminder(id:id) //Remove Old Reminder
            
        }

        
        //Remove From Superview
        reminderView.removeFromSuperview()
        backdrop.removeFromSuperview()
        
    }
    
    @objc func clickBell(sender:UITapGestureRecognizer){
        
        
        if let bell = sender.view as? BellView{
            
            //self.close() //Remove Old View If Any
            
            //rotateLabel.text = "MR CLickO"
            //print("MR Click \(rotateLabel.tag)")
            
            //Set ID for Label
            currentReminderID = (bell.tag-20) //Get The Correct ID
            
            print(currentReminderID)
            
            //print("Label: \(labelArray[currentEditID])")
            
            createBackdrop()
            createReminderView()
            
            //createEditElements(id:currentEditID)
            
            
            
        }
        
        //screateEditElements()
        
        
    }
    
    /*
    @objc func textFieldDidChange(_ textField: UITextField) {
            print("Textfield changed lol.")
    }
     */
    
    //initRotateLabels()
    @objc func textFieldEditingDidChange(_ textField: UITextField) {
        
        labelArray[currentEditID] = textField.text!
        defaults.set(labelArray, forKey: "compassLabels")
        initRotateLabels()
        
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        print("Edit Did Begin")

        

        self.lc.constant = -100 // Some value
        UIView.animate(withDuration: 1, animations: {
        
        self.view.layoutIfNeeded()
        })
        
    }
    
    func createChartPart(view:UIView, startAngle:CGFloat, endAngle:CGFloat, color:UIColor){
        
        let chartView = ChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        
        chartView.backgroundColor = UIColor.clear
        
        chartView.startAngle = startAngle
        chartView.endAngle = endAngle
        chartView.counterColor = color
        
        let chartC1 = NSLayoutConstraint(item: chartView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let chartC2 = NSLayoutConstraint(item: chartView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let chartC3 = NSLayoutConstraint(item: chartView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        
        let chartC4 = NSLayoutConstraint(item: chartView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        
        
        NSLayoutConstraint.activate([chartC1,chartC2,chartC3,chartC4])
        
    }
    
    func createChartThinLines(view:UIView){
        
        let chartView = CompassThinLine()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        
        chartView.backgroundColor = UIColor.clear
        
        
        let chartC1 = NSLayoutConstraint(item: chartView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let chartC2 = NSLayoutConstraint(item: chartView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let chartC3 = NSLayoutConstraint(item: chartView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        
        let chartC4 = NSLayoutConstraint(item: chartView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        
        
        NSLayoutConstraint.activate([chartC1,chartC2,chartC3,chartC4])
        
    }
 
    func createChartThickLines(view:UIView){
        
        let chartView = CompassThickLine()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        
        chartView.backgroundColor = UIColor.clear
        
        
        let chartC1 = NSLayoutConstraint(item: chartView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let chartC2 = NSLayoutConstraint(item: chartView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let chartC3 = NSLayoutConstraint(item: chartView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        
        let chartC4 = NSLayoutConstraint(item: chartView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        
        
        NSLayoutConstraint.activate([chartC1,chartC2,chartC3,chartC4])
        
    }
    
    func createSpiderWeb(view:UIView){
       
        spiderWeb = SpiderWeb()
        spiderWeb.translatesAutoresizingMaskIntoConstraints = false
        spiderWeb.isUserInteractionEnabled = false
        
        view.addSubview(spiderWeb)
        
        spiderWeb.backgroundColor = UIColor.clear
        
        
        let chartC1 = NSLayoutConstraint(item: spiderWeb, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let chartC2 = NSLayoutConstraint(item: spiderWeb, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let chartC3 = NSLayoutConstraint(item: spiderWeb, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        
        let chartC4 = NSLayoutConstraint(item: spiderWeb, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        
        
        
        NSLayoutConstraint.activate([chartC1,chartC2,chartC3,chartC4])
        
    }
    
    /*
    
    func createRotateLabel(id:Int, view:UIView, angle:Double, label:String, aligment:NSTextAlignment, xPos:CGFloat, yPos:CGFloat){
        
        let rotateLabel = RotateLabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        
        rotateLabel.tag = id
        //rotateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rotateLabel)
        
        rotateLabel.angle = angle
        
        rotateLabel.text = label;
        
        let m = view.bounds.width
        
        rotateLabel.frame.origin.x = xPos
        rotateLabel.frame.origin.y = yPos
    
        rotateLabel.textAlignment = aligment
        //rotateLabel.frame.origin.x = 58
        //rotateLabel.frame.origin.y = 40
        
      
        
        
        
    }
 */
    

    func createRotateLabel(id:Int,view:UIView, text:String, angle:Double, degrees:Double, aligment:NSTextAlignment){
        
        let labelWidth:CGFloat = 80
        let labelHeight:CGFloat = 30
        
        let rotateLabel = RotateLabel()
        rotateLabel.translatesAutoresizingMaskIntoConstraints = false
        rotateLabel.tag = id
        
        view.addSubview(rotateLabel)
        
       // rotateLabel.textAlignment = .center
        
        //rotateLabel.backgroundColor = UIColor.green
        
       // rotateLabel.center = CGPoint(x: 50, y: 20)
        rotateLabel.text = text;
        rotateLabel.angle = angle
        rotateLabel.textAlignment = aligment
    
        let xPos = cos(degrees: degrees) * 90
        let yPos = sin(degrees: degrees) * 90
        
        
        
        rotateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:xPos).isActive = true
        rotateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:yPos).isActive = true
        
        
        /*
        let c1 = NSLayoutConstraint(item: rotateLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 50)
        
        let c2 = NSLayoutConstraint(item: rotateLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centcreateSubjectLabelerY, multiplier: 1, constant: 0)
        */
        
        let c3 = NSLayoutConstraint(item: rotateLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelWidth)

        let c4 = NSLayoutConstraint(item: rotateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelHeight)
        
        NSLayoutConstraint.activate([c3,c4])
        
        
        //Add Click
        //let tapGesture = UITapGestureRecognizer(target: self, action: "klikPlay:")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.klikPlay(sender:)))
        
        rotateLabel.addGestureRecognizer(tapGesture)
        rotateLabel.isUserInteractionEnabled = true
        

    
    }
    
    func createSubjectLabel(text:String, view:UIView, side:Int){
        
        let subjectLabel = UILabel()
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.font = subjectLabel.font.withSize(12)
        subjectLabel.text = text;
        subjectLabel.textColor = UIColor.white
        
        view.addSubview(subjectLabel)
        
        var subjectC1:NSLayoutConstraint!
        var subjectC2:NSLayoutConstraint!
        

        
        if side == 1{
            
            subjectC1 = NSLayoutConstraint(item: subjectLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -35)
        
            subjectC2 = NSLayoutConstraint(item: subjectLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: -35)
        
        }
        
        if side == 2{ //Right Top
            
            subjectLabel.textAlignment = .right
            
            subjectC1 = NSLayoutConstraint(item: subjectLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -35)
            
            subjectC2 = NSLayoutConstraint(item: subjectLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 35)
            
        }
        
        if side == 3{ //Right Bottom
            
            subjectLabel.textAlignment = .right
            
            subjectC1 = NSLayoutConstraint(item: subjectLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 35)
            
            subjectC2 = NSLayoutConstraint(item: subjectLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 35)
            
        }
        
        if side == 4{ //Left Bottom
            
            subjectC1 = NSLayoutConstraint(item: subjectLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 35)
            
            subjectC2 = NSLayoutConstraint(item: subjectLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: -35)
            
        }
            
        let subjectC3 = NSLayoutConstraint(item: subjectLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        
        NSLayoutConstraint.activate([subjectC1,subjectC2,subjectC3])
        
    }
    
    
    func initCompassLabelArray(){
        
        if let savedLabelArray = defaults.value(forKey: "compassLabels") as? [String]{
            //self.spiderWeb.dot_1_value = dotArray[0]
            //print(dotArray[0])

            
            labelArray = savedLabelArray
            
            
        }else{
           
            //var tmpButton = self.view.viewWithTag(tmpTag) as? UIButton

            labelArray.insert(str("Comfortable Habits"), at: 0)
            labelArray.insert(str("Nutrition and Development"), at: 1)
            labelArray.insert(str("Physical Activity"), at: 2)
            labelArray.insert(str("Professional Development"), at: 3)
            labelArray.insert(str("Personal Development"), at: 4)
            labelArray.insert(str("Working Life"), at: 5)
            labelArray.insert(str("Community Involvement"), at: 6)
            labelArray.insert(str("Own time / Spirituality"), at: 7)
            labelArray.insert(str("Recreational Activities"), at: 8)
            labelArray.insert(str("Loving Relationships"), at: 9)
            labelArray.insert(str("Friends and Social Life"), at: 10)
            labelArray.insert(str("Family Relationships"), at: 11)
            
            defaults.set(labelArray, forKey: "compassLabels")
            
            
        }
        
    }
    
    func initCompassDotArray(){
        
        if let savedDotArray = defaults.value(forKey: "compassDots") as? [CGFloat]{
            //self.spiderWeb.dot_1_value = dotArray[0]
            //print(dotArray[0])

            
            dotArray = savedDotArray
   
            
        }else{
            

            
            
            dotArray.insert(0, at: 0)
            dotArray.insert(0, at: 1)
            dotArray.insert(0, at: 2)
            dotArray.insert(0, at: 3)
            dotArray.insert(0, at: 4)
            dotArray.insert(0, at: 5)
            dotArray.insert(0, at: 6)
            dotArray.insert(0, at: 7)
            dotArray.insert(0, at: 8)
            dotArray.insert(0, at: 9)
            dotArray.insert(0, at: 10)
            dotArray.insert(0, at: 11)
            
            defaults.set(dotArray, forKey: "compassDots")
            
            
        }
        
    }
    
    func initSpiderWebDots(){
        
        self.spiderWeb.dot_1_value = dotArray[0]
        self.spiderWeb.dot_2_value = dotArray[1]
        self.spiderWeb.dot_3_value = dotArray[2]
        self.spiderWeb.dot_4_value = dotArray[3]
        self.spiderWeb.dot_5_value = dotArray[4]
        self.spiderWeb.dot_6_value = dotArray[5]
        self.spiderWeb.dot_7_value = dotArray[6]
        self.spiderWeb.dot_8_value = dotArray[7]
        self.spiderWeb.dot_9_value = dotArray[8]
        self.spiderWeb.dot_10_value = dotArray[9]
        self.spiderWeb.dot_11_value = dotArray[10]
        self.spiderWeb.dot_12_value = dotArray[11]
        
        self.spiderWeb.setNeedsDisplay()
        
    }
    
    func initRotateLabels(){
        

       /*
        if let label0 = self.view.viewWithTag(0) as? RotateLabel{
            print("Updating")
            label0.text = labelArray[0]
            
        }else{
            print("Did no thave")
         createRotateLabel(id:0, view: chartWrapper, text: labelArray[0], angle: 15, degrees: 15, aligment: .left)
        }
*/
  
        let degreesArray:[Double] = [15,45,75,105,135,165,195,225,255,285,315,345]
        let anglesArray:[Double] = [15,45,75,-75,-45,-15,15,45,75,-75,-45,-15]
        let aligmentArray:[NSTextAlignment] = [.left,.left, .left, .right,.right,.right,.right,.right,.right,.left,.left,.left]
        
        for i in 1...12 {
            
            //print("This is \(i)")
            
            if let label = self.view.viewWithTag(i) as? RotateLabel{
                
                

                label.text = labelArray[i-1]
                
            }else{
      
                createRotateLabel(id:i, view: chartWrapper, text: labelArray[i-1], angle: anglesArray[i-1], degrees: degreesArray[i-1], aligment: aligmentArray[i-1])
                
            }
            
        }
        
        /*
        createRotateLabel(id:1,view: chartWrapper, text: "Hello", angle: 45, degrees: 45, aligment: .left)
        
        createRotateLabel(id:2,view: chartWrapper, text: "Hello", angle: 75, degrees: 75, aligment: .left)
        
        createRotateLabel(id:3,view: chartWrapper, text: "This is", angle: -75, degrees: 105, aligment: .right)

        createRotateLabel(id:4,view: chartWrapper, text: "This is", angle: -45, degrees: 135, aligment: .right)
     
        createRotateLabel(id:5,view: chartWrapper, text: "Hello", angle: -15, degrees: 165, aligment: .right)
        
        createRotateLabel(id:6,view: chartWrapper, text: "Hello", angle: 15, degrees: 195, aligment: .right)
      
        createRotateLabel(id:7,view: chartWrapper, text: "I am little bit longer", angle: 45, degrees: 225, aligment: .right)
      
        createRotateLabel(id:8,view: chartWrapper, text: "Hello", angle: 75, degrees: 255, aligment: .right)
        
        createRotateLabel(id:9,view: chartWrapper, text: "Hello", angle: -75, degrees: 285, aligment: .left)
        
        createRotateLabel(id:10,view: chartWrapper, text: "Hello", angle: -45, degrees: 315, aligment: .left)
        
        createRotateLabel(id:11,view: chartWrapper, text: "Hello", angle: -15, degrees: 345, aligment: .left)
        */

    }
    
    func initBells(){
        
        
        
        let degreesArray:[Double] = [15,45,75,105,135,165,195,225,255,285,315,345]
        
        var k = 0
        for i in 1...12 {
            
            //if let bell = self.view.viewWithTag(i) as? RotateLabel{
                
                
                
              //  label.text = labelArray[i-1]
                
            //}else{
            //let delayTime = Double(i)*0.1
            //DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                // your code here
                
                var id = 20+k
                
                self.createBell(id:id, view: self.chartWrapper, degrees: degreesArray[k])
                    //createRotateLabel(id:i, view: chartWrapper, text: labelArray[i-1], angle: anglesArray[i-1], degrees: degreesArray[i-1], aligment: aligmentArray[i-1])
            
                setInactiveBell(id: id) //We make all bells inactive in the begining
                setBellVisibility(id: k, visible: false) //We also hide Every Bell
            
            
            
                //}
                
                k = k+1
            
            //}
            
        }
        
        //We init The Active Bell if we have one
       // setActiveBell()
     
        
        /*
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                
                let string = request.identifier
                let stringArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
                for item in stringArray {
                    if let number = Int(item) {
                        //print("Active Bell Number: \(number)")
                        
                        let activeBellID = number //Bell ID
                        print("ActiveBell \(activeBellID)")
                        DispatchQueue.main.async { //Main Thread
                            self.setActiveBell(id: activeBellID)
                        }
                    
                    }
                }
                
            }
        })
        */
        
        getActiveBellID { (activeBellID) in
            
            if activeBellID != nil{
                self.setActiveBell(id: activeBellID!)
            }
            
        }
        
    }
    
    func getActiveBellID(completionHandler:@escaping (_ id: Int?) -> ()){
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                
                let string = request.identifier
                let stringArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
                for item in stringArray {
                    if let number = Int(item) {
                        //print("Active Bell Number: \(number)")
                        
                        let activeBellID = number //Bell ID
                        print("#ActiveBell: \(activeBellID)")
                        
                       
                        DispatchQueue.main.async { //Main Thread
                         completionHandler(activeBellID)
                            //self.setActiveBell(id: activeBellID)
                            //return activeBellID
                             // completionHandler(activeBellID)
                        }
                        
                        //Stop The Code here
                        return
                        
                    }
                }
                
            }
           
            DispatchQueue.main.async { //Main Thread
            //Call CompleteHandler if we didn't find any active Bell
                completionHandler(nil)
            }
            
        })
        
    }
  
    //Make Notification in the forground, have to add UNUserNotificationCenterDelegate to the viewcontroller
    
    /*
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Hello")
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .sound])
    }
    */
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.
        
        completionHandler([.alert, .badge, .sound])
    }

    
    func createBell(id:Int,view:UIView, degrees:Double){
        
        let width:CGFloat = 20
        let height:CGFloat = 20
        
        let bell = BellView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bell.translatesAutoresizingMaskIntoConstraints = false
        bell.tag = id
        
        //We make a function instead
       /*
        bell.image = UIImage(named: "musical-bell-outline")?.withRenderingMode(.alwaysTemplate)
        bell.tintColor = AppColors.shared.ColorFour()
        */
        //view.addSubview(bell)
        self.view.addSubview(bell)
        
        // rotateLabel.textAlignment = .center
        //rotateLabel.backgroundColor = UIColor.green
        // rotateLabel.center = CGPoint(x: 50, y: 20)
       // rotateLabel.text = text;
        //bell.angle = angle
        //rotateLabel.textAlignment = aligment
        
        let xPos = cos(degrees: degrees) * 160
        let yPos = sin(degrees: degrees) * 160
        
        bell.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:xPos).isActive = true
        bell.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:yPos).isActive = true
        
        let c3 = NSLayoutConstraint(item: bell, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        
        let c4 = NSLayoutConstraint(item: bell, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        
        NSLayoutConstraint.activate([c3,c4])
        
        //Add Click
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.clickBell(sender:)))
        
        bell.addGestureRecognizer(tapGesture)
        bell.isUserInteractionEnabled = true
        
        
    }
    
    /*
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        let translatedPoint = button.convertPoint(point, fromView: self)
        
        if (CGRectContainsPoint(button.bounds, translatedPoint)) {
            print("Your button was pressed")
            return button.hitTest(translatedPoint, withEvent: event)
        }
        return super.hitTest(point, withEvent: event)
    }
     */
    
    

    
}

