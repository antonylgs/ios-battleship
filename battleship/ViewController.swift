//
//  ViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHard", sender: self)
    }
    @IBAction func easyButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToEasy", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEasy") {
            let destinationVC = segue.destination as! EasyViewController
            destinationVC.timer = timerLimit.isOn
        } else if (segue.identifier == "goToHard") {
            let destinationVC = segue.destination as! HardViewController
            destinationVC.timer = timerLimit.isOn
        }
    }
    
    @IBOutlet weak var timerLimit: UISwitch!
}

