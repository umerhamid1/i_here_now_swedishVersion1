//
//  SeriesTableViewController.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-15.
//  Copyright © 2018 Livheim AB. All rights reserved.
//



struct Serie: Decodable{
    
    let id:String?
    let title:String?
    let description:String?
    let idOrder:String?
    let lang:String?
    
    
}





import UIKit



class SerieTableCell: UITableViewCell {

    @IBOutlet weak var serieImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}

class SeriesTableViewController: UITableViewController {

    struct UrlFetchParams: Encodable {
        
        var key: String
        var lang: String
        
    }
    
        var mainArray:[Serie] = []
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            var nav = self.navigationController?.navigationBar
            
            nav?.barStyle = UIBarStyle.black
            nav?.isTranslucent = false
            nav?.backgroundColor = UIColor.red
            nav?.barTintColor = AppColors.shared.ColorOne()
            
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            
            
            
            //QUICK FIX
            //Add Right Button
            var informationButton:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain,target:self, action:#selector(self.informationButtonClicked(sender:)))
            
            informationButton.image = UIImage(named: "information-button")?.withRenderingMode(.alwaysTemplate)
            informationButton.tintColor = UIColor.white
            
            nav?.items?.first?.rightBarButtonItem = informationButton
            
            
            //nav?.titleTextAttributes = UIColor.white
            
           // nav?.isTranslucent = false
            //nav?.tintColor = AppColors.shared.ColorTwo()
            //navigationController?.navigationBar.barTintColor = UIColor.green
            
            view.backgroundColor = AppColors.shared.backgroundColor()
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "testCell") //Programmerly make cell without storyboard
            
            
            tableView.separatorColor = UIColor.clear
            
            tableView.delegate = self
            tableView.dataSource = self
            
           // tableView.rowHeight = UITableView.automaticDimension
           // tableView.estimatedRowHeight = 100
            
            //view.backgroundColor = UIColor.purple
            
            tableView.dataSource = self
            
            ///tableView.separatorStyle = .none
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
            

            //Need to make for englisg as well
            
            let urlFetchParams = UrlFetchParams(key: "74b78d59a4b88efa5f45061818440bf6", lang: "sv" //Settings.shared.getLanguage()
            )
            
            let encoded = try! JSONEncoder().encode(urlFetchParams)
            let params = String(data: encoded, encoding: .utf8)!
            let params2 = params.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            //Fetch Data from URL
            let urlString = "https://iherenow.net/iHereAdmin/api/serieList.php?v=\(params2!)"
        
            print("here is langluagne  : \(Settings.shared.getLanguage())")
            print("the sesion url is \(urlString)")
            guard let url = URL(string: urlString) else { return }
            
            
            //Fetch The actually Data
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
           
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                }
                
               
                
                guard let data = data else { return }
           
                // Implement JSON decoding and parsing
                do {
                    
                    
                    let series = try JSONDecoder().decode([String:Serie].self, from: data)
                    
                   // print(series["81"]!.description!)
                    
                    print("seires data \(series)")
                    
                  //  let sorted = series.sorted {$0.key < $1.key} //Sort with Lowest Number First change > to opposite
                    
                    for serie in series
                        //sorted
                    {
                        //titleLabel
                       
                        
                       
                        if serie.value.title != nil{
                            
                        
                            
                            self.mainArray.append(serie.value)
                        
                        }
                       // 0...
                    }
                   
                 var a =   self.mainArray.sorted(by: { $0.idOrder! < $1.idOrder! })

                    self.mainArray = a
                    //print("here is sorted array a : \(a)")
                    //print(self.mainArray)
                  
                    
                    DispatchQueue.main.async { //Main Thread
                        
                        
                        self.tableView.reloadData() //We Reload THe TableView
                        
                    }
                    
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
            
            
        }
        
        // MARK: - Table view data source
    @objc func informationButtonClicked(sender:Any!){
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        //Use this maybe
        //let controller = storyboard.instantiateViewController(withIdentifier: "session") as! SessionViewController
        
        let controller = storyboard.instantiateViewController(withIdentifier: "information")
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
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
            //serieCell
            
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
            // let cell = tableView.de
            let cell = tableView.dequeueReusableCell(withIdentifier: "serieCell", for: indexPath) as! SerieTableCell
            
            cell.serieImage.image = UIImage(named: "meditation_icon")
            
            cell.titleLabel.text = mainArray[indexPath.row].title
            cell.descriptionLabel.text = mainArray[indexPath.row].description
            
            cell.titleLabel.textColor = UIColor.white
            cell.descriptionLabel.textColor = UIColor.white
            
            
            cell.backgroundColor = AppColors.shared.ColorFive()
            
            //cell.textLabel?.text = self.mainArray[indexPath.row]
            // Configure the cell...
            
            
            return cell
        }
        var id = 0
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            
            let nextView = SessionTableViewController()
            
             id = Int(mainArray[indexPath.row].id!)!
            
            performSegue(withIdentifier: "goToMeditationDetails", sender: self)
           
            
            //self.navigationController?.pushViewController(nextView, animated: true)
            
            //print(mainArray[indexPath.row].id!)
            
            
            
            
            //print("You clicked at: \(indexPath.row)")
            
            /*
            let alert = UIAlertController(title: "Do you like \(indexPath.row)?", message: "This number is yours forever if you click yes.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("Ok! You took number \(indexPath.row) and it is yours forever.")
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                print("Ok, you are going to find another number you like for sure!")
            }))
            
            self.present(alert, animated: true)
            */
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMeditationDetails" {
            
            let meditationVC = segue.destination as! MeditationDetailsTableViewController
            meditationVC.serieID = id
            
        }
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
