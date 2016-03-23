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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
