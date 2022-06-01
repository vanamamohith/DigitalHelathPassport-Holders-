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
    var LatesttxId: String? = ""
    var othtestlist: [Transaction] = []
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
    var user: User? = nil
    var txs: [Transaction] = []
    var tokee: String = ""
    var txId: String? = ""
    var testlist: [Transaction] = []
    
    
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
        
        welcomeOutlet.text = "DHP ID: \(dhpID!)"
        
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
        HomeViewController.count = HomeViewController.count + 1
        let controller = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController

        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.tokee = self.tokee
        controller.user = self.user
        controller.txs = self.txs
        controller.txId = self.txId
        controller.testlist = self.testlist
        controller.LatesttxId = LatesttxId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func QRCodeClicked(_ sender: UIButton) {
        if(HomeViewController.qrlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No QR Code", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        controller.othtestlist = othtestlist
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.tokee = self.tokee
        controller.user = self.user
        controller.txs = self.txs
        controller.txId = self.txId
        controller.testlist = self.testlist
        controller.LatesttxId = LatesttxId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func covidTestClicked(_ sender: UIButton) {
        HomeViewController.isCovidTest = 1
        if(CovidReportSearchViewController.testlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid test Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        controller.othtestlist = othtestlist
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.tokee = self.tokee
        controller.user = self.user
        controller.LatesttxId = LatesttxId
        controller.txId = txId
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func vaccineClicked(_ sender: Any) {
        HomeViewController.isCovidTest = 2
        HomeViewController.vaccineCount = HomeViewController.vaccineCount + 1
        if(HomeViewController.vaccinelist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController
        controller.othtestlist = othtestlist
        controller.user = user
        controller.token  = tokee
        controller.dhpID = dhpID
        controller.txs = txs
        controller.token = tokee
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.LatesttxId = LatesttxId
        controller.tx = HomeViewController.vaccinelist[HomeViewController.vaccinelist.count-1]
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func otherVaccinationClicked(_ sender: Any) {
        HomeViewController.isCovidTest = 3
        if(HomeViewController.othtestlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Other Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherVaccinationViewController
        controller.othtestlist = othtestlist
        controller.user = user
        controller.tokee  = tokee
        controller.dhpID = dhpID
        controller.txs = txs
        controller.token = tokee
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.LatesttxId = LatesttxId
        controller.txId = txId
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
        
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
    
    
    @IBAction func signOutClicked(_ sender: UIButton) {
        sideBarConstarint.constant = -240
        HomeViewController.count = 0
        HomeViewController.otherCount = 0
        HomeViewController.vaccineCount = 0
        CovidReportSearchViewController.covidCount = 0
        HomeViewController.othtestlist.removeAll()
        HomeViewController.vaccinelist.removeAll()
        HomeViewController.qrlist.removeAll()
        CovidReportSearchViewController.testlist.removeAll()
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}
