//
//  ChatViewController.swift
//  ChatClient
//
//  Created by jacky nguyen on 3/23/16.
//  Copyright © 2016 jacky nguyen. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var usernameArray:[String]!
    var chatArray: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        self.chatArray = Array()
        self.usernameArray = Array()
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    @IBAction func chatPress(sender: AnyObject) {
        let chat : PFObject = PFObject(className: "Message_Swift_032016")
        chat["text"] = chatTextField.text
        chat["user"] = PFUser.currentUser()
        chat.saveInBackgroundWithBlock { (success: Bool, error:NSError?) -> Void in
            if(error == nil) {print(chat["text"])}
            else{
                print("\(error!.localizedDescription)")
            }
        }
        chatTextField.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        // Add code to be run periodically
        let query : PFQuery = PFQuery(className: "Message_Swift_032016")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (array : [PFObject]?, error:NSError?) -> Void in
            if(self.chatArray != nil){
                self.chatArray!.removeAll()
                for pobj in array!{
                    let temp : String? = pobj["text"] as? String
                    if(temp != nil){
                        self.chatArray?.append(temp!)
                        print ("chat Array \(temp)")
                        let username : String? = pobj["user"] as? String
                        if(username != nil){
                            self.usernameArray?.append(username!)
                        }
                        else{
                            self.usernameArray?.append("No username")
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatTableViewCell
        cell.chatMessageLabel.text = self.chatArray![indexPath.row]
        if((self.usernameArray![indexPath.row] as String) == "No username"){
     //       cell.usernameLabel.hidden = true
        }
        else{
    //        cell.usernameLabel.hidden = false
    //        cell.usernameLabel.text = self.usernameArray![indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.chatArray != nil){
            return self.chatArray!.count
        }
        return 0
    }
}
