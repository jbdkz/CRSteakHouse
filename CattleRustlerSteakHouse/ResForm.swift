//
//  ResForm.swift
//  CattleRustlerSteakHouse
//
//  Created by John Diczhazy on 9/15/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class ResForm: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Create class variables
    var tables = [String]()
    var selected:String = ""
    
    
    //Outlets and Actions
    @IBOutlet weak var singlePicker: UIPickerView!
    
    @IBOutlet weak var smokingLbl: UILabel!
    
    @IBOutlet weak var resNameTxt: UITextField!
    
    @IBOutlet weak var resNumTxt: UITextField!
    
    @IBAction func disResBtn(_ sender: Any) {
    }
    
   
    @IBAction func chgResBtn(_ sender: Any) {
        unhideButtons()
    }
    
    @IBOutlet weak var chgResBtn: UIButton!
    
    @IBAction func canChgResBtn(_ sender: Any) {
        hideButtons()
    }
    
    @IBOutlet weak var canChgResBtn: UIButton!
    
    @IBAction func makeResBtn(_ sender: Any) {
        //Reservaton Name and Number Validation
        if resNameTxt.text != ""{
            if resNameTxt.text != "E"{
                if resNumTxt.text != ""{
                      let resNum = resNumTxt.text
                    if resNum == "1" || resNum == "2" || resNum == "3" || resNum == "4" {
                       let message = DBAccess.updateRecord(row: Int(selected)!, resname: (resNameTxt.text)!, resnumber: (resNumTxt.text)!)
                       print(message)
                       let inputStr = "A Reservation has been make for Table " + selected
                       alert(title: "Reservation Confirmation", input: inputStr)
                       hideButtons()
                    }else{alert(title: "Invalid Data", input: "Number of People must be more than 0 and less than 5.")
                        resNumTxt.becomeFirstResponder()
                    }
                }else{alert(title: "Invalid Data", input: "Number of People field cannot be blank.")
                    resNumTxt.becomeFirstResponder()
                }
            }else{alert(title: "Invalid Data", input: "E indicates an empty table and cannot be a Reservation Name.")
                 resNameTxt.becomeFirstResponder()
            }
        }else{alert(title: "Invalid Data", input: "Reservation Name cannot be blank.")
            resNameTxt.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var makeResBtn: UIButton!
    
    @IBAction func canResBtn(_ sender: Any) {
        //Warn user of cancellation
        let alertController = UIAlertController(
            title: "Cancel Reservation Warning!",
            message: "Are you sure that you want to cancel the Reservation for Table " + selected + " ?",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.default) { (action) in
                // ...
        }
        
        let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.destructive) { (action) in
            //Perform cancellation
            let message = DBAccess.updateRecord(row: Int(self.selected)!, resname: "E", resnumber: "0")
            self.resNameTxt.text = "E"
            self.resNumTxt.text = "0"
            print(message)
            self.hideButtons()
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var canResBtn: UIButton!
    
    @IBAction func canAllResBtn(_ sender: Any) {
            //Warn user of cancellation
            let alertController = UIAlertController(
            title: "Cancel All Reservations Warning!",
            message: "Are you sure that you want to cancel All Reservations?",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.default) { (action) in
                // ...
        }
        
        let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.destructive) { (action) in
            //Cancel ALL Reservations
            for i  in 1...20 {
                let message  = DBAccess.updateRecord(row: (i),resname: "E", resnumber: "0")
                print(message)
            }
            self.resNameTxt.text = "E"
            self.resNumTxt.text = "0"
            self.hideButtons()
        }
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
    }

    @IBOutlet weak var canAllResBtn: UIButton!
    
    @IBAction func exitBtn(_ sender: Any) {
        //Warn user about exiting application
        let alertController = UIAlertController(
            title: "Exit Application Warning!",
            message: "Are you sure you want to exit the application?",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        let cancelAction = UIAlertAction(
            title: "No",
            style: UIAlertActionStyle.default) { (action) in
                // ...
        }
        
        let confirmAction = UIAlertAction(
        title: "Yes", style: UIAlertActionStyle.destructive) { (action) in
            //Exit application
            exit(0)
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBAccess.initDB()
        
        //Check if database has already been populated with table entries.
        let arrayOutput: [String]
        arrayOutput = DBAccess.readRecord(ROW: 1)
        if arrayOutput[4] == "Record NOT Found" {
        //If not populate database with table entries.
        DBAccess.popDB()
        }
        
        //Get table number assign to tables array
        let count = DBAccess.countRecords()
        var i = 1
        while i <= count {
            tables.append(String(i))
            i += 1
        }
        
        //Call hideButtons function.
        hideButtons()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //Function hides and makes visible certain buttons
    func hideButtons() {
        self.canChgResBtn.isHidden = true
        self.makeResBtn.isHidden = true
        self.canResBtn.isHidden = true
        self.canAllResBtn.isHidden = true
        self.chgResBtn.isHidden = false
        self.resNameTxt.isEnabled = false
        self.resNumTxt.isEnabled = false
    
    }
    
    //Function hides and makes visible certain buttons
    func unhideButtons() {
        self.canChgResBtn.isHidden = false
        self.makeResBtn.isHidden = false
        self.canResBtn.isHidden = false
        self.canAllResBtn.isHidden = false
        self.chgResBtn.isHidden = true
        self.resNameTxt.isEnabled = true
        self.resNumTxt.isEnabled = true
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    //Return 1 as the number of Picker sections
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return number of rows in Picker
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return tables.count
    }
    // MARK: Picker Delegate Methods
    
    //Populate Picker Rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        
        //Display Smoking, Reservation Name, and Number of People
        selected = tables[row]
        let arrayOutput: [String]
        arrayOutput = DBAccess.readRecord(ROW: Int(selected)!)
        if arrayOutput[3] ==  "true" {
          smokingLbl.text = "Smoking Table"
        } else {
          smokingLbl.text = "Nonsmoking Table"
        }
        
        resNameTxt.text = arrayOutput[1]
        resNumTxt.text = arrayOutput[2]
        
        return tables[row]
    }
    
    
    //Alert function
    func alert (title: String, input: String){
        let alertController = UIAlertController(title: title, message: input, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
