//
//  MainViewTableViewController.swift
//  KultSPORT
//
//  Created by Norbert Czirjak on 2016. 11. 13..
//  Copyright © 2016. Norbert Czirjak. All rights reserved.
//

import UIKit



class MainViewTableViewController: UITableViewController {

    
    var TableData:Array<String> = Array <String>()
    var TableDataImg:Array<String> = Array <String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  let strURL = "https://api.soccerama.pro/v1.2/competitions?api_token=ECdbbX7PECXottfEAGbeBfkz0YEXON3fQItqNBoNJkJp8buIOAUu6D9Zfh5W&include=country,currentSeason"
        
        get_data_from_url("https://api.soccerama.pro/v1.2/competitions?api_token=ECdbbX7PECXottfEAGbeBfkz0YEXON3fQItqNBoNJkJp8buIOAUu6D9Zfh5W&include=country,currentSeason")
        
        
        /*competitionsJson.downloadCompetitions {
            //amit itt csinalunk az csak a neetwork hivas befejezese utan kerul meghivasra
            self.updateUI()
        }*/
        
        
    }

    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return TableData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitionsCell", for: indexPath) as! CompetitionCellTableViewCell

        cell.competitionNameLbl?.text = TableData[indexPath.row]
        
        let flagUrl = URL(string: TableDataImg[indexPath.row])
        //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let flagImg = try? Data(contentsOf: flagUrl!)
        cell.competitionFlag.image = UIImage(data: flagImg!)
        
        return cell
    }
/*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        

    }
*/
    
    
    
    func get_data_from_url(_ link:String){
        
        let url: URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest, completionHandler:{
            (
            data, response, error) in
            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                return
            }
            
            self.extract_json(data!)
            
        })
        task.resume()
    }
    
    func extract_json(_ data: Data)
    {
        let json: [String: AnyObject]
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            
        } catch {
            return
        }
        
        /*guard let data_list = json as? AnyObject else
         {
         return
         }*/
        //print(json["data"])
        
        if let competition_data = json["data"] as? NSArray
        {
            for i in 0 ..< competition_data.count {
                
                //print(competition_data)
                if let competition_obj = competition_data[i] as? NSDictionary
                {
                    if let country_name = competition_obj["name"] as? String {
                        print(country_name)
                        TableData.append(country_name)
                    }
                    
                    //print(competition_obj["country"])
                    
                    if let countryArray = competition_obj["country"] as? AnyObject {
                        
                        let flag = countryArray["flag"] as! String
                        TableDataImg.append(flag)
                    }
                }
                
            }
        }
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
