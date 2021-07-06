//
//  ViewController.swift
//  Catch Kenny
//
//  Created by Vincent on 3/7/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var kenny0: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counter = 15
        countDownLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        // High Score check
        let highScoreStored = UserDefaults.standard.object(forKey: "highScore")
        if highScoreStored == nil {
            highScore = 0
            highestScoreLabel.text = "Highest Score: \(highScore)"
        } else {
            let newScore = highScoreStored as! Int
            highScore = newScore
            highestScoreLabel.text = "Highest Score: \(highScore)"
        }
        
        
        kenny0.isUserInteractionEnabled = true
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        
        let recognizer0 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny0.addGestureRecognizer(recognizer0)
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
    }
    
    @objc func increaseScore() {
        score+=1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timerFunction() {
        countDownLabel.text = "\(counter)"
        counter-=1
        if (counter == 0) {
            // Check if it's the highest score
            if (self.score > self.highScore) {
                self.highScore = self.score
                highestScoreLabel.text = "Highest Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            timer.invalidate()
            countDownLabel.text = "Game Over"
            hideAllKenny()
            let alert = UIAlertController(title:"Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 15
                self.countDownLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)

            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            // Show the alert message to user
            self.present(alert, animated: true, completion: nil)
        } else {
            showOneKenny()
        }
        
    }
    
    func hideAllKenny() {
        var kennies = [] as [UIImageView]
        kennies = [kenny0, kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8]
        for i in 0...8 {
            kennies[i].isHidden = true
        }
    }
    
    func showOneKenny() {
        let randomNumber = Int.random(in: 0...8)
        var kennies = [] as [UIImageView]
        kennies = [kenny0, kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8]
        for i in 0...8 {
            if (i == randomNumber) {
                kennies[i].isHidden = false
            } else {
                kennies[i].isHidden = true
            }
        }
    }
}

