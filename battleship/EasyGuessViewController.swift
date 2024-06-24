//
//  EasyGuessViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class EasyGuessViewController: UIViewController {
    
//    Set up the number of missiles and the timer if there is one
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
    
//    Update the timer label every second, when it's down to 0 go to the next view
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
    
//    Start the timer with an interval of 1 second
    func startTimer() {
            runningTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    
//    Stop the timer in order to not run any of the update timer properties once the user in on another view (if he wins for example)
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
        
//        Depending on if the user clicks close or far away for the boat the cell color is gonna be different to give the user a hint
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
    
//    Prepare the arguments to send to the final view to know if it's a win or not
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToFinal") {
            let destinationVC = segue.destination as! FinalViewController
            destinationVC.win = win
        }
    }
    
//    Function to determine if the click is close or not to the boat (1 cell away is close, more than that is far away)
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
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    
    @IBOutlet weak var remainingMissiles: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
}
