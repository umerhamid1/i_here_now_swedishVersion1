//
//  QuestionViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-31.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColors.shared.backgroundColor()
        // Do any additional setup after loading the view.
    
    }
    

    @IBAction func closePressed(_ sender: Any) {
    
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
