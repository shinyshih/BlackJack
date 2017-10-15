//
//  GameOverViewController.swift
//  BlackJack
//
//  Created by 施馨檸 on 15/10/2017.
//  Copyright © 2017 施馨檸. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var outcomeLabel: UILabel!
    
    var playerChip = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if playerChip == 0 {
            outcomeLabel.text = "嗚...輸了1000"
        } else {
            outcomeLabel.text = "贏了\(playerChip)，繼續挑戰吧！"
        }
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
