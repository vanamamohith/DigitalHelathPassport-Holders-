//
//  CovidReportSearchViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/15/22.
//

import UIKit
import PDFKit

struct FileResponse: Codable {
    var url : String?
}

class CovidReportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var str : String?
    var tokee : String?
    var user: User? = nil
    var token: String = ""
    var txs: [Transactions] = []
    
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
    var linksDisplay : [String] = []
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = linksDisplay[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadData()
    }
    
    func display()
    {
        let reqURL = links[(tableView.indexPathForSelectedRow?.row)!]
        let pdfview = PDFViewController()
        //pdfview.pfdfURL = self.pdfUrl
        pdfview.pfdfURL = URL(string: reqURL)
        self.present(pdfview, animated: true, completion: nil)
        
    }
    
    func loadData()
    {
        let userid = user?._id ?? ""
       let reqURL = links[(tableView.indexPathForSelectedRow?.row)!]
        //let reqURL = "https://dhp-server.herokuapp.com/api/holder/transaction/2ccc86adf6130d3bcaa8a3425f67216a34087cc8fa51dd11ab461d74c2f418f3/625f61a70a93881dc1d88408"
        print(reqURL)
        // 1) create URL
        guard let url = URL(string:reqURL) else { fatalError("error with URL ")}
        // 2) create request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("Bearer \(tokee!)", forHTTPHeaderField: "Authorization")
        // 3) create data task with closures
        let dataTask = URLSession.shared.dataTask(with: httpRequest) {( data, response, Error) in
            
            // 3.1) null check
            guard let data = data else {return }
         
            // 3.2) parsing the JSON to struct
            do {
                let decoded = try JSONDecoder().decode(FileResponse.self, from: data);
                DispatchQueue.main.async {
                    print("Hello:   \(decoded.url!)")
                    let pdfview = PDFViewController()
                    //pdfview.pfdfURL = self.pdfUrl
                    pdfview.pfdfURL = URL(string: decoded.url!)
                    self.present(pdfview, animated: true, completion: nil)
                }
               
            } catch let error {
                print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
//                let pdfview = PDFViewController()
//                pdfview.pfdfURL = URL(string: reqURL)
//                self.present(pdfview, animated: true, completion: nil)
            }
        }
        // 4) make an API call
        dataTask.resume()
    }
    
    
    var links : [String] = []
    var link2 : [String] = []
    
    @IBOutlet weak var sideViewConstraint: NSLayoutConstraint!
    
    var isClicked = true
    var clicked = true
    
    
    @IBOutlet weak var personConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startDateUIText: UITextField!
    
    @IBOutlet weak var endDateUIText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeOutlet.text = "\(dhpID!)"

        tableView.delegate = self
        tableView.dataSource = self
        
        personConstraint.constant = 210
        sideViewConstraint.constant = -240
        
        
    }
    
    
    @IBAction func startDateTyping(_ sender: Any) {
    }
    
    @IBAction func navclicked(_ sender: Any) {
        
        if(clicked == false)
        {
            personConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func personClicked(_ sender: Any) {
        
        if(isClicked == false)
        {
            sideViewConstraint.constant = -240
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
    
    
    
    @IBAction func endDateTyping(_ sender: Any) {
    }
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        link2 = self.links
    }
    
    @IBAction func startDateSearch(_ sender: Any) {
    }
    
    @IBAction func endDateSearch(_ sender: Any) {
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func personInfo(_ sender: Any) {
        sideViewConstraint.constant = -240
        
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
    
    @IBAction func changePass(_ sender: Any) {
        
        sideViewConstraint.constant = -240
        
        
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
    
    @IBAction func signOut(_ sender: Any) {
        sideViewConstraint.constant = -240
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func homeClicked(_ sender: Any) {
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
    
    @IBAction func qrClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "first") as! QRViewController
        controller.text1 = "https://dhp-server.herokuapp.com/api/verifier/transaction/2ccc86adf6130d3bcaa8a3425f67216a34087cc8fa51dd11ab461d74c2f418f3/625f61a70a93881dc1d88408"
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
    
    @IBAction func covidTestReportClicked(_ sender: Any) {
        if(clicked == false)
        {
            personConstraint.constant = 210
        }
        
        isClicked = !isClicked
        if isClicked
        {
            sideViewConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            sideViewConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
