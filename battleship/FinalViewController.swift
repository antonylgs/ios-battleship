//
//  FinalViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBAction func goToHomeClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    @IBOutlet weak var resultLabel: UILabel!
    var win: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
    }
    
    func showResult () {
        if (win) {
            resultLabel.text = "You have won!"
        } else {
            resultLabel.text = "You have lost..."
        }
    }
}
