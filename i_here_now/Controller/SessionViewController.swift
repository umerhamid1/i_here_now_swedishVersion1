//
//  SessionViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-15.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit
import AVFoundation

extension AVPlayer {
    
    var isPlaying: Bool {
        if (self.rate != 0 && self.error == nil) {
            return true
        } else {
            return false
        }
    }
    
}

class SessionViewController: UIViewController {

    struct UrlFetchParams: Encodable {
        
        var key: String
        var lang: String
        var id: Int
        
    }
    
    var secondsValue : Double?
    var minutes = ""
    var timeRemaining = 20.0 //20.0//1500.0
    var totalTime = 20.0//1500.0
    var breakTimeRemaining = 300.0
    var totalBreakTime = 300.0
    var timerIsOn = false
    var timer = Timer()
    var isOnBreak = false
      
      

      let store = DataStore.sharedInstance
    
    var iHereSession:Session?
    var iHereSessionID = 0
    
    var player:AVPlayer?
    
    var timeObserverToken:Any?
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var progressLabel: UILabel!
  
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
        playBtn.setImage(UIImage(named: "play-button"), for: .normal)
    }

    @IBAction func playSession(_ sender: Any) {
        
  
        if player?.isPlaying == true{
            print("Stop Session")
            player?.pause()
            playBtn.setImage(UIImage(named: "play-button"), for: .normal)
            // timer stor
         
         if !self.store.userIsOnBreak{
                   timer.invalidate()
                   timerIsOn = false
                  // playBtn.isEnabled = true
               } else if self.store.userIsOnBreak {
                   timer.invalidate()
                   timerIsOn = false
                 //  playBtn.isEnabled = true
               }
            
            
        }else{
            print("Play Session")
            
            player?.play()
            playBtn.setImage(UIImage(named: "pause_button"), for: .normal)
            

            //this is a regular interval
            if !timerIsOn && !self.store.userIsOnBreak {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(regularTimerRunning), userInfo: nil, repeats: true)
                timerIsOn = true
                //playBtn.isEnabled = false
            }
            //this is a break interval
            if !timerIsOn && self.store.userIsOnBreak {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerRunning), userInfo: nil, repeats: true)
                timerIsOn = true
               // playBtn.isEnabled = false
            }
        }
            
    }
    
    func manageTimerEnd(seconds: Double) {
          //regular 25 min interval is ending, stop the timer and show pop up
          if seconds == 0 && !self.store.userIsOnBreak {
              timer.invalidate()
              timerIsOn = false
              
            timeRemaining = secondsValue ?? 0.0//20.0//1500.0
            totalTime = secondsValue ?? 0.0//20.0
              timeLabel.text = minutes
              timeLabel.text = minutes
              progressView.setProgress(1 , animated: false)
             // self.progressView.setProgress(0, animated: false)
            //  self.performSegue(withIdentifier: "toPopUp", sender: self)
          }
          if seconds == 0 && self.store.userIsOnBreak {
              timer.invalidate()
              timerIsOn = false
              
            
              self.progressView.setProgress(1, animated: false)
          
            
            timeRemaining = secondsValue ?? 0.0//20.0//1500.0
                       totalTime = secondsValue ?? 0.0//20.0
                         timeLabel.text = minutes
                        
              //  self.performSegue(withIdentifier: "toTaskCheck", sender: self)
          }
      }
  
    @IBAction func closeView(_ sender: Any) {
      
          print("Hello")
          
          if player?.isPlaying == true{
             print("Stop Session")
             player?.pause()
              self.player = nil
              
             playBtn.setImage(UIImage(named: "play-button"), for: .normal)
               
             // timer stor
          }
         
         
          removePerodicTimeObserver() //Remove Observer Otherwise the sound will keep on playing
         // navigationController?.popToRootViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
          
      }
      override func viewDidDisappear(_ animated: Bool) {
                player?.pause()
           self.player = nil
                playBtn.setImage(UIImage(named: "play-button"), for: .normal)
            removePerodicTimeObserver()
         ////// try! AVAudioSession.sharedInstance().setActive(false)
            }
    func removePerodicTimeObserver(){ //We Might Use This One
        
        
        if let timeObserverToken = timeObserverToken{
            
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
            
        }
        
    }
    
    func addPeriodicTimeObserver(){
        
        //Make Variable to Save Stats how long time you listen
        if let listenDurationTotal = defaults.value(forKey: "listenDurationTotal") as? CGFloat{
            
        }else{ //If it was failed we make a vairbale
            
            defaults.set(0, forKey: "listenDurationTotal") //Init This Variable
        }
    
    
        //Notify Every Second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1, preferredTimescale: timeScale)
        
        timeObserverToken = self.player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { (time) in
            
            
            
            if(time.seconds != 0.0){
            //Get Old Data
            var listenTotalDuration = self.defaults.value(forKey: "listenDurationTotal") as! CGFloat
            
            //Update Data
            listenTotalDuration = listenTotalDuration + 1; //Add one Second
            
            //Save Data
            self.defaults.set(listenTotalDuration, forKey: "listenDurationTotal") //Save The Stats
            
            }
            
            print(time.seconds)
            
         
            
        })
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeRemaining = secondsValue ?? 200.0
        totalTime = secondsValue ?? 200.0
        
        formatInitialViews()
        setupTimerBell()
        view.backgroundColor = AppColors.shared.backgroundColor()
       
        
        //playBtn.imageView?.image.t = UIColor.white
        
        
        
        sessionLabel.text = iHereSession?.title
        
        print("Hello there MR \(iHereSession!.title!)")
        
        iHereSessionID = Int(iHereSession!.id!)!
        
       // let url = URL(string: "https://nickini.com/site/json/15%20In%20the%20clun.mp3")
        
        let urlFetchParams = UrlFetchParams(key: "74b78d59a4b88efa5f45061818440bf6", lang: "sv"//Settings.shared.getLanguage()
            , id:iHereSessionID)
        let encoded = try! JSONEncoder().encode(urlFetchParams)
        let params = String(data: encoded, encoding: .utf8)!
        let params2 = params.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Fetch Data from URL
        let urlString = "https://iherenow.net/iHereAdmin/api/session.mp3?v=\(params2!)"
        
        print("URL String")
        print(urlString)
        print("---------------------")
        
        guard let url = URL(string: urlString) else { return }
        
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
       
        removePerodicTimeObserver() //In Case We have One already
        addPeriodicTimeObserver()
        //player?.play()
        
        
        //Keep Playing In The Background, It's working just like this.
        //Need to add controls
        let session = AVAudioSession.sharedInstance()
        
        do {
            
            // Configure the audio session for movie playback
            
            try session.setCategory(AVAudioSession.Category.playback,
                                    
                                    mode: AVAudioSession.Mode.moviePlayback,
                                    
                                    options: [])
            
        } catch let error as NSError {
            
            print("Failed to set the audio session category and mode: \(error.localizedDescription)")
            
        }
        
        

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
     override func viewDidAppear(_ animated: Bool) {
            //here is when you play a break or not
            actionAfterPopUp()
            actionAfterCheckTask()
        }
        
        func actionAfterPopUp() {
            //formats the view to show "break mode"
            if self.store.userIsOnBreak {
                breakTimeLabel.isHidden = false
                timeLabel.isHidden = true
                progressView.trackTintColor = .green
                //playBtn.isEnabled = true
            }
        }
        
        func actionAfterCheckTask() {
            if !self.store.userIsOnBreak {
                breakTimeLabel.isHidden = true
                timeLabel.text = minutes
                timeLabel.isHidden = false
                //progressView.trackTintColor = .red
                //playBtn.isEnabled = true
            }
        }
        
        @objc func regularTimerRunning() {
            timeRemaining -= 1
            progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
            let minutesLeft = Int(timeRemaining) / 60 % 60
            let secondsLeft = Int(timeRemaining) % 60
            timeLabel.text = "\(minutesLeft):\(secondsLeft)"
            timerIsOn = false
            manageTimerEnd(seconds: timeRemaining)
        }
        
        @objc func breakTimerRunning() {
            breakTimeRemaining -= 1
            progressView.setProgress(Float(breakTimeRemaining)/Float(totalBreakTime), animated: false)
            let minutesLeft = Int(breakTimeRemaining) / 60 % 60
            let secondsLeft = Int(breakTimeRemaining) % 60
            breakTimeLabel.text = "\(minutesLeft):\(secondsLeft)"
            timerIsOn = false
            manageTimerEnd(seconds: breakTimeRemaining)
        }
        
        func setupTimerBell() {
    //        do {
    //            try buttonSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "double_ring_from_desk_bell", ofType: "mp3")!))
    //        } catch {
    //            print(error.localizedDescription)
    //            print("Error: There's an error with the audio file named double_ring_from_desk_bell.mp3")
    //        }
        }
        
        func formatInitialViews() {
           // navigationController?.isNavigationBarHidden = true
            goalLabel.text = self.store.tasks.last?.description
            breakTimeLabel.isHidden = true
           // resetBtn.layer.borderColor = .black
          //  resetBtn.layer.cornerRadius = 8
                //resetBtn.layer.borderWidth = 1
            progressView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2) * 2)
    //        editTaskPopUp.layer.borderColor = Constants.red.cgColor
    //        editTaskSubmitBtn.layer.borderColor = Constants.red.cgColor
        }

        @IBAction func showEditTaskPopUp(_ sender: Any) {
//            editTaskConstraint.constant = 0
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
        }
        
        @IBAction func closeEditTaskPopUp(_ sender: Any) {
            //animates the view back off the screen
//            editTaskConstraint.constant = -400
//            if editTaskTextField.text != "" {
//                guard let unwrappedEditedTask = editTaskTextField.text else { return }
//                self.store.tasks.last?.description = unwrappedEditedTask
//                goalLabel.text = unwrappedEditedTask
//            }
//            UIView.animate(withDuration: 0.1) {
//                self.view.layoutIfNeeded()
//            }
        }
}
