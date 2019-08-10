//
//  ViewController.swift
//  CatchTheHasanAli
//
//  Created by Hasan Ali on 11.08.2019.
//  Copyright © 2019 Hasan Ali Şişeci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var hasanaliArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var hasanali1: UIImageView!
    @IBOutlet weak var hasanali2: UIImageView!
    @IBOutlet weak var hasanali3: UIImageView!
    @IBOutlet weak var hasanali4: UIImageView!
    @IBOutlet weak var hasanali5: UIImageView!
    @IBOutlet weak var hasanali6: UIImageView!
    @IBOutlet weak var hasanali7: UIImageView!
    @IBOutlet weak var hasanali8: UIImageView!
    @IBOutlet weak var hasanali9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore : \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore : \(highScore)"
        }
        
        //Images
        hasanali1.isUserInteractionEnabled = true
        hasanali2.isUserInteractionEnabled = true
        hasanali3.isUserInteractionEnabled = true
        hasanali4.isUserInteractionEnabled = true
        hasanali5.isUserInteractionEnabled = true
        hasanali6.isUserInteractionEnabled = true
        hasanali7.isUserInteractionEnabled = true
        hasanali8.isUserInteractionEnabled = true
        hasanali9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        hasanali1.addGestureRecognizer(recognizer1)
        hasanali2.addGestureRecognizer(recognizer2)
        hasanali3.addGestureRecognizer(recognizer3)
        hasanali4.addGestureRecognizer(recognizer4)
        hasanali5.addGestureRecognizer(recognizer5)
        hasanali6.addGestureRecognizer(recognizer6)
        hasanali7.addGestureRecognizer(recognizer7)
        hasanali8.addGestureRecognizer(recognizer8)
        hasanali9.addGestureRecognizer(recognizer9)

        hasanaliArray = [hasanali1, hasanali2, hasanali3, hasanali4, hasanali5,
                         hasanali6, hasanali7, hasanali8, hasanali9]
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown
            ), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(countDown
            ), userInfo: nil, repeats: true)
        
        hideHasanAli()
    }
    
    @objc func hideHasanAli() {
        for hasanAli in hasanaliArray {
            hasanAli.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(hasanaliArray.count-1)))
        hasanaliArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for hasanAli in hasanaliArray {
                hasanAli.isHidden = true
            }
            
            // HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // replay func
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideHasanAli), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
   

}

