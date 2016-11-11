//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    var gameTitle: UILabel!
    
    var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTitle = UILabel()
        gameTitle.text = "Hangman"
        gameTitle.font = UIFont(name: "Noteworthy-Light", size: 35)
        let gameTitleSize = CGSize(width: 120, height: 40)
        var gameTitlePosition = self.view.center
        gameTitlePosition.x = gameTitlePosition.x - gameTitleSize.width / 2 - 5
        gameTitlePosition.y = gameTitlePosition.y / 2
        gameTitle.frame = CGRect(origin: gameTitlePosition, size: gameTitleSize)
        gameTitle.sizeToFit()
        
        newGameButton = UIButton.init(type: .roundedRect)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: "Menlo-Regular", size: (newGameButton.titleLabel?.font.pointSize)!)
        newGameButton.setTitleColor(UIColor.white, for: .normal)
        newGameButton.addTarget(self, action: #selector(startGame), for: UIControlEvents.touchUpInside)
        let newGameButtonSize = CGSize(width: 120, height: 40)
        var newGameButtonPosition = self.view.center
        newGameButtonPosition.x = newGameButtonPosition.x - newGameButtonSize.width / 2
        newGameButton.frame = CGRect(origin: newGameButtonPosition, size: newGameButtonSize)
        newGameButton.backgroundColor = UIColor.blue
    
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(gameTitle)
        self.view.addSubview(newGameButton)
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame() {
        let gameVC = GameViewController()
        self.present(gameVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
