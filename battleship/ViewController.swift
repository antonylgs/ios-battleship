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
        if (soloGame.isOn) {
            botPickPlace(boatRequiredSize: 3, rows: [[0,1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16,17,18,19],[20,21,22,23,24,25,26,27,28,29],[30,31,32,33,34,35,36,37,38,39],[40,41,42,43,44,45,46,47,48,49],[50,51,52,53,54,55,56,57,58,59],[60,61,62,63,64,65,66,67,68,69],[70,71,72,73,74,75,76,77,78,79],[80,81,82,83,84,85,86,87,88,89],[90,91,92,93,94,95,96,97,98,99]])
        } else {
            self.performSegue(withIdentifier: "goToHard", sender: self)
        }
    }
    @IBAction func easyButton(_ sender: Any) {
        if (soloGame.isOn) {
            easyMode = true
            botPickPlace(boatRequiredSize: 3, rows: [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]])
        } else {
            self.performSegue(withIdentifier: "goToEasy", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEasy") {
            let destinationVC = segue.destination as! EasyViewController
            destinationVC.timer = timerLimit.isOn
            destinationVC.soloGame = soloGame.isOn
        } else if (segue.identifier == "goToHard") {
            let destinationVC = segue.destination as! HardViewController
            destinationVC.timer = timerLimit.isOn
            destinationVC.soloGame = soloGame.isOn
        } else if (segue.identifier == "goToEasyGuess") {
            let destinationVC = segue.destination as! EasyGuessViewController
            destinationVC.boatCoord = selectedCells
            destinationVC.timer = timerLimit.isOn
        } else if (segue.identifier == "goToHardGuess") {
            let destinationVC = segue.destination as! HardGuessViewController
            destinationVC.boatCoord = selectedCells
            destinationVC.timer = timerLimit.isOn
        }
    }
    
    var selectedCells : [Int] = []
    var easyMode = false

    func botPickPlace (boatRequiredSize: Int, rows: [[Int]]) {
            let id = Int.random(in: 1...25)
            if (selectedCells.contains(id)) {
                botPickPlace(boatRequiredSize: boatRequiredSize, rows: rows)
                return
            }
            
            //        For the first click no need for verification
                    if selectedCells.isEmpty {
                        selectedCells.append(id)
                    } else {
            //            If it's not the first selected cell then verify it's a valid one (close to the first ones and making a straight line)
                        if isValidMove(cellId: id,rows: rows, selectedCells: selectedCells) {
                        selectedCells.append(id)
                    }
            }
        
            
        if (selectedCells.count == boatRequiredSize) {
//            send to the guess view
            if (easyMode == true) {
                self.performSegue(withIdentifier: "goToEasyGuess", sender: self)
            } else {
                self.performSegue(withIdentifier: "goToHardGuess", sender: self)
            }
                
            } else {
                botPickPlace(boatRequiredSize: boatRequiredSize, rows: rows)
                return
            }
        
    }
    
    func isValidMove(cellId: Int, rows: [[Int]], selectedCells: [Int]) -> Bool {
        func getPosition(of id: Int) -> (row: Int, col: Int)? {
            for (rowIndex, row) in rows.enumerated() {
                if let colIndex = row.firstIndex(of: id) {
                    return (row: rowIndex, col: colIndex)
                }
            }
            return nil
        }
        
        if selectedCells.isEmpty {
            return true
        }
        
        guard let newPos = getPosition(of: cellId) else {
            return false
        }
        
        for selectedId in selectedCells {
            guard let selectedPos = getPosition(of: selectedId) else {
                continue
            }
            
            let isAdjacent = (abs(newPos.row - selectedPos.row) == 1 && newPos.col == selectedPos.col) ||
                             (abs(newPos.col - selectedPos.col) == 1 && newPos.row == selectedPos.row)
            
            if isAdjacent {
                var allCells = selectedCells + [cellId]
                allCells.sort()

                let rowsSet = Set(allCells.compactMap { getPosition(of: $0)?.row })
                let colsSet = Set(allCells.compactMap { getPosition(of: $0)?.col })
                
                if rowsSet.count == 1 || colsSet.count == 1 {
                    return true
                }
            }
        }
        
        return false
    }
    
    @IBOutlet weak var timerLimit: UISwitch!
    @IBOutlet weak var soloGame: UISwitch!
}

