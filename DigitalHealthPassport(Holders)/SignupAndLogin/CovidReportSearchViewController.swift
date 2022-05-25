//
//  CovidReportSearchViewController.swift
//  SignupAndLogin
//
//  Created by student on 4/15/22.
//

import UIKit
import PDFKit


class CovidReportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recordLabel: UIButton!
    var isOpen = false
    
    var str : String?
    var tokee: String = ""
    var user: User? = nil
    var token: String = ""
    var txs: [Transaction] = []
    var testlist: [Transaction] = []
    
    var vaccinelist: [Transaction] = []
    var mnt = [1,2,3,4,5,6,7,8,9,10,11,12]
    
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
    var num = 1
    
    @IBOutlet weak var welcomeOutlet: UILabel!
    
    var datess = ["1 Month", "15 Days","5 Days","1 Day"]
    var eachclm:Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return vaccinelist.count
        }
        else{
            return datess.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
          cell.textLabel?.text = "\((vaccinelist[indexPath.row].info?.report)!) - \(num)"
          num = num + 1
          return cell
        }
        else{
            let cell = recordTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = "\(datess[indexPath.row])"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
           nextPage()
        }
        else{
            eachclm = indexPath.row
            recordLabel.setTitle("\(datess[indexPath.row])", for: .normal)
            UIView.animate(withDuration: 0.2){
                self.recordTableViewHC.constant = 0
                self.view.layoutIfNeeded()
            }
            isOpen = false
            
        }
    }
    
    
    func nextPage()
    {
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
        controller.txs = testlist
        controller.tx = vaccinelist[(tableView.indexPathForSelectedRow?.row)!]
        controller.num = (tableView.indexPathForSelectedRow?.row)!
        
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
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
                let decoded = try JSONDecoder().decode(FileResponse.self, from: data);
                DispatchQueue.main.async {
                    print("Hello:   \(decoded.url!)")
                    let pdfview = PDFViewController()
                    pdfview.pfdfURL = URL(string: decoded.url!)
                    self.present(pdfview, animated: true, completion: nil)
                }
               
            } catch let error {
                print("Error in JSON parsing", error)
                print("*****")
                print("No File Found")
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeOutlet.text = "DHP ID: \(dhpID!)"

        tableView.delegate = self
        tableView.dataSource = self
        
        recordTableView.delegate = self
        recordTableView.dataSource = self
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.recordTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        recordTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        personConstraint.constant = 210
        sideViewConstraint.constant = -240
        
        recordTableViewHC.constant = 0
        
        
    }
    
    
    @IBAction func navclicked(_ sender: Any) {
        recordTableViewHC.constant = 0
        isOpen = false
        
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
        recordTableViewHC.constant = 0
        isOpen = false
        
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
    
    
    @IBAction func recordsSearch(_ sender: Any) {
        
        if(!isOpen)
        {
        UIView.animate(withDuration: 0.5){
            self.recordTableViewHC.constant = 44 * 4.0
            self.view.layoutIfNeeded()
        }
            isOpen = true
        }
        else{
            UIView.animate(withDuration: 0.5){
                self.recordTableViewHC.constant = 0
                self.view.layoutIfNeeded()
            }
            isOpen = false
        }
        
    }
    
    
    @IBOutlet weak var recordTableView: UITableView!
    @IBOutlet weak var recordTableViewHC: NSLayoutConstraint!
    
    
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        vaccinelist.removeAll()
        num = 1
        var format = DateFormatter()
        format.dateFormat = "YYYY/MM/dd HH:mm"
        var fmt = format.string(from: Date())
        var dat = "\(fmt)"
        
        for i in 0...testlist.count-1{
        var spli = self.testlist[i].createdAt?.split(separator: "-", maxSplits: 2)
            var x = spli?.removeFirst()//((spli?.removeFirst()) as! NSString).integerValue
            var y = spli?.removeFirst()
        var m = spli?.removeFirst()
        var m1 = m?.split(separator: "T")
            var z = m1?.removeFirst()
            var xyz1 = "\(x!)/\(y!)/\(z!) 00:00"
            let d1 = format.date(from: dat)
            let d2 = format.date(from: xyz1)
            let cal = Calendar.current
            let day1 = cal.dateComponents([.day], from: d2!, to: d1!)
            let month1 = cal.dateComponents([.month], from: d2!, to: d1!)
            let min1 = cal.dateComponents([.minute], from: d2!, to: d1!)
            var day = day1.day!
            var month = month1.month!
            var min = min1.minute!
            print("Days:\(day), Months:\(month), Minutes:\(min), date:\(xyz1)")
            if(eachclm==0)
            {
                if(day<=30)
                {
                  vaccinelist.append(testlist[i])
                }
            }
            else if(eachclm==1)
            {
                if(day<=15)
                {
                    vaccinelist.append(testlist[i])
                }
            }
            else if(eachclm==2)
            {
                if(day<=5)
                {
                    vaccinelist.append(testlist[i])
                }
            }
            else if(eachclm==3)
            {
                if(day<=1)
                {
                    vaccinelist.append(testlist[i])
                }
            }
            
        }
        self.tableView.reloadData()
        
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
        controller.tokee = self.tokee
        controller.user = self.user
        controller.txs = testlist
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
        controller.tokee = self.tokee
        controller.user = self.user
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
        controller.user = self.user
        controller.tokee = self.tokee
        controller.user = self.user
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
        controller.tokee = self.tokee
        controller.user = self.user
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
