//
//  OtherVaccinationViewController.swift
//  SignupAndLogin
//
//  Created by student on 5/30/22.
//

import UIKit

class OtherVaccinationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var isOpen = false
    var LatesttxId: String? = ""
    
    var str : String?
    var tokee: String = ""
    var user: User? = nil
    var token: String = ""
    var txs: [Transaction] = []
    var othtestlist: [Transaction] = []
    var tx: Transaction? = nil
    var covidlists: [Transaction] = []
    
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
    var txId: String? = ""
    var num = 1
    var testlist: [Transaction] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HomeViewController.othtestlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = otherVaccineTable.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        
        cell.textLabel?.text = HomeViewController.othtestlist[indexPath.row].info?.report
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextPage()
    }
    
    func nextPage()
    {
        //CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController
        controller.fname = fname
        controller.lname = lname
        controller.dob = dob
        controller.passNum = passNum
        controller.issuedCountry = issuedCountry
        controller.phNum = phNum
        controller.mailId = mailId
        controller.user = user
        controller.token  = tokee
        controller.dhpID = dhpID
        controller.tokee = tokee
        controller.txId = txId
        controller.LatesttxId = LatesttxId
        controller.tx = HomeViewController.othtestlist[(otherVaccineTable.indexPathForSelectedRow?.row)!]
        
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var otherVaccineTable: UITableView!
    
    
    @IBOutlet weak var leftIcon: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var rightIcon: NSLayoutConstraint!
    
    
    @IBOutlet weak var welcomeMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //postData()
        welcomeMsg.text = "DHP ID: \(dhpID!)"

        otherVaccineTable.dataSource = self
        otherVaccineTable.delegate = self
        
        leftIcon.constant = -240
        rightIcon.constant = -210
        
    }
    var isClicked = true
    var sClicked = true
    
    @IBAction func leftIconClicked(_ sender: Any) {
        if(sClicked == false)
        {
            rightIcon.constant = -210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            leftIcon.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            leftIcon.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func rightIconClicked(_ sender: Any) {
        if(isClicked == false)
        {
            leftIcon.constant = -240
        }
        
        sClicked = !sClicked
        if sClicked
        {
            rightIcon.constant = -210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            rightIcon.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    

    @IBAction func homeClicked(_ sender: Any) {
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
        controller.tokee = tokee
        controller.user = user
        controller.txId = txId
        controller.LatesttxId = LatesttxId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    

    @IBAction func qrClicked(_ sender: Any) {
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        if(HomeViewController.qrlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No QR Code", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        controller.LatesttxId = LatesttxId
        controller.othtestlist = HomeViewController.othtestlist
        controller.txId = txId
        controller.dhpID = dhpID
        controller.tokee = tokee
        controller.txs = txs
        controller.user = user
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.testlist = self.testlist
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func covidTestClicked(_ sender: Any) {
        HomeViewController.isCovidTest = 1
        if(CovidReportSearchViewController.testlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid test Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.othtestlist = othtestlist
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.txId = self.txId
        controller.user = self.user
        controller.LatesttxId = LatesttxId
        controller.tokee = tokee
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func covidVaccinationClicked(_ sender: Any) {
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
        controller.tokee = tokee
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
    }
    
    @IBAction func personIconClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PersonalInfo") as! PersonalInfoViewController
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.txId = self.txId
        controller.user = self.user
        controller.LatesttxId = LatesttxId
        controller.tokee = tokee
        controller.othtestlist = othtestlist
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
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
