//
//  HardGuessViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class HardGuessViewController: UIViewController {
    
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
    
    let rows = [[0,1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16,17,18,19],[20,21,22,23,24,25,26,27,28,29],[30,31,32,33,34,35,36,37,38,39],[40,41,42,43,44,45,46,47,48,49],[50,51,52,53,54,55,56,57,58,59],[60,61,62,63,64,65,66,67,68,69],[70,71,72,73,74,75,76,77,78,79],[80,81,82,83,84,85,86,87,88,89],[90,91,92,93,94,95,96,97,98,99]]
    
    var selectedCells: [Int] = []
    var selectedCellsElements: [UIButton] = []
    
    var missilesCount = 9
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
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    
    @IBOutlet weak var remainingMissiles: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
}
