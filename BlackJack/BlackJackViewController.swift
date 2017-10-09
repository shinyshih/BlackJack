//
//  BlackJackViewController.swift
//  BlackJack
//
//  Created by 施馨檸 on 29/09/2017.
//  Copyright © 2017 施馨檸. All rights reserved.
//

import UIKit
import GameplayKit

class BlackJackViewController: UIViewController {
    
    @IBOutlet var playerCards: [UILabel]!
    @IBOutlet var bankerCards: [UILabel]!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var bankerScoreLabel: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var theOpenButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var chipLabel: UILabel!
    @IBOutlet weak var wagerLabel: UILabel!
    
    var playerCloseCard = ""
    var bankerCloseCard = ""
    var playerOpenCard = ""
    var bankerOpenCard = ""
    
    //    洗牌
    let distribution = GKShuffledDistribution(lowestValue: 0, highestValue: cards.count - 1)
    
    //    分數
    var playerScore = 0
    var bankerScore = 0
    
   
    @IBAction func closeCard(_ sender: Any) {
        print("closeCard")
        playerCards[0].text = "♠︎"
    }
    
    @IBAction func seeCard(_ sender: Any) {
        print("seeCard")
        playerCards[0].text = playerCloseCard
    }
   
    //    發牌
    
    @IBAction func deal(_ sender: Any) {
        // 卡片顯示
        playerCloseCard = cards[distribution.nextInt()]
        playerOpenCard = cards[distribution.nextInt()]
        bankerCloseCard = cards[distribution.nextInt()]
        bankerOpenCard = cards[distribution.nextInt()]

        playerCards[1].text = "\(playerOpenCard)"
        bankerCards[1].text = "\(bankerOpenCard)"
        
        playerCards[0].isHidden = false
        playerCards[1].isHidden = false
        bankerCards[0].isHidden = false
        bankerCards[1].isHidden = false
        
        // 分數
        playerScore += scoreJudgment(card: playerOpenCard)
        playerScoreLabel.text = "\(playerScore)"
        
        playerScore += scoreJudgment(card: playerCloseCard)
        playerScoreLabel.text = "\(playerScore)"
        
        bankerScore += scoreJudgment(card: bankerOpenCard)
        bankerScoreLabel.text = "\(bankerScore)"
        
        // 按鈕狀態
        dealButton.isEnabled = false
        hitButton.isEnabled = true
        theOpenButton.isEnabled = true
        surrenderButton.isEnabled = true
    }
    
    
    
    //    要牌
    var count = 2
    @IBAction func hit(_ sender: UIButton) {
        playerCards[count].isHidden = false
        playerCards[count].text = cards[distribution.nextInt()]
        playerScore += scoreJudgment(card: playerCards[count].text!)
        playerScoreLabel.text = "\(playerScore)"

        count = count + 1
        if count >= 5 {
            count = 0
        }
        
        if playerScore > 21 {
            bust()
            
        }
        
    }
    
    
    //    開牌
    @IBAction func theOpen(_ sender: Any) {
        bankerCards[0].text = bankerCloseCard
        playerCards[0].text = playerCloseCard
        bankerScoreLabel.isHidden = false
        
        bankerScore += scoreJudgment(card: bankerCloseCard)
        bankerScoreLabel.text = "\(bankerScore)"
        
        
        theOpenButton.isEnabled = false
        hitButton.isEnabled = false
        
        if bankerScore < 16 {
            count = 2
            bankerCards[count].isHidden = false
            bankerCards[count].text = cards[distribution.nextInt()]
            bankerScore += scoreJudgment(card: bankerCards[count].text!)
            bankerScoreLabel.text = "\(bankerScore)"
        }
        
        if bankerScore > playerScore {
            lose()
        }
        
        if playerScore > bankerScore {
            win()
        }
        
        
    }
    
    
    //    投降
    @IBAction func surrender(_ sender: Any) {
        playerScore = 0
        playerScoreLabel.text = "\(playerScore)"
        
        
        nextRound()
    }
    
    var chip = 1000
    
    
    
    
    
//    function
    
    //  判斷數字
    func scoreJudgment ( card: String) -> Int {
        var score = 0
        if card.contains("A") {
            score = 1
        } else if card.contains("2") {
            score = 2
        } else if card.contains("3") {
            score = 3
        } else if card.contains("4") {
            score = 4
        } else if card.contains("5") {
            score = 5
        } else if card.contains("6") {
            score = 6
        } else if card.contains("7") {
            score = 7
        } else if card.contains("8") {
            score = 8
        } else if card.contains("9") {
            score = 9
        } else if card.contains("10") {
            score = 10
        } else if card.contains("J") {
            score = 10
        } else if card.contains("Q") {
            score = 10
        } else if card.contains("K") {
            score = 10
        }
        return score
    }
    
    // lose alert
    func lose () {
        let controller = UIAlertController(title: "Game Over", message: "輸了100！", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Next Round", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        show(controller, sender: nil)
        chip = chip - 100
        chipLabel.text = "籌碼：\(chip)"
        
        nextRound()
    }
    
    // win alert
    func win () {
        let controller = UIAlertController(title: "You win", message: "贏了100！", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Next Round", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        show(controller, sender: nil)
        chip = chip + 100
        chipLabel.text = "籌碼：\(chip)"
        
        nextRound()
    }
    
    //  分數爆掉
    func bust() {
        let controller = UIAlertController(title: "You busted", message: "爆了！ \(playerScore)", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        show(controller, sender: nil)
        
        nextRound()
        
    }
    
    //  下一回
    func nextRound () {
        let distribution = GKShuffledDistribution(lowestValue: 0, highestValue: cards.count - 1)
        
        playerCards[0].isHidden = true
        playerCards[1].isHidden = true
        playerCards[2].isHidden = true
        playerCards[3].isHidden = true
        playerCards[4].isHidden = true
        
        bankerCards[0].isHidden = true
        bankerCards[1].isHidden = true
        bankerCards[2].isHidden = true
        bankerCards[3].isHidden = true
        bankerCards[4].isHidden = true
        
        bankerScore = 0
        playerScore = 0
        bankerScoreLabel.text = "\(bankerScore)"
        playerScoreLabel.text = "\(playerScore)"
        
        dealButton.isEnabled = true
        hitButton.isEnabled = false
        theOpenButton.isEnabled = false
        surrenderButton.isEnabled = false
        
        count = 2

    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
