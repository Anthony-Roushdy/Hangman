//
//  ViewController.swift
//  Hangman
//
//  Created by Anthony Roushdy on 10/25/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Word: UITextField!
    @IBOutlet weak var Character: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hLabel: UILabel!
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label6: UILabel!
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var Guess: UIButton!
    var letters: [Character] = []
    var i = 0
    var m = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Save.tintColor = .magenta
        Guess.tintColor = .magenta
        let storedWord = UserDefaults.standard.object(forKey:"Word")
        let storedCharacter = UserDefaults.standard.object(forKey:"Character")
    }
    @IBAction func saveButton(_ sender: Any) {
        letters = []
        hLabel.text = "_"
        aLabel.text = "_"
        nLabel.text = "_"
        gLabel.text = "_"
        Label1.text = " "
        Label2.text = " "
        Label3.text = " "
        Label4.text = " "
        Label5.text = " "
        Label6.text = " "
        UserDefaults.standard.set(Word.text!, forKey: "Word")
        var storedWord = UserDefaults.standard.string(forKey:"Word")
        var nonOptionalString = ""
        if let unwrappedString = storedWord {
            nonOptionalString = unwrappedString.lowercased()
        }
        if nonOptionalString.count == 4 {
            for character in nonOptionalString {
                letters.append(character)
            }
        }
        else {
            showAlert()
        }
        Word.text = "Word"
    }
    
    @IBAction func guessButton(_ sender: Any) {
        Save.tintColor = .systemBlue
        Guess.tintColor = .systemBlue
        UserDefaults.standard.set(Character.text!, forKey: "Character")
        var storedCharacter = UserDefaults.standard.string(forKey:"Character")
        var nonOptionalString = ""
        if let unwrappedString = storedCharacter {
            nonOptionalString = unwrappedString.lowercased()
        }
        var userCharacter = Swift.Character(nonOptionalString)
        var n = 0
        for (index, char) in letters.enumerated() {
            if char == userCharacter {
                view.backgroundColor = UIColor.green
                switch index {
                case 0:
                    hLabel.text = "\(char)"
                    m = m + 1
                case 1:
                    aLabel.text = "\(char)"
                    m = m + 1
                case 2:
                    nLabel.text = "\(char)"
                    m = m + 1
                default:
                    gLabel.text = "\(char)"
                    m = m + 1
                }
            }
            else {
                n = n + 1
            }
        }
        if n == 4 {
            view.backgroundColor = UIColor.red
            switch i {
            case 0:
                imageView.image = UIImage(named: "Hangman_Head")
                Label1.text = "\(nonOptionalString)"
                i = i + 1
            case 1:
                imageView.image = UIImage(named: "Hangman_Torso")
                Label2.text = "\(nonOptionalString)"
                i = i + 1
            case 2:
                imageView.image = UIImage(named: "Hangman_Left_Leg")
                Label3.text = "\(nonOptionalString)"
                i = i + 1
            case 3:
                imageView.image = UIImage(named: "Hangman_Right_Leg")
                Label4.text = "\(nonOptionalString)"
                i = i + 1
            case 4:
                imageView.image = UIImage(named: "Hangman_Left_Arm")
                Label5.text = "\(nonOptionalString)"
                i = i + 1
            default:
                i = 0
                gameOverAlert()
                m = 0
                imageView.image = UIImage(named: "Hangman")
            }
        }
        if m == 4 {
            youWinAlert()
            letters = []
            m = 0
            i = 0
            imageView.image = UIImage(named: "Hangman")
        }
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Please enter a four letter word", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style:.cancel))
        
        present(alert, animated: true)
    }
    
    func gameOverAlert() {
        let alert = UIAlertController(title:"Game Over", message: "You have run out of attempts. Please restart the game.", preferredStyle: .alert)
        
        alert
            .addAction(UIAlertAction(title:"Ok", style:.cancel))
        
        present(alert, animated: true)
    }
    
    func youWinAlert() {
        let alert = UIAlertController(title:"You Win!", message: "You win! Please press ok to play again.", preferredStyle: .alert)
        
        alert
            .addAction(UIAlertAction(title:"Ok", style:.cancel))
        
        present(alert, animated: true)
    }
    

}

