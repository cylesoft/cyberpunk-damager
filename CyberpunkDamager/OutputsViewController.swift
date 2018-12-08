//
//  OutputsViewController.swift
//  CyberpunkDamager
//
//  Created by cyle gage on 11/28/18.
//  Copyright © 2018 CyleSoft. All rights reserved.
//

import UIKit

class OutputsViewController: UIViewController {
    
    @IBOutlet weak var headDamageLabel: UILabel!
    @IBOutlet weak var torsoDamageLabel: UILabel!
    @IBOutlet weak var leftArmDamageLabel: UILabel!
    @IBOutlet weak var rightArmDamageLabel: UILabel!
    @IBOutlet weak var leftLegDamageLabel: UILabel!
    @IBOutlet weak var rightLegDamageLabel: UILabel!
    @IBOutlet weak var damageRollsTextArea: UITextView!
    
    var damageInfo: Dictionary<String, Array<Int>> = Dictionary<String, Array<Int>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded damage output view")
        print(damageInfo)
        
        let headDamage = (damageInfo["head"] ?? [Int]()).reduce(0, +)
        let torsoDamage = (damageInfo["torso"] ?? [Int]()).reduce(0, +)
        let leftArmDamage = (damageInfo["left_arm"] ?? [Int]()).reduce(0, +)
        let rightArmDamage = (damageInfo["right_arm"] ?? [Int]()).reduce(0, +)
        let leftLegDamage = (damageInfo["left_leg"] ?? [Int]()).reduce(0, +)
        let rightLegDamage = (damageInfo["right_leg"] ?? [Int]()).reduce(0, +)
        
        headDamageLabel.text = String(headDamage)
        torsoDamageLabel.text = String(torsoDamage)
        leftArmDamageLabel.text = String(leftArmDamage)
        rightArmDamageLabel.text = String(rightArmDamage)
        leftLegDamageLabel.text = String(leftLegDamage)
        rightLegDamageLabel.text = String(rightLegDamage)
        
        // @todo make this nicer
        damageRollsTextArea.text = String(damageInfo.description)
    }
    
    @IBAction func goBack(_ sender: Any) {
        // take this view off the stack and go back to InputsViewController
        self.dismiss(animated: true, completion: nil)
    }
}
