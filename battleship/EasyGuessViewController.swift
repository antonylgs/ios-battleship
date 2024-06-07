//
//  EasyGuessViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class EasyGuessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boatCoordRemaining = boatCoord
        remainingMissiles.text = "\(missilesCount) missiles remaining"
        if (timer) {
            timerLabel.text = "\(timeRemaining) seconds left"
            startTimer()
        }
    }
    
    var boatCoord: [Int] = []
    var boatCoordRemaining: [Int] = []
    var timer: Bool = false
    
    @objc func updateTimer() {
            if timeRemaining > 0 {
                timeRemaining -= 1
                timerLabel.text = "\(timeRemaining) seconds left"
            } else {
                runningTimer?.invalidate()
                runningTimer = nil
                timerLabel.text = ""
                self.performSegue(withIdentifier: "goToFinal", sender: self)
            }
        }
    
    var runningTimer: Timer?
        var timeRemaining: Int = 15
    
    func startTimer() {
            runningTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    
    func stopTimer() {
            runningTimer?.invalidate()
            runningTimer = nil
        }
    
    let rows = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
    
    var selectedCells: [Int] = []
    var selectedCellsElements: [UIButton] = []
    
    var missilesCount = 6
    var win = false
    
    func buttonClicked(_ id: Int, sender: UIButton) {
        
        if (selectedCells.contains(id)) {
            return
        }
        
        selectedCells.append(id)
        selectedCellsElements.append(sender)
        
        missilesCount -= 1
        
        remainingMissiles.text = "\(missilesCount) missiles remaining"
        
        if ((boatCoordRemaining.firstIndex(of: id)) != nil) {
            let index = (boatCoordRemaining.firstIndex(of: id))!
            boatCoordRemaining.remove(at: index)
            sender.backgroundColor = UIColor.systemGreen
        } else if (isCloseToBoatCoord(id: id, boatCoord: boatCoord, rows: rows)) {
            sender.backgroundColor = UIColor.systemOrange
        } else {
            sender.backgroundColor = UIColor.systemRed
        }
        
        if (boatCoordRemaining.count == 0) {
            if runningTimer != nil {
                        stopTimer()
                        timerLabel.text = ""
                    }
            win = true
            self.performSegue(withIdentifier: "goToFinal", sender: self)
        }
        
        if (missilesCount == 0) {
            if runningTimer != nil {
                        stopTimer()
                        timerLabel.text = ""
                    }
            self.performSegue(withIdentifier: "goToFinal", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToFinal") {
            let destinationVC = segue.destination as! FinalViewController
            destinationVC.win = win
        }
    }
    
    func isCloseToBoatCoord(id: Int, boatCoord: [Int], rows: [[Int]]) -> Bool {
        var rowIndex: Int?
        var colIndex: Int?
        
        for (i, row) in rows.enumerated() {
            if let j = row.firstIndex(of: id) {
                rowIndex = i
                colIndex = j
                break
            }
        }
        
        guard let row = rowIndex, let col = colIndex else {
            return false
        }
        
        let adjacentCells = [
            (row - 1 >= 0 ? rows[row - 1][col] : nil),
            (row + 1 < rows.count ? rows[row + 1][col] : nil),
            (col - 1 >= 0 ? rows[row][col - 1] : nil),
            (col + 1 < rows[row].count ? rows[row][col + 1] : nil)
        ]
        
        for cell in adjacentCells {
            if let cell = cell, boatCoord.contains(cell) {
                return true
            }
        }
        
        return false
    }
    
    @IBAction func button1Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button2Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button3Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button4Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button5Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button6Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button7Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button8Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button9Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button10Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button11Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button12Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button13Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button14Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button15Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button16Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button17Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button18Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button19Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button20Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button21Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button22Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button23Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button24Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBAction func button25Clicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    
    @IBOutlet weak var remainingMissiles: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
}
