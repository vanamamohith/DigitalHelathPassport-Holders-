//
//  CovidTestReportViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/25/22.
//

import UIKit

class CovidTestReportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "covidreportsList")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
