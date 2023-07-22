//
//  BucketListViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/21/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class DocketViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var bucketList : [Docket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DocketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "bucketList") as! DocketTableViewCell
        cell.setupBucketList(b: bucketList[indexPath.row])
        return cell
    }

    
}
