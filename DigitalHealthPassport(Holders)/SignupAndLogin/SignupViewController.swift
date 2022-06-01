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
    
    
    @IBOutlet weak var shadowview: UIView!
    
    @IBOutlet weak var firstNameErrorMsg: UILabel!
    
    @IBOutlet weak var lastNameErrorMsg: UILabel!
    
    @IBOutlet weak var dateOfBirthErrorMsg: UILabel!
    
    
    @IBOutlet weak var emailIDErr: UILabel!
    
    
    @IBOutlet weak var phoneNumbererrorMsg: UILabel!
    
    @IBOutlet weak var passportIssuecountryErrMsg: UILabel!
    
    @IBOutlet weak var passportNumberError: UILabel!
    
    @IBOutlet weak var passwordErrMsg: UILabel!
    
    @IBOutlet weak var confirmPassErrMsg: UILabel!
    
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
        shadowview.layer.cornerRadius = 10
        shadowview.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        shadowview.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        shadowview.layer.shadowRadius = 1.7
        shadowview.layer.shadowOpacity = 0.45
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
        
        var c1 = 0
        var c2 = 0
        var c3 = 0
        var c4 = 0
        var c5 = 0
        var c6 = 0
        var c7 = 0
        var c8 = 0
        var c9 = 0
    
    //First Name
            if(firstName.text == "")
            {
                firstNameErrorMsg.text = "*Required Field"
                c1 = 1
            }
            else{
                let fname = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]{1,15}")
                if(fname.evaluate(with: firstName.text) != true)
                {
                    firstNameErrorMsg.text = "*Invalid"
                    c1 = 1
                }
                else{
                    c1 = 0
                }
            }
    //Last Name
            if(lastname.text == "")
            {
                lastNameErrorMsg.text = "*Required Field"
                c2 = 1
            }
            else{
                let lname = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z]{1,15}")
                if(lname.evaluate(with: lastname.text) != true)
                {
                    lastNameErrorMsg.text = "*Invalid"
                    c2 = 1
                }
                else{
                    c2 = 0
                }
            }
            
    //Date of birth
            if(dateofbirth.text == "")
            {
                dateOfBirthErrorMsg.text = "*Required Field"
                c3=1
            }
            else{
                let testDOB = NSPredicate(format: "SELF MATCHES %@", "[0-9]{2}+[/]+[0-9]{2}+[/]+[0-9]{4}")
                if(testDOB.evaluate(with: dateofbirth.text) != true)
                {
                    dateOfBirthErrorMsg.text = "*Invalid"
                    c3=1
                }
                else{
                    c3=0
                }
            }
            
    //Email ID
            if(emailIdOutlet.text == "")
            {
                emailIDErr.text = "*Required Field"
                c4=1
            }
            else{
                let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
                      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
                if(testEmail.evaluate(with: emailIdOutlet.text) != true)
                {
                    emailIDErr.text = "*Invalid"
                    c4=1
                }
                else{
                    c4=0
                }
            }
            
    // Phone Number
            if(phonenumber.text == "")
            {
                phoneNumbererrorMsg.text = "*Required Field"
                c5=1
            }
            else{
                if(phonenumber.text?.count != 10)
                {
                    phoneNumbererrorMsg.text = "*Not Valid"
                    c5=1
                }
                else{
                    let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", "[0-9]{10}")
                    if(phoneNumberTest.evaluate(with: phonenumber.text) != true)
                    {
                        phoneNumbererrorMsg.text = "*Invalid"
                        c5=1
                    }
                    else{
                        c5=0
                    }
                    
                }
            }
            
    // Password
            
            if(password.text == "")
            {
                passwordErrMsg.text = "*Required Field"
                c6=1
            }
            else{
                let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{5,}")
                if(passwordTest.evaluate(with: password.text) != true)
                {
                    passwordErrMsg.text = "*Invalid"
                    c6=1
                }
                else{
                    c6=0
                }
            }
            
    //Confirm Password
            
            if(confirmpassword.text == "")
            {
                confirmPassErrMsg.text = "*Required Field"
                c7=1
            }
            else{
                if(password.text != confirmpassword.text)
                {
                    confirmPassErrMsg.text = "*Doesn't Match"
                    c7=1
                }
                else{
                    c7=0
                }
            }
            
            if(passportnumber.text == "")
            {
                passportNumberError.text = "*Required Field"
                c8=1
            }
        else
        {
            c8=0
        }
            if(homecountry.text == "")
            {
                passportIssuecountryErrMsg.text = "*Required Field"
                c9=1
            }
        else{
            c9=0
        }
        if(c1==0 && c2==0 && c3==0 && c4==0 && c5==0 && c6==0 && c7==0 && c8==0 && c9==0)
        {
           postData();
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
                        
                        let alert = UIAlertController(title: "", message: "Registration Successful", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
                            let storyboard = UIStoryboard(name : "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Login")
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        
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
    
    @IBAction func emailClicked(_ sender: Any) {
        emailIDErr.text = ""
    }
    
    

    @IBAction func referPassword(_ sender: UIButton) {
        let uialert = UIAlertController( title: "", message: "Password must contain 1 Uppercase character, 1 Lowercase character, 1 number, 1 Special character ", preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
    
    @IBAction func loginclicked2(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    
}
