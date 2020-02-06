//
//  InformationViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-30.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {


    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var name1Lable: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    
    @IBOutlet weak var Description1Lable: UILabel!
    
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = AppColors.shared.backgroundColor()

        name1Lable.text = "Fredrik Livheim"
        Description1Lable.text = str("Description1Key")
        name2Label.text = "Daniel Ek"
        

         

        textView.textColor = .white
        textView.text = str("Description2Key")
        //let attributedString = NSMutableAttributedString(string: str("Description2Key"))
//
//        attributedString.addAttribute(.link, value: "www.livskompass.se", range: NSRange(location: 1, length: 5))
//
//        attributedString.addAttribute(.link, value: "www.livskompass.se", range: NSRange(location: 7, length: 10))

        
        //textView.attributedText = attributedString
        textView.isEditable = false
       // textView.dataDetectorTypes = UIDataDetectorTypes.all
        
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
          UIApplication.shared.open(URL)
          return false
      }
    
    @IBAction func closeBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
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

