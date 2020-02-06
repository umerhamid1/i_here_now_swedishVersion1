//
//  SessionTableViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-15.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

struct Session: Decodable{
    
    let id:String?
    let title:String?
    let description:String?
    let idOrder:String?
    let lang:String?
    let duration:String?
    let path:String?
    
    
}

import UIKit

class SessionTableViewController: UITableViewController {
    
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
        //self.navigationController?.navigationBar.titleTextAttributes = UIColor.white
        
       // var nav = self.navigationController?.navigationBar
        ///nav?.titleTextAttributes = UIColor.white
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "testCell") //Programmerly make cell without storyboard
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //view.backgroundColor = UIColor.purple
        
        tableView.dataSource = self
        
        tableView.separatorColor = UIColor.clear
        ///tableView.separatorStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //Fetch Data from URL
        let urlFetchParams = UrlFetchParams(key: "74b78d59a4b88efa5f45061818440bf6", lang: Settings.shared.getLanguage(), id:serieID)
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
                    
                    
                    
                    if session.title != nil{
                        
                        
                        
                        self.mainArray.append(session)
                        
                    }
                    
                }
                
                DispatchQueue.main.async { //Main Thread
                    
                    self.tableView.reloadData() //We Reload THe TableView
                    
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
        
    
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.mainArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        // let cell = tableView.de
        
        cell.textLabel?.text = self.mainArray[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        // Configure the cell...
        
        cell.backgroundColor = AppColors.shared.ColorFive()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let title = mainArray[indexPath.row].path

        print(mainArray[indexPath.row])
      
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        
        
        controller.iHereSession = mainArray[indexPath.row]
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

