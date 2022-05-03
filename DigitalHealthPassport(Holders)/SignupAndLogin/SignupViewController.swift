//
//  SignupViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/17/22.
//

import UIKit
import Foundation

struct SignupResponse: Codable {
    let dhp_id, first_name, last_name, middle_name: String
    let phone_number, verification_id, verification_type, verification_issued_country: String?
    let verification_issued_date, gender: String?
    let terms_condition: Bool
    let email, role: String
    let active: Bool?
    let _id, createdAt: String
    let __v: Int
}

class SignupViewController: UIViewController{
    
    
    var dhp_id: String = ""
    
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    var img = ["circle","checkmark.circle.fill"]
    var cnt = 0
    
    var fieldss = ["password.text","firstName.text","lastname.text","dateofbirth.text","phonenumber.text","password.text","confirmpassword.text","passportnumber.text","homecountry.text"]
    
    @IBOutlet weak var firstNameErrorMsg: UILabel!
    
    @IBOutlet weak var lastNameErrorMsg: UILabel!
    
    @IBOutlet weak var dateOfBirthErrorMsg: UILabel!
    
    
    @IBOutlet weak var emailIDErr: UILabel!
    
    
    @IBOutlet weak var phoneNumbererrorMsg: UILabel!
    
    @IBOutlet weak var passportIssuecountryErrMsg: UILabel!
    
    @IBOutlet weak var passportNumberError: UILabel!
    
    @IBOutlet weak var passwordErrMsg: UILabel!
    
    @IBOutlet weak var confirmPassErrMsg: UILabel!
    
    @IBOutlet weak var dropdownOutlet: UIButton!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var dateofbirth: UITextField!
    
    @IBOutlet weak var phonenumber: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passportnumber: UITextField!
    @IBOutlet weak var homecountry: UITextField!
    
    @IBOutlet weak var checkboxOutlet: UIButton!
    
    
    @IBOutlet weak var emailIdOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        confirmpassword.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginlinkclicked(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    
    
    @IBAction func emailIDTyping(_ sender: Any) {
        
    }
    
    @IBAction func signupbuttonclicked(_ sender: Any) {
        
        //postData();
    
        if(emailIdOutlet.text == "" || firstName.text == "" || lastname.text == "" || dateofbirth.text == "" || phonenumber.text == "" || password.text == "" || confirmpassword.text == "" || passportnumber.text == "" || homecountry.text == "")
        {
            if(password.text == "")
            {
                passwordErrMsg.text = "*Required Field"
            }
            if(firstName.text == "")
            {
                firstNameErrorMsg.text = "*Required Field"
            }
            if(lastname.text == "")
            {
                lastNameErrorMsg.text = "*Required Field"
            }
            if(dateofbirth.text == "")
            {
                dateOfBirthErrorMsg.text = "*Required Field"
            }
            if(phonenumber.text == "")
            {
                phoneNumbererrorMsg.text = "*Required Field"
            }
            if(password.text == "")
            {
                passwordErrMsg.text = "*Required Field"
            }
            if(confirmpassword.text == "")
            {
                confirmPassErrMsg.text = "*Required Field"
            }
            if(passportnumber.text == "")
            {
                passportNumberError.text = "*Required Field"
            }
            if(homecountry.text == "")
            {
                passportIssuecountryErrMsg.text = "*Required Field"
            }
        }
        else if(emailIdOutlet.text != "" || firstName.text != "" || lastname.text != "" || dateofbirth.text != "" || phonenumber.text != "" || password.text != "" || confirmpassword.text != "" || passportnumber.text != "" || homecountry.text != ""){
//            let storyboard = UIStoryboard(name : "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "EmailOrPassword")
//            vc.modalPresentationStyle = .overFullScreen
//            present(vc, animated: true)
            
            postData();
//
        }
    }
    
    func postData() {
        // 1) create URL
        guard let url = URL(string:"https://dhp-server.herokuapp.com/api/auth/signup") else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        let email = emailIdOutlet.text!
        let firstname = firstName.text!
        let lastname = lastname.text!
        let password = password.text!
        let dob = dateofbirth.text!
        let exipry = "4-2-25"
        let idnumber = passportnumber.text!
        let phone = phonenumber.text!
        
        
        

        let parameters: [String: Any] = ["email": email,"password": password,"first_name":firstname,"last_name":lastname,"middle_name":"","gender":"MALE","role":"HOLDER","phone_number":phone,"verification_id":idnumber,"verification_type":"DRIVERS LICENSE","terms_condition": true]
        
        httpRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode(SignupResponse.self, from: data);
                DispatchQueue.main.async {
                    self.dhp_id = decoded.dhp_id;
                    if (self.dhp_id != "") {
                        print("DHP ID :", self.dhp_id)
                       // self.performSegue(withIdentifier: "Login", sender: self)
                        
                        let storyboard = UIStoryboard(name : "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    }
                    
                }
                print(decoded)
               
            } catch let error {
                print("Error in JSON parsing", error)
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    
    
    
    @IBAction func dropdownclicked(_ sender: Any) {

    }
    
    
    @IBAction func checkboxClicked(_ sender: Any) {
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
    
    
    @IBAction func firstNameTexting(_ sender: Any) {
        firstNameErrorMsg.text = ""
    }
    
    @IBAction func lastNameTextting(_ sender: Any) {
        lastNameErrorMsg.text = ""
    }
    
    @IBAction func dateOfBirthTexting(_ sender: Any) {
        dateOfBirthErrorMsg.text = ""
    }
    
    @IBAction func phoneNumberTexting(_ sender: Any) {
        phoneNumbererrorMsg.text = ""
    }
    
    
    @IBAction func countryTexting(_ sender: Any) {
        passportIssuecountryErrMsg.text = ""
    }
    
    @IBAction func passportNumberTexting(_ sender: Any) {
        passportNumberError.text = ""
    }
    
    @IBAction func passwordTexting(_ sender: Any) {
        passwordErrMsg.text = ""
    }
    
    
    @IBAction func confirmPasswordClicked(_ sender: Any) {
        confirmPassErrMsg.text = ""
    }
    
    

    @IBAction func referPassword(_ sender: UIButton) {
        let uialert = UIAlertController( title: "", message: "Password must contain ", preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
    
    
}
