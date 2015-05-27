import UIKit

// Parse and Facebook API Setup

import Bolts
import Parse
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func regularLogin(sender: UIButton) {
    }
    let permissions = ["public_profile", "email", "user_friends"]

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // push services test
        var push = PFPush()
        push.setMessage("Testing Push Notificaiton")
        push.sendPushInBackground()
        loginButton.readPermissions = permissions
        loginButton.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if let currentUser = PFUser.currentUser(){
            println("sending user to the main app screen because he's a current user")
            self.gotoMainScreen()
        } else {
            // Show the signup or login screen
            
            return
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
            println("user pressed the cancel button")
            
        } else {
            println("Putting the user to parse!")
            
            
            PFFacebookUtils.logInInBackgroundWithAccessToken(result.token, block: { (user: PFUser?, error: NSError?) -> Void in
                if let user = user {
                    if user.isNew {
                        println("User signed up and logged in through Facebook!")
                    } else {
                        println("User logged in through Facebook!")
                    }
                    self.gotoMainScreen()
                } else {
                    println("Uh oh. The user cancelled the Facebook login.")
                }
            })
    
            println("Permission was allowed go to the next view")
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                println("access to user's email was granted")
                // print this out if the email was granted
                
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        PFUser.logOut()
        // do I need this?
        var currentUser = PFUser.currentUser()
    }
    
    func gotoMainScreen(){
        self.performSegueWithIdentifier("showMainApp", sender: nil)
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
