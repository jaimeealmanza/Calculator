//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Jaime Almanza on 26/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    
    // MARK: - Outlets and Actions
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        // This limits the input to only 9 characters
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    @IBAction func allClearPressed(_ sender: RoundButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        currentOperation = .zero
        outputLabel.text = "0"
    }
    @IBAction func dotPressed(_ sender: RoundButton) {
        // This makes the input to not be able to end in .
        if runningNumber.count <= 7 {
        runningNumber += "."
        outputLabel.text = runningNumber
        }
    }
    @IBAction func equalPressed(_ sender: RoundButton) {
        performOperation(ofType: currentOperation)
    }
    @IBAction func addPressed(_ sender: RoundButton) {
        performOperation(ofType: .add)
    }
    @IBAction func substractPressed(_ sender: RoundButton) {
        performOperation(ofType: .substract)
    }
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        performOperation(ofType: .multiply)
    }
    @IBAction func dividePressed(_ sender: RoundButton) {
        performOperation(ofType: .divide)
    }
    
    
    // MARK: - Properties
    
    enum Operation: String {
        case add = "+"
        case substract = "-"
        case divide = "/"
        case multiply = "*"
        case zero = "zero"
    }
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .zero
    
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the label to be 0
        outputLabel.text = "0"
    }

    
    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Functions
    
    func performOperation(ofType operation: Operation) {
        if currentOperation != .zero {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                switch currentOperation {
                case .add: result = "\(Double(leftValue)! + Double(rightValue)!)"
                case .substract: result = "\(Double(leftValue)! - Double(rightValue)!)"
                case .multiply: result = "\(Double(leftValue)! * Double(rightValue)!)"
                case .divide: result = "\(Double(leftValue)! / Double(rightValue)!)"
                default: break
                }
                leftValue = result
                // This next if statement is to avoid displaying the result in decimals when it is an Integer
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

