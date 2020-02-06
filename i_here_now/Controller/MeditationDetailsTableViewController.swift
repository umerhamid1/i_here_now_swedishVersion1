//
//  MeditationDetailsTableViewController.swift
//  i_here_now
//
//  Created by umer hamid on 1/29/20.
//  Copyright © 2020 Livheim AB. All rights reserved.
//

import UIKit

class MeditationDetailsTableViewController: UITableViewController {
    
    struct UrlFetchParams: Encodable {
        
        var key: String
        var lang: String
        var id: Int
        
    }
    
    var serieID:Int = 0
    
    var mainArray:[Session] = []
    
    /*
     //Debug
     override func viewDidAppear(_ animated: Bool) {
     
     }
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.shared.backgroundColor()
        
        print("Serie ID is \(serieID)")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
      
        
      //  navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.red]

        //self.navigationController?.navigationBar.titleTextAttributes = UIColor.white
        
        // var nav = self.navigationController?.navigationBar
        ///nav?.titleTextAttributes = UIColor.white
        //navigationController?.navigationBar
        
        tableView.separatorColor = UIColor.clear
        ///tableView.separatorStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        

        
    
        severCall() // get data from the server
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.mainArray.count//5
    }
    
    var audioSeconds = 0.0
    var secondsInEnglish = ""
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeditationDetailCell", for: indexPath) as! MeditationDetailsTableViewCell
        
        cell.meditationTitle.text = self.mainArray[indexPath.row].title//"testing"
        
        audioSeconds = Double(self.mainArray[indexPath.row].duration ?? "0.0")!
        let second : Int = Int(Double(self.mainArray[indexPath.row].duration ?? "0")!)
        
        
        let (h,m,s) =    secondsToHoursMinutesSeconds(seconds: second)
        secondsInEnglish = "\(m):\(s)"
        
        //        if h < 10 {
        //            duration = "0\(m):\(s)"
        //        }else if h > 9 {
        //            duration = "\(m):\(s)"
        //        }
        print("the during of the cell : \(secondsInEnglish)")
        cell.meditationDuration.text = secondsInEnglish
        
        cell.backgroundColor = AppColors.shared.ColorFive()
        
        cell.selectionStyle = .none
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let title = mainArray[indexPath.row].path
        
        print(mainArray[indexPath.row])
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        
        
        controller.iHereSession = mainArray[indexPath.row]
        controller.secondsValue = Double(mainArray[indexPath.row].duration ?? "0")!//audioSeconds
        let second : Int = Int(Double(self.mainArray[indexPath.row].duration ?? "0")!)
        let (h,m,s) =    secondsToHoursMinutesSeconds(seconds: second)
        let secondsInString = "\(m):\(s)"
        controller.minutes = secondsInString
        
        print("Meditation Details audioSeconds \(audioSeconds)")
        print("Meditation Details seconds in english \(secondsInEnglish)")
        print("array second \(mainArray[indexPath.row].duration)")
        self.present(controller, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension MeditationDetailsTableViewController {
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    
    
    
    func severCall(){
        //Fetch Data from URL
        let urlFetchParams = UrlFetchParams(key: "74b78d59a4b88efa5f45061818440bf6", lang: "sv"//Settings.shared.getLanguage()
            , id:serieID)
        let encoded = try! JSONEncoder().encode(urlFetchParams)
        let params = String(data: encoded, encoding: .utf8)!
        let params2 = params.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Fetch Data from URL
        let urlString = "https://iherenow.net/iHereAdmin/api/sessionList2.php?v=\(params2!)"
        
        guard let url = URL(string: urlString) else { return }
        
        
        //Fetch The actually Data
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            
            if error != nil {
                
                print(error!.localizedDescription)
            }
            
            
            
            guard let data = data else { return }
            
            // Implement JSON decoding and parsing
            do {
                
                
                let sessions = try JSONDecoder().decode([Session].self, from: data)
                
                //print(series["81"]!.description!)
                
                //let sorted = sessions.sorted {$0.key < $1.key} //Sort with Lowest Number First change > to opposite
                
                for session in sessions {
                    //titleLabel
                    
                    
                    
                   //   if session.title != nil{
                    
                    
                    
                    self.mainArray.append(session)
                    
                    //  }
                    
                }
                
                DispatchQueue.main.async { //Main Thread
                    
                    self.tableView.reloadData() //We Reload THe TableView
                    
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}

