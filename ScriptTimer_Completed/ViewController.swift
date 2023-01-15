//
//  ViewController.swift
//  ScriptTimer_Completed
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wordsLabel: UILabel!
    
    @IBOutlet weak var totalWords: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var speed : Float = 1.0
    var timeLeft : Int?
    var estimatedTime : Int?
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageLabel.text = ""
    }

    @IBAction func wordsSelected(_ sender: UISlider) {
        speed = round(sender.value)
        wordsLabel.text = "\(Int(round(sender.value))) words per second"
    }
    
    
    @IBAction func startTimer(_ sender: UIButton) {
        timer.invalidate()
        
        // validate user input
        if isValid(totalWords.text!) {
            messageLabel.text = ""
            
            // estimate time : total words / speed (words per second)
            estimatedTime = Int(Float(totalWords.text!)! / speed)
            timeLeft = estimatedTime
            
            // show progress : timeleft / total time
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
        } else {
            messageLabel.text = "Error"
        }
        
        
    }
    
    func isValid(_ userInput: String) -> Bool {
        // int
        // between 0 and 1200 seconds
        return (Int(userInput) != nil &&
                Int(userInput)! > 0 &&
                Int(userInput)! < 1201)
    }
    
    @objc func startCountDown() {
        if timeLeft! >= 0 {
            messageLabel.text = "\(timeLeft!) seconds remaining!"
            progressView.progress = Float(timeLeft!) / Float(estimatedTime!)
            timeLeft! -= 1
            
        } else {
            // invalidate timer
            timer.invalidate()
        }
    }


}

