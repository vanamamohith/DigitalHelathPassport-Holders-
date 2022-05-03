//
//  PersonalInfoViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/25/22.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    var sClicked = true
    var isClicked = true
    
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
    
    
    @IBOutlet weak var firstNLastNameOutlet: UILabel!
    
    @IBOutlet weak var dobOutlet: UILabel!
    
    @IBOutlet weak var PhoneNumberOutlet: UILabel!
    
    
    @IBOutlet weak var EmailIDOutlet: UILabel!
    
    @IBOutlet weak var passportNumberOutlet: UILabel!
    
    @IBOutlet weak var countryOutlet: UILabel!
    
    
    @IBOutlet weak var sideBarConstarint: NSLayoutConstraint!
    

    @IBOutlet weak var personConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeOutlet.text = "\(dhpID!)"
        
        firstNLastNameOutlet.text = "\(fname!), \(lname!)"
        dobOutlet.text = dob
        PhoneNumberOutlet.text = phNum
        EmailIDOutlet.text = mailId
        passportNumberOutlet.text = passNum
        countryOutlet.text = issuedCountry
        
        sideBarConstarint.constant = -240
        personConstraint.constant = 210

    }
    
    @IBAction func sideMenuClicked(_ sender: UIButton) {
        if(sClicked == false)
        {
            personConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideBarConstarint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideBarConstarint.constant = 0
            
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
    
    @IBAction func QRCodeClicked(_ sender: UIButton) {
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
    
    @IBAction func covidTestClicked(_ sender: UIButton) {
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
    
    
    
    @IBAction func personIconClicked(_ sender: UIButton) {
        
        if(isClicked == false)
        {
            sideBarConstarint.constant = -240
        }
        
        sClicked = !sClicked
        if sClicked
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
    
    @IBAction func personalInfoClicked(_ sender: UIButton) {
        sClicked = !sClicked
        if sClicked
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
    
    @IBAction func changePasswordClicked(_ sender: UIButton) {
        
        sideBarConstarint.constant = -240
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "changePassword") as! ChangePasswordViewController
        
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
    
    
    
    @IBAction func signOutClicked(_ sender: UIButton) {
        sideBarConstarint.constant = -240
        
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}
