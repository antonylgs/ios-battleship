//
//  EasyViewController.swift
//  battleship
//
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class EasyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    Button to return to home
    @IBAction func goHomeClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
//    If there is a timer or not in order to pass it down
    var timer: Bool = false
    var soloGame: Bool = false
    
//    When clicking the validate button go to easy guess
    @IBAction func validateButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToEasyGuess", sender: self)
    }

//    When reset button clicked revert back to selected cells to default and empty the array
    @IBAction func resetClicked(_ sender: Any) {
        selectedCells = []
        resetButton.isEnabled = false
        resetButton.tintColor = UIColor.systemGray3
        validateButton.isEnabled = false
        validateButton.tintColor = UIColor.systemGray3
        selectedCellsElements.forEach { button in
                button.backgroundColor = UIColor.clear
            }
        selectedCellsElements = []
    }
    
//    Array containing the rows with the cells inside in order to use it inside the function to know if it's a possible boat (cells should be close together and inline)
    let rows = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
    let boatRequiredSize = 3
    
    var selectedCells: [Int] = []
    var selectedCellsElements: [UIButton] = []
    
    
//    When a cell is clicked
    func buttonClicked(_ id: Int, sender: UIButton) {
        
        if (soloGame) {
            return
        }
        
//        If boat already the biggest size
        if (selectedCells.count == boatRequiredSize) {
            return
        }
        
        if (selectedCells.contains(id)) {
            return
        }
        
        validateButton.tintColor = UIColor.opaqueSeparator
        
//        For the first click no need for verification
        if selectedCells.isEmpty {
            selectedCells.append(id)
            selectedCellsElements.append(sender)
            sender.backgroundColor = UIColor.systemGray6
        } else {
//            If it's not the first selected cell then verify it's a valid one (close to the first ones and making a straight line)
            if isValidMove(cellId: id,rows: rows, selectedCells: selectedCells) {
                    selectedCells.append(id)
                selectedCellsElements.append(sender)
                sender.backgroundColor = UIColor.systemGray6
                }
        }
        
//        Activate the reset button
        if(selectedCells.count > 0) {
            resetButton.isEnabled = true
            resetButton.tintColor = UIColor.systemBlue
        }
        
//        Disable reset button
        if(selectedCells.count == 0) {
            resetButton.isEnabled = false
            resetButton.tintColor = UIColor.systemGray3
        }
        
//        Activate validate button
        if (selectedCells.count == boatRequiredSize) {
            validateButton.isEnabled = true
            validateButton.tintColor = UIColor.systemBlue
        } else {
//            Deactivate validate button
            validateButton.isEnabled = false
            validateButton.tintColor = UIColor.systemGray3
        }
        
    }
    
//    The arguments to give to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEasyGuess") {
            let destinationVC = segue.destination as! EasyGuessViewController
            destinationVC.boatCoord = selectedCells
            destinationVC.timer = timer
        }
    }
    
//    Function to know if the clicked cell is a current cell and will form or not a valid boat form
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
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            buttonClicked(Int(buttonTitle)!, sender: sender)
            }
    }
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
}


