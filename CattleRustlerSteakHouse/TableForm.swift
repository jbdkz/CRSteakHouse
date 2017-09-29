//
//  TableForm.swift
//  CattleRustlerSteakHouse
//
//  Created by John Diczhazy on 9/15/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class TableForm: UIViewController {
    
    
    //Outlets representing tables
    @IBOutlet weak var oneLabel: UILabel!
    
    @IBOutlet weak var twoLabel: UILabel!
    
    @IBOutlet weak var threeLabel: UILabel!
    
    @IBOutlet weak var fourLabel: UILabel!
    
    @IBOutlet weak var fiveLabel: UILabel!
    
    @IBOutlet weak var sixLabel: UILabel!
    
    @IBOutlet weak var sevenLabel: UILabel!
    
    @IBOutlet weak var eightLabel: UILabel!
    
    @IBOutlet weak var nineLabel: UILabel!
    
    @IBOutlet weak var tenLabel: UILabel!
    
    @IBOutlet weak var elevenLabel: UILabel!
    
    @IBOutlet weak var twelveLabel: UILabel!
    
    @IBOutlet weak var thirteenLabel: UILabel!
    
    @IBOutlet weak var fourteenLabel: UILabel!
    
    @IBOutlet weak var fifteenLabel: UILabel!
    
    @IBOutlet weak var sixteenLabel: UILabel!
    
    @IBOutlet weak var seventeenLabel: UILabel!
    
    @IBOutlet weak var eighteenLabel: UILabel!
    
    @IBOutlet weak var nineteenLabel: UILabel!
    
    @IBOutlet weak var twentyLabel: UILabel!

    
    //Show occupied tables by changin label background to red on page load
    override func viewDidLoad() {
       let count = DBAccess.countRecords()
        
       var i = 1
       while i <= count {
       let arrayOutput: [String]
       arrayOutput = DBAccess.readRecord(ROW: i)
       if arrayOutput[1] != "E" {
                switch i {
                        case 1:
                            oneLabel.backgroundColor = UIColor.red
                        case 2:
                            twoLabel.backgroundColor = UIColor.red
                         case 3:
                            threeLabel.backgroundColor = UIColor.red
                         case 4:
                            fourLabel.backgroundColor = UIColor.red
                         case 5:
                            fiveLabel.backgroundColor = UIColor.red
                         case 6:
                            sixLabel.backgroundColor = UIColor.red
                         case 7:
                            sevenLabel.backgroundColor = UIColor.red
                         case 8:
                            eightLabel.backgroundColor = UIColor.red
                         case 9:
                            nineLabel.backgroundColor = UIColor.red
                         case 10:
                            tenLabel.backgroundColor = UIColor.red
                         case 11:
                            elevenLabel.backgroundColor = UIColor.red
                         case 12:
                            twelveLabel.backgroundColor = UIColor.red
                         case 13:
                            thirteenLabel.backgroundColor = UIColor.red
                         case 14:
                            fourteenLabel.backgroundColor = UIColor.red
                         case 15:
                            fifteenLabel.backgroundColor = UIColor.red
                         case 16:
                            sixteenLabel.backgroundColor = UIColor.red
                         case 17:
                            seventeenLabel.backgroundColor = UIColor.red
                         case 18:
                            eighteenLabel.backgroundColor = UIColor.red
                         case 19:
                            nineteenLabel.backgroundColor = UIColor.red
                         case 20:
                            twentyLabel.backgroundColor = UIColor.red
                         default:
                            print("default")
                        }
                  }
         i += 1
      }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
