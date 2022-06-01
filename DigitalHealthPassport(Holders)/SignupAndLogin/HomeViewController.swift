//
//  HomeViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/18/22.
//

import UIKit
import Foundation

struct Transaction: Codable {
    let _id, transaction_id, issuer_id, holder_id, serviceType: String?
    let createdAt, updatedAt: String?
    let __v: Int?
    var info: Info?

}

struct Info: Codable {
    let reportType, name, report, by, fullname, serviceType, serviceName, contact, eligibleToFly: String?

}


class HomeViewController: UIViewController{
    
    var str : String?
    var tokee : String = ""
    
    static var isCovidTest = 0
    
    var vacc = 0
    var covid = 0
    var qr = 0
    static var count = 0
    static var vaccineCount = 0
    
    var txs: [Transaction] = []
    
    var testlist: [Transaction] = []
    
    static var vaccinelist: [Transaction] = []
    
    static var qrlist: [Transaction] = []
    
    static var othtestlist: [Transaction] = []

    
    var links : [String] = []
    
    var LatesttxId: String? = ""
    
    var vaccineLink : [String] = []
    
    
    var isClicked = true
    
    var sClicked = true
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
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
    static var otherCount = 0
    
    @IBOutlet weak var sideViewControl: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeOutlet.text = "DHP ID: \(dhpID!)"
        sideViewControl.constant = -240
        personIconConstraint.constant = 210
        
        print(HomeViewController.vaccinelist.count)
        print(testlist.count)
        print(HomeViewController.qrlist.count)
        
        if(HomeViewController.count == 0)
        {
        QRcodefunc()
        }
        
        if(HomeViewController.vaccineCount == 0)
        {
        postVaccinationData()
        }
        if(HomeViewController.otherCount == 0)
        {
            otherPostData()
        }
        if(CovidReportSearchViewController.covidCount == 0)
        {
        postData()
        }
        

    }
    
    
    
    
    @IBOutlet weak var personIconConstraint: NSLayoutConstraint!
    
    
    
    @IBAction func iconClicked(_ sender: Any) {
        
        if(isClicked == false)
        {
            sideViewControl.constant = -240
        }
        
        sClicked = !sClicked
        if sClicked
        {
            personIconConstraint.constant = 210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            personIconConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func personalInfoClicked(_ sender: Any) {
        
        sideViewControl.constant = -240
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        let controller = storyboard?.instantiateViewController(withIdentifier: "PersonalInfo") as! PersonalInfoViewController
        controller.othtestlist = HomeViewController.othtestlist
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.dhpID = self.dhpID
        controller.testlist = self.testlist
        controller.user = self.user
        controller.tokee = tokee
        if(HomeViewController.count == 0)
        {
            if(HomeViewController.qrlist.count != 0)
            {
            controller.LatesttxId = HomeViewController.qrlist[HomeViewController.qrlist.count-1].transaction_id
            }
        }
        else{
            controller.LatesttxId = LatesttxId
        }
        controller.txId = txId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
    
    @IBAction func singOutClicked(_ sender: Any) {
        
        sideViewControl.constant = -240
        HomeViewController.count = 0
        HomeViewController.otherCount = 0
        HomeViewController.vaccineCount = 0
        CovidReportSearchViewController.covidCount = 0
        HomeViewController.qrlist.removeAll()
        HomeViewController.othtestlist.removeAll()
        HomeViewController.vaccinelist.removeAll()
        CovidReportSearchViewController.testlist.removeAll()
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)

    }
    
    
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewControl.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewControl.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    var txId: String? = ""
    
    @IBAction func QRCodeClicked(_ sender: Any) {
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        
        if(HomeViewController.qrlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No QR Code", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        
        if(HomeViewController.count == 0)
        {
            controller.LatesttxId = HomeViewController.qrlist[HomeViewController.qrlist.count-1].transaction_id
        }
        else{
            controller.LatesttxId = LatesttxId
        }
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


    
    
    
    @IBAction func covidReportClicked(_ sender: UIButton) {
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        HomeViewController.isCovidTest = 1
        CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        if(CovidReportSearchViewController.testlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid test Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "covidreportsList") as! CovidReportSearchViewController
        controller.othtestlist = HomeViewController.othtestlist
        controller.links = self.links
        controller.fname = self.fname
        controller.lname = self.lname
        controller.dob = self.dob
        controller.passNum = self.passNum
        controller.issuedCountry = self.issuedCountry
        controller.phNum = self.phNum
        controller.mailId = self.mailId
        controller.user = self.user
        controller.dhpID = self.dhpID
        controller.tokee = self.tokee
        controller.str = self.str
        //controller.testlist = self.testlist
        if(HomeViewController.count == 0)
        {
            if(HomeViewController.qrlist.count != 0)
            {
            controller.LatesttxId = HomeViewController.qrlist[HomeViewController.qrlist.count-1].transaction_id
            }
        }
        else{
            controller.LatesttxId = LatesttxId
        }
        controller.txId = txId

        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        }
        
        
    }

    
    
    
    
    
    
    @IBAction func navClicked(_ sender: UIButton) {
                
        if(sClicked == false)
        {
            personIconConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewControl.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewControl.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
  
    @IBAction func vaccinationButton(_ sender: Any) {
        HomeViewController.isCovidTest = 2
        HomeViewController.vaccineCount = HomeViewController.vaccineCount + 1
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        //postVaccinationData()
        if(HomeViewController.vaccinelist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Covid Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "viewC") as! ReportViewController

        controller.othtestlist = HomeViewController.othtestlist
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
        controller.tx = HomeViewController.vaccinelist[HomeViewController.vaccinelist.count-1]
        if(HomeViewController.count == 0)
        {
            if(HomeViewController.qrlist.count != 0)
            {
            controller.LatesttxId = HomeViewController.qrlist[HomeViewController.qrlist.count-1].transaction_id
            }
        }
        else{
            controller.LatesttxId = LatesttxId
        }
        controller.txId = txId
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func otherVaccinationClicked(_ sender: Any) {
        
        HomeViewController.isCovidTest = 3
        
        HomeViewController.vaccineCount = HomeViewController.vaccineCount + 1
        HomeViewController.otherCount = HomeViewController.otherCount + 1
        CovidReportSearchViewController.covidCount = CovidReportSearchViewController.covidCount + 1
        
        if(HomeViewController.othtestlist.count == 0)
        {
            let uialert = UIAlertController( title: "", message: "No Other Vaccination Record", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else
        {
        let controller = storyboard?.instantiateViewController(withIdentifier: "other") as! OtherVaccinationViewController
        controller.othtestlist = HomeViewController.othtestlist
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
        if(HomeViewController.count == 0)
        {
            if(HomeViewController.qrlist.count != 0)
            {
            controller.LatesttxId = HomeViewController.qrlist[HomeViewController.qrlist.count-1].transaction_id
            }
                
        }
        else{
            controller.LatesttxId = LatesttxId
        }
        controller.txId = txId
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    var user: User? = nil
    var token: String = ""
    
    func QRcodefunc()
    {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    
                    self.qr = 1
                    self.qrfunc()
                    

                }
               
            } catch let error {
                //print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
            }
        }
        // 4) make an API call
        dataTask.resume()
        
        
    }
    
    func qrfunc()
    {
        var n = txs.count-1
        
        if(qr == 0)
        {
            let uialert = UIAlertController( title: "", message: "No File Found", preferredStyle: UIAlertController.Style.alert)
                        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(uialert, animated: true, completion: nil)
        }
        else{
        
        for i in 0...n{

            if(txs[i].info?.report == "covid-report"){
                HomeViewController.qrlist.append(txs[i])
                print("***")
                print(txs[i].transaction_id)
            }
        }
        
        }
        
    }

    
    func postVaccinationData()
    {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async {
                    self.txs = decoded
                    print("**********")
                    
                    self.vacc = 1
                    self.vdata()
                    

                }
               
            } catch let error {
                //print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
            }
        }
        // 4) make an API call
        dataTask.resume()
        
    }

    func vdata()
    {
        var n = txs.count-1
        
        
        for i in 0...n{

            if(txs[i].info?.report == "vaccination" || txs[i].info?.report == "covid-vaccination"){
                HomeViewController.vaccinelist.append(txs[i])
                print("***")
            }
        }
    }

    
    


    func otherPostData()
    {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        print("**Other Vaccination**")
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async { [self] in
                    self.txs = decoded
                    self.ocdata()
                    
                }
               
            } catch let error {
                print("*****")
                print("No File Found")
            }

        }
        dataTask.resume()
        
    }
    
    func ocdata()
    {
        var n = txs.count-1

        var cnt = 0
        
        for i in 0...n{

            if(txs[i].info?.report != "covid-report" && txs[i].info?.report != "covid-vaccination" && txs[i].info?.report != "vaccination"){
                HomeViewController.othtestlist.append(txs[i])
                print(txs[i].transaction_id)
                cnt = cnt + 1
            }
            
        }
        
        
    }
    
    func postData() {
        txs = []
        let userid = user?._id ?? ""
        let reqURL = "https://dhp-server.herokuapp.com/api/holder/search/all/\(userid)"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee)", forHTTPHeaderField: "Authorization")
       
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode([Transaction].self, from: data);
                DispatchQueue.main.async { [self] in
                    self.txs = decoded
                    self.cdata()
                    
                }
               
            } catch let error {
                //print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
            }

        }
        // 4) make an API call
        dataTask.resume()
        
    }
    
    func cdata()
    {
        var n = txs.count-1

        for i in 0...n{

            if(txs[i].info?.report == "covid-report"){
                CovidReportSearchViewController.testlist.append(txs[i])
                print("*****")
                print(txs[i].transaction_id)
            }
            
        }
        
        
    }
    
    
    
    
}

