//
//  ViewController.swift
//  CyberpunkDamager
//
//  Created by cyle gage on 11/27/18.
//  Copyright © 2018 CyleSoft. All rights reserved.
//

import UIKit

class InputsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let damageHelper = DamageHelper()
    
    var locations: [String] = [String]()
    
    @IBOutlet weak var bulletHitsInput: UITextField!
    
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var bulletDamageDiceCountInput: UITextField!
    
    @IBOutlet weak var bulletDamagePerDieInput: UITextField!
    
    @IBOutlet weak var extraDamagePerBulletInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        locations = [
            "Spray & Pray!",
            "Called Shot: Head",
            "Called Shot: Torso",
            "Called Shot: Left Arm",
            "Called Shot: Right Arm",
            "Called Shot: Left Leg",
            "Called Shot: Right Leg"
        ]
    }
    
    @IBAction func rollForDamage(_ sender: Any) {
        print("hello")
        print("bullets hit count: " + bulletHitsInput.text!)
        print("per bullet dice count: " + bulletDamageDiceCountInput.text!)
        print("damage per bullet die: " + bulletDamagePerDieInput.text!)
        print("extra damage per bullet: " + extraDamagePerBulletInput.text!)
        print("selected type of roll: " + String(locationPicker.selectedRow(inComponent: 0)))
        
        // @todo do input validation to make sure none of the input fields are empty and are numeric
        
        let bulletsHit = Int(bulletHitsInput.text!) ?? 0
        if bulletsHit == 0 {
            errorHighlightTextField(textField: bulletHitsInput)
            return
        } else {
            removeErrorHighlightTextField(textField: bulletHitsInput)
        }
        
        let bulletDamageDiceCount = Int(bulletDamageDiceCountInput.text!) ?? 0
        if bulletDamageDiceCount == 0 {
            errorHighlightTextField(textField: bulletDamageDiceCountInput)
            return
        } else {
            removeErrorHighlightTextField(textField: bulletDamageDiceCountInput)
        }
        
        let bulletDamagePerDie = Int(bulletDamagePerDieInput.text!) ?? 0
        if bulletDamagePerDie == 0 {
            errorHighlightTextField(textField: bulletDamagePerDieInput)
            return
        } else {
            removeErrorHighlightTextField(textField: bulletDamagePerDieInput)
        }
        
        let extraDamagePerBullet = Int(extraDamagePerBulletInput.text!) ?? 0
        
        // convert the location picker to the location hashmap map if needed
        // print(damageHelper.locations)
        
        var called_shot = false
        var actual_location: String = "unknown"
        switch locationPicker.selectedRow(inComponent: 0) {
            case 1:
                called_shot = true
                actual_location = "head"
            case 2:
                called_shot = true
                actual_location = "torso"
            case 3:
                called_shot = true
                actual_location = "left_arm"
            case 4:
                called_shot = true
                actual_location = "right_arm"
            case 5:
                called_shot = true
                actual_location = "left_leg"
            case 6:
                called_shot = true
                actual_location = "right_leg"
            default:
                actual_location = "unknown"
        }
        
        let damage_dealt = damageHelper.rollDamage(number_of_bullets_hit: bulletsHit, dice_per_bullet: bulletDamageDiceCount, sides_per_die: bulletDamagePerDie, extra_damage: extraDamagePerBullet, called_shot: called_shot, called_shot_location: actual_location)
        
        // pass this data along to the OutputsViewController and put that up top
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "outputViewController") as! OutputsViewController
        newViewController.damageInfo = damage_dealt
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    // Text Field is empty - show red border
    func errorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
    }
    
    // Text Field is NOT empty - show gray border with 0 border width
    func removeErrorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 5
    }
}

