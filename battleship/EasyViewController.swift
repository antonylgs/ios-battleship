//
//  EasyViewController.swift
//  battleship
//
//  Created by antonylgs on 07/06/2024.
//

import UIKit

class EasyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goHomeClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    var timer: Bool = false
    
    @IBAction func validateButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToEasyGuess", sender: self)
    }

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
    
    let rows = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
    let boatRequiredSize = 3
    
    var selectedCells: [Int] = []
    var selectedCellsElements: [UIButton] = []
    
    func buttonClicked(_ id: Int, sender: UIButton) {
        
        if (selectedCells.count == boatRequiredSize) {
            return
        }
        
        validateButton.tintColor = UIColor.opaqueSeparator
        
        if selectedCells.isEmpty {
            selectedCells.append(id)
            selectedCellsElements.append(sender)
            sender.backgroundColor = UIColor.systemGray6
        } else {
            if isValidMove(cellId: id,rows: rows, selectedCells: selectedCells) {
                    selectedCells.append(id)
                selectedCellsElements.append(sender)
                sender.backgroundColor = UIColor.systemGray6
                }
        }
        
        if(selectedCells.count > 0) {
            resetButton.isEnabled = true
            resetButton.tintColor = UIColor.systemBlue
        }
        
        if(selectedCells.count == 0) {
            resetButton.isEnabled = false
            resetButton.tintColor = UIColor.systemGray3
        }
        
        if (selectedCells.count == boatRequiredSize) {
            validateButton.isEnabled = true
            validateButton.tintColor = UIColor.systemBlue
        } else {
            validateButton.isEnabled = false
            validateButton.tintColor = UIColor.systemGray3
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEasyGuess") {
            let destinationVC = segue.destination as! EasyGuessViewController
            destinationVC.boatCoord = selectedCells
            destinationVC.timer = timer
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
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
}


