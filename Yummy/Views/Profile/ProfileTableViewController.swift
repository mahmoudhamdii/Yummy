//
//  ProfileTableViewController.swift
//  Yummy
//
//  Created by hamdi on 11/03/2023.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    var spaceBetweenSections = 50
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
    }

 
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            var numOfRows = [1,4,2,2]
            return numOfRows[section]
       
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return  CGFloat (0.1)
        }else{
            return CGFloat (spaceBetweenSections/2)
        }
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
            return  CGFloat (0.1)
       
        }
  
    
    }


