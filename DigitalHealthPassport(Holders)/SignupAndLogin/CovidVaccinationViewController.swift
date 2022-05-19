//
//  CovidVaccinationViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/28/22.
//

import UIKit

let data1 = ["Vaccine","1st Dose","2nd Dose","Other"]

class CovidVaccinationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.dataSource = self
        tableOutlet.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data1[indexPath.row]
        
        return cell
    }
    
    

}




