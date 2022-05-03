//
//  LoginViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/17/22.
//

import UIKit
import ArgumentParser

struct User: Codable {
    let _id: String
    var first_name, last_name, email, role, dhp_id : String
   
}


struct LoginResponse: Codable {
    let token: String
    let user: User

}


class LoginViewController: UIViewController {
    
    var authToken: String = ""
    var user: User? = nil
    var dhpID : String?
    
    var arr = ["sai@gmail.com","12345"]
    var img = ["circle","checkmark.circle.fill"]
    var cnt = 0
    
    @IBOutlet weak var emailTextField: UILabel!
    
    
    @IBOutlet weak var passwordTextField: UILabel!
    
    @IBOutlet weak var checkboxOutlet: UIButton!

    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        password.isSecureTextEntry = true
    }
    
    
    @IBAction func passwordTyping(_ sender: Any) {
    }
    
    @IBAction func checkboxClicked(_ sender: UIButton) {
        if(cnt == 1)
        {
        checkboxOutlet.setImage(UIImage(systemName: img[0]), for: .normal)
            cnt = cnt - 1
        }
        else if(cnt == 0)
        {
            checkboxOutlet.setImage(UIImage(systemName: img[1]), for: .normal)
            cnt = cnt + 1
        }
    }
    
    @IBAction func signupLink(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        //let email = emailId.text!
        //let password = password.text!
        //LoginButton.isEnabled = false
        //postData()
        
        
        
        if(emailId.text == "" || password.text == "")
        {
            if(emailId.text == "" && password.text == "")
            {
                emailTextField.text = "* Required Field"
                passwordTextField.text = "* Required Field"
            }
            else if(emailId.text == "" && password.text != "")
            {
                emailTextField.text = "* Required Field"
                passwordTextField.text = ""
            }
            else if (password.text == "" && emailId.text != "")
            {
                passwordTextField.text = "* Required Field"
                emailTextField.text = ""
            }
        }
        else if(password.text != "" && emailId.text != ""){
            emailTextField.text = ""
            passwordTextField.text = ""
            postData()
        }
//        else if(emailId.text != arr[0] && password.text != arr[1])
//        {
//            let uialert = UIAlertController( title: "", message: "EmailID / Password is incorrect", preferredStyle: UIAlertController.Style.alert)
//            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
//            self.present(uialert, animated: true, completion: nil)
//        }
//        else{
//            let storyboard = UIStoryboard(name : "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "home")
//            vc.modalPresentationStyle = .overFullScreen
//            present(vc, animated: true)
//        }
        
        
        
        
        
        
    }
    func postData() {
        
       // emailTextField.text = "hello world!"
        //spinner.startAnimating()
        // 1) create URL
        guard let url = URL(string:"https://dhp-server.herokuapp.com/api/auth/signin") else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        let email = emailId.text!
        let password = password.text!
        let parameters: [String: Any] = ["email": email, "password": password]
       
        httpRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            var idid : String?
            var toke : String?
            do {
                let decoded = try JSONDecoder().decode(LoginResponse.self, from: data);
                DispatchQueue.main.async {
                    self.user = decoded.user
                    //self.user?.dhp_id = decoded.user.dhp_id
                    self.authToken = decoded.token
                    idid = decoded.user._id
                    toke = decoded.token
                    print("Successfully logged in")
                    print("DHPID : \(decoded.user.dhp_id)")
                    self.dhpID = decoded.user.dhp_id
                    //let loader =   self.loader()
                    //self.stopSpinning();
                    
                    
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "example") as! exampleViewController
//                    controller.str = idid
//                    controller.tokee = toke
//                    controller.modalPresentationStyle = .fullScreen
//                    self.present(controller, animated: true, completion: nil)
                    if(self.emailId.text != email || self.password.text != password)
                    {
                        let uialert = UIAlertController( title: "", message: "EmailID / Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                                    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(uialert, animated: true, completion: nil)
                    }
                    else{
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
                    controller.str = idid
                    controller.tokee = toke
                    controller.fname = decoded.user.first_name
                    controller.lname = decoded.user.last_name
                    controller.dob = "09/09/1997"
                    controller.passNum = "N0557557"
                    controller.issuedCountry = "India"
                    controller.phNum = "9595959595"
                    controller.mailId = decoded.user.email
                        controller.dhpID = self.dhpID
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                    }
                    
                }
               
            } catch{
                
                //self.popUp()
                //self.emailTextField.text = "Incoorect ID Or Password"
                print("Error in JSON parsing", error)
                //print(self.popUp())
                //self.stopSpinning();
                //self.LoginButton.isEnabled = true
                
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    func popUp(){
        let uialert = UIAlertController( title: "", message: "EmailID / Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                    uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(uialert, animated: true, completion: nil)
    }
    
    
    @IBAction func emailIdOrPass(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "emailidORPassword")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    

    @IBAction func emailIDTexting(_ sender: Any) {
        emailTextField.text = ""
    }
    
    @IBAction func passwordTexting(_ sender: Any) {
        passwordTextField.text = ""
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
