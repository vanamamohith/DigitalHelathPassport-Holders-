//
//  selectEmaOrPhoneForgotViewController.swift
//  SignupAndLogin
//
//  Created by student on 3/18/22.
//

import UIKit

class selectEmaOrPhoneForgotViewController: UIViewController {
    
    @IBOutlet weak var checkboxOutlet1: UIButton!
    
    @IBOutlet weak var checkboxOutlet2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkboxClicked1(_ sender: UIButton) {
        checkboxOutlet1.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkboxOutlet2.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
    
    @IBAction func checkboxClicked2(_ sender: UIButton) {
        checkboxOutlet1.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        checkboxOutlet2.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "emailidORPassword")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func submit(_ sender: Any) {
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "password")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
