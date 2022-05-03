//
//  ChangePasswordViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/25/22.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    //********************************
    //retreve data from signup
    var fname : String?
    var lname : String?
    var dob : String?
    var phNum : String?
    var passNum : String?
    var issuedCountry : String?
    var mailId : String?
    var dhpID : String?
    //*********************************
    
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    @IBOutlet weak var OldPassLabel: UILabel!
    
    @IBOutlet weak var newPassLabel: UILabel!
    
    
    @IBOutlet weak var confirmPassLabel: UILabel!
    
    
    @IBOutlet weak var oldPassOutlet: UITextField!
    
    
    @IBOutlet weak var newPassOutlet: UITextField!
    
    
    @IBOutlet weak var confirmPassOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPassOutlet.isSecureTextEntry = true
        newPassOutlet.isSecureTextEntry = true
        confirmPassOutlet.isSecureTextEntry = true
        
        welcomeOutlet.text = "\(dhpID!)"
        sideBarConstraint.constant = -240
        
        personConstraint.constant = 210
        
        OldPassLabel.text = ""
        newPassLabel.text = ""
        confirmPassLabel.text = ""

    }
    
    @IBAction func oldPassClicked(_ sender: Any) {
        OldPassLabel.text = ""
    }
    
    @IBAction func newPassClicked(_ sender: Any) {
        newPassLabel.text = ""
    }
    
    @IBAction func confirmClicked(_ sender: Any) {
        confirmPassLabel.text = ""
        
    }
    
    
    @IBAction func submitClicked(_ sender: UIButton) {
        
        var c = 0
        if oldPassOutlet.text == ""{
            OldPassLabel.text = "*Required Field"
            c = c+1}
        if newPassOutlet.text == ""{
            newPassLabel.text = "*Required Field"
            c = c+1}
        if confirmPassOutlet.text == ""{
            confirmPassLabel.text = "*Required Field"
            c=c+1} else {
                if(newPassOutlet.text != confirmPassOutlet.text)
                {
                    confirmPassLabel.text = "*Doesn't match with new Password"
                    c=c+1
                }
            }
        
        if(c==0)
        {
            let uialert = UIAlertController( title: "", message: "Password Changes successfully", preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
        }
    }
    
    
    
    
    @IBOutlet weak var sideBarConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var personConstraint: NSLayoutConstraint!
    
    var clicked = true
    
    var isClicked = true
    
    
    @IBAction func sideBarClicked(_ sender: UIButton) {
        
        if(clicked == false)
        {
            personConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideBarConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideBarConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func personIconCLicked(_ sender: UIButton) {
        
        
        if(isClicked == false)
        {
            sideBarConstraint.constant = -240
        }
        
        clicked = !clicked
        if clicked
        {
            personConstraint.constant = 210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            personConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func QRCodeButtonClicked(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        controller.text1 = "https://arxiv.org/pdf/2005.08922.pdf"
        
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func covidTestButtonClicked(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        //controller.links = self.links
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func personalInfoCLicked(_ sender: Any) {
        sideBarConstraint.constant = -240
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "PersonalInfo") as! PersonalInfoViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func changePAssCLicked(_ sender: UIButton) {
        if(clicked == false)
        {
            personConstraint.constant = -240
        }
        
        clicked = !clicked
        if clicked
        {
            personConstraint.constant = 210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            personConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func signOutClcicked(_ sender: UIButton) {
        
        sideBarConstraint.constant = -240
        
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    
    


}
