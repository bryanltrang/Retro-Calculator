//
//  ViewController.swift
//  retro-calculator
//
//  Created by Bryan Trang on 4/10/16.
//  Copyright © 2016 Bryan Trang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputlbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundurl = NSURL (fileURLWithPath: path!)
        
        do {
        try buttonSound = AVAudioPlayer(contentsOfURL: soundurl)
        } catch let err as NSError {
        print(err.debugDescription)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberpress(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputlbl.text = runningNumber
        
    }
    
    @IBAction func onDividPress(div: UIButton!) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(multi: UIButton!) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sub: UIButton!) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPress(add: UIButton!) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(equal: UIButton!) {
        processOperation(currentOperation)
    }

    @IBAction func clearButtonPress(clear: UIButton!) {
        playSound()
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        result = ""
        
        outputlbl.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //math

            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }

                leftValString = result
                outputlbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //this is the first time operater is pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op 
        }
    }

    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        } else {
        buttonSound.play()
        }
    }
    
}

