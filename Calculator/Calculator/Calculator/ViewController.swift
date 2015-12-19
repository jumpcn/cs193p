//
//  ViewController.swift
//  Calculator
//
//  Created by Buffalo on 15/12/19.
//  Copyright © 2015年 Buffalo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsIntheMiddleOfTypingANumer : Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if (userIsIntheMiddleOfTypingANumer) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsIntheMiddleOfTypingANumer = true
        }
        
        
     //   print("digit = \(digit)");
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsIntheMiddleOfTypingANumer {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    private func performOperation(operation : (Double, Double) -> Double) {
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation : Double -> Double) {
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsIntheMiddleOfTypingANumer = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
    }
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsIntheMiddleOfTypingANumer = false
            
        }
    }
}

