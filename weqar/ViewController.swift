//
//  ViewController.swift
//  weqar
//
//  Created by veena on 2/5/18.
//  Copyright © 2018 Quaticstech. All rights reserved.
//

import UIKit
import PopupDialog

enum LoginError: Error
{
    case nameEmpty
    case passwordEmpty
    case passwordLength
    case emailError
    case confirmPasswordError
    case mobileError
    case passwordMissMatched
    case emailEmpty
}

class ViewController: BaseViewController,UITextFieldDelegate {
    

    var responseallaa = NSDictionary()
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var navigation : UINavigationController!
    
    var dummyId = "siva"
    var DeviceType = "ios"
    let myColor : UIColor = UIColor(rgb: 0xd1d1d1)
    let appColor : UIColor = UIColor(rgb: 0x009a3d)

   func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField.tag == 1) {
            usernameView.layer.borderColor = appColor.cgColor
            passwordView.layer.borderColor = myColor.cgColor
            
        }else if (textField.tag == 2) {
            usernameView.layer.borderColor = myColor.cgColor
            passwordView.layer.borderColor = appColor.cgColor
            
        }else {
            usernameView.layer.borderColor = myColor.cgColor
            passwordView.layer.borderColor = myColor.cgColor
        
        }
        
    }
    override func showPopup(animated: Bool = true , result  :String) {
        
        // Prepare the popup assets
        
        let title = ""
        let message = "\(result)"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message) //(title: title, message: message, image: image, preferredWidth: 580)
        
        // Create second button
        let buttonThree = DefaultButton(title: "Ok") { [weak self] in
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonThree])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    func isValidUser() throws -> Bool
    {
        
        guard let userName = usernameTextField.text , userName.count != 0 else{
            throw LoginError.emailEmpty
        }
        guard let password = passwordTextField.text, password.count != 0 else{
            throw LoginError.passwordEmpty
        }
        guard let passwordLength = passwordTextField.text, passwordLength.count > 5 else{
            throw LoginError.passwordLength
        }
        //if !userName.isEmail()
        if userName.isEmail()
        {
            throw LoginError.emailError
        }
        
        
        return true
    }
    @IBAction func loginButton(_ sender: Any) {
        do {
            let isValid = try self.isValidUser()
            
            if isValid{
            
                self.requestLoginApi()
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
//                self.present(vc, animated: false, completion: nil)
            }
        }
        
        catch LoginError.emailEmpty{

            self.defaultAlert(message: "", title: "Please enter your username or email address")
            
        }
        catch LoginError.emailError{
            
            self.defaultAlert(message: "", title: "Please enter a valid email address")
        }
        catch LoginError.passwordEmpty{
            
            self.defaultAlert(message: "", title: "Please enter your password")
        }
        catch LoginError.passwordLength{
            self.defaultAlert(message: "", title: "Password should be atleast 6 characters long.")
        }
        catch let error1 as NSError {
        }
        
        //        self.showPopup(result: "You have successfully logged in")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 35
        usernameView.layer.borderWidth = 2
        passwordView.layer.borderWidth = 2
        usernameView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        usernameView.layer.borderColor = UIColor(rgb: 0xd1d1d1).cgColor
        passwordView.layer.borderColor = UIColor(rgb: 0xd1d1d1).cgColor
        usernameTextField.tag = 1
        passwordTextField.tag = 2
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    

    
    @IBAction func forgotButton(_ sender: Any) {
        print("forgotButtonClicked")
    }
    
    @IBAction func guestButton(_ sender: Any) {
        print("guestButtonClicked")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VendorProfileViewController") as! VendorProfileViewController
        self.present(vc, animated: false, completion: nil)
    }
    
   @IBAction func signUpButton(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.present(signUpViewController, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
//    func requestLoginApi()
//    {
//        
//        let param = ["username" : self.usernameTextField.text!, "password" : self.passwordTextField.text, "DeviceType" : DeviceType ,"DeviceId" : dummyId ] as [String : Any]
//        
//        print(param);
//        
//        weqarAPI.login(param:param as Dictionary<String, AnyObject>) { (success, jsonObject) in
//            self.didEndLoadingContent()
//            print(jsonObject!)
//            
//            if success
//            {
//                guard let error = jsonObject?["err"] , error == nil else{ // Login failed
//                    return
//                }
//                //                self.checkUser(dict: jsonObject! as! NSDictionary)
//                //                 UserData.sharedInstance.accessToken = jsonObject.value( forKeyPath: "token" )! as? String
//                //                self.dismissLoginVC(json: jsonObject!)
//                let status = jsonObject?["Status"]
//                if status == success {
//                    self.successAlert(message: "", title: "You have successfully Logged In")
//                    self.navigationController?.popViewController(animated: true)
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
//                    self.present(vc, animated: false, completion: nil)
//
//                }else{
//                    self.successAlert(message: "", title: "Invalid UserName or Password")
//                    self.navigationController?.popViewController(animated: true)
//                }
//                
//            }else{
//                self.defaultAlert(message: "", title: jsonObject?["message"] as! String)
//            }
//        }
//        
//    }
    
    func requestLoginApi()
    {
        let param = ["username" : self.usernameTextField.text!, "password" : self.passwordTextField.text, "DeviceType" : DeviceType ,"DeviceId" : dummyId ] as [String : Any]
      
        print(param);
        
        weqarAPI.login(param:param as Dictionary<String, AnyObject>) { (success, jsonObject) in
            self.didEndLoadingContent()
//            print(jsonObject!)
            
            if success
            {
                guard let error = jsonObject?["err"] , error == nil else{ // Login failed
                    return
                }
                
                let status:String = jsonObject?["Status"] as! String
                let jsonV =  jsonObject as! [String : AnyObject]
                if let responseall : NSDictionary = jsonV["Response"] as? NSDictionary{
                       self.responseallaa = responseall
                let usertype  = self.responseallaa.value(forKey: "UserType") as! NSString
                print(usertype)
                
            if (status == "success") && (usertype == "user") {
                
                self.successAlert(message: "", title: "You have successfully Logged In")
                self.navigationController?.popViewController(animated: true)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                self.present(vc, animated: false, completion: nil)
                
                }
           else {
                self.successAlert(message: "", title: "You have successfully Logged In")
                self.navigationController?.popViewController(animated: true)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "VendorProfileViewController") as! VendorProfileViewController
                self.present(vc, animated: false, completion: nil)
            }
            
            }else{
                self.successAlert(message: "", title: "Invalid UserName or Password")
                self.navigationController?.popViewController(animated: true)
                }
//                return
            }else{
                self.defaultAlert(message: "", title: jsonObject?["message"] as! String)
            }
        }
        
    }
    
}

