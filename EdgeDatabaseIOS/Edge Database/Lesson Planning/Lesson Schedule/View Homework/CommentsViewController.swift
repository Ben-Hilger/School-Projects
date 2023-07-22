//
//  CommentsViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class CommentsViewController : UITableViewController, CenterTextAreaDelegate {
    
    var homeworkViewing : Homework?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeworkViewing?.comments.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comments") as! CenterTextAreaTableViewCell
        
        if let comments = homeworkViewing?.comments as? [Comments] {
            cell.configureCell(withContent: comments[indexPath.section].content, forComment: comments[indexPath.section])
        }
        cell.bounds = cell.textArea.bounds
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (homeworkViewing?.comments[section] as! Comments).name
    }
    
    @IBAction func addComment(sender : Any) {
        
        let enterName = AlertUtil.generateAlertViewController(withTitle: "Add Comment", withMessage: "Please enter a name below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Name Here..."])
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            if let text = enterName.textFields?[0].text {
                if  !text.elementsEqual("") {
                    let newComment = Comments(name: text, content: "Please Enter Comment Here...")
                    if let homework = self.homeworkViewing {
                        for comment in homework.comments {
                            if let comment = comment as? Comments {
                                if comment.name == text {
                                    return
                                }
                            }
                        }
                    }
                    self.homeworkViewing?.comments.add(newComment)
                }
                
            }
            
        }
        
        enterName.addAction(doneAction)
        
        self.present(enterName, animated: true, completion: nil)
    }
    
    @IBAction func done(sender : Any) {
        self.performSegue(withIdentifier: "toVideos", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.elementsEqual("toVideos") ?? false {
            let des = segue.destination as! HomeworkVideoViewController
            des.homeworkToView = homeworkViewing
        }
    }
    
    func updated() {
        self.tableView.reloadData()
        //tableView.updateConstraintsIfNeeded()
    }
    
}
