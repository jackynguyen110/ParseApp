//
//  LoginViewController.swift
//  ChatClient
//
//  Created by jacky nguyen on 3/23/16.
//  Copyright © 2016 jacky nguyen. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func showAlertController(Str:String) {
        let alert = UIAlertController(title: "Error", message: Str, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func onLoginTapped(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user : PFUser?, error: NSError?) -> Void in
            if(error == nil){
                print("success")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let vc = storyboard.instantiateViewControllerWithIdentifier("ChatNavigationController") as! UINavigationController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            else{
                self.showAlertController(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onSignUpTapped(sender: AnyObject) {
        let user : PFUser = PFUser()
        
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        if(user.username == "" && user.password == "") {
            self.showAlertController("Please enter user name and pass word")
            return
        }
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if(error == nil){
                print("success")
                //let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //let vc = storyboard.instantiateViewControllerWithIdentifier("ChatNavigationController") as! UINavigationController
                //self.presentViewController(vc, animated: true, completion: nil)
            }
            else{
                self.showAlertController("Error Signing Up")
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
