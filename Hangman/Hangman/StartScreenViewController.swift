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
        self.view.addSubview(gameTitle)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: gameTitle, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: gameTitle, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -100)
        self.view.addConstraints([xCenterConstraint, yCenterConstraint])
        
        
        newGameButton = UIButton.init(type: .roundedRect)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: "Menlo-Regular", size: (newGameButton.titleLabel?.font.pointSize)!)
        newGameButton.setTitleColor(UIColor.white, for: .normal)
        newGameButton.addTarget(self, action: #selector(startGame), for: UIControlEvents.touchUpInside)
        newGameButton.backgroundColor = UIColor.blue
        self.view.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        let topMargin = NSLayoutConstraint(item: newGameButton, attribute: .topMargin, relatedBy: .equal, toItem: gameTitle, attribute: .topMargin, multiplier: 1, constant: 120)
        let xCenterConstraintForNewGameButton = NSLayoutConstraint(item: newGameButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let newGameButtonWidth = NSLayoutConstraint(item: newGameButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100)
        self.view.addConstraints([topMargin, xCenterConstraintForNewGameButton, newGameButtonWidth])
        
        
        self.view.backgroundColor = UIColor.white
        
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
