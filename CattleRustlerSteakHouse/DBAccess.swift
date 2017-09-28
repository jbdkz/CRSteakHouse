//
//  DBAccess.swift
//  CattleRustlerSteakHouse
//
//  Created by John Diczhazy on 9/15/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import Foundation

class DBAccess {
    
    //Function creates database and table if they do not exist at specified path
    class func initDB() {
        
        var database:OpaquePointer? = nil
        var result = sqlite3_open(dataFilePath(), &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
            return
        }
    
        let createSQL = "CREATE TABLE IF NOT EXISTS CRSteakHouse " + "(ROW INTEGER PRIMARY KEY, ResName TEXT, ResNumber TEXT, Smoking BOOL);"
        var errMsg:UnsafeMutablePointer<Int8>? = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg)
        if (result != SQLITE_OK) {
            sqlite3_close(database)
            print("Failed to create table")
            return
        }
    }
    
    //Populate database table with 20 empty table entries if they do not alreay exist
    class func popDB(){
        for _  in 1...10 {
                  let message  = DBAccess.createRecord(resname: "E", resnumber: "0", smoking: true)
                  print(message)
              }
        for _  in 1...10 {
                 let message  = DBAccess.createRecord(resname: "E", resnumber: "0", smoking: false)
                 print(message)
                }
            }
    

    //Create record function
    class func createRecord(resname: String, resnumber: String, smoking: Bool) -> String{
        var database:OpaquePointer? = nil
        let result = sqlite3_open(dataFilePath(), &database)
        var message: String = ""
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
            message = "Failed to open database"
        }
        
        let insert:String = "INSERT INTO CRSteakHouse (ResName,ResNumber,Smoking)" + " VALUES ('\(resname)','\(resnumber)','\(smoking)');"
        
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, insert, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Record Created")
                message = "Record Created"
            } else {
                print("Record NOT Created")
                message = "Record NOT Created"
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        return message
    }
    
    //Read record function
    class func readRecord(ROW: Int) -> Array<String>{
        
        var database:OpaquePointer? = nil
        let result = sqlite3_open(dataFilePath(), &database)
        var message: String = ""
        var fieldRow: String = ""
        var fieldResName: String = ""
        var fieldResNumber: String = ""
        var fieldSmoking: String = ""
        var myArray: [String] = []
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
            message = "Failed to open database"
        }
        
        let query = "SELECT ROW, ResName, ResNumber, Smoking FROM CRSteakHouse WHERE ROW = '\(ROW)'"
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            message = "Record NOT Found"
            
            myArray.insert ("", at: 0)
            myArray.insert ("", at: 1)
            myArray.insert ("", at: 2)
            myArray.insert ("", at: 3)
            myArray.insert (message, at: 4)
    
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let row = sqlite3_column_text(statement, 0)
                let rowData = sqlite3_column_text(statement, 1)
                let rowData1 = sqlite3_column_text(statement, 2)
                let rowData2 = sqlite3_column_text(statement, 3)
                
                fieldRow = String(cString:(row!))
                fieldResName = String(cString:(rowData!))
                fieldResNumber = String(cString:(rowData1!))
                fieldSmoking = String(cString:(rowData2!))
                
                message = "Record Found"
                
                myArray.insert (fieldRow, at: 0)
                myArray.insert (fieldResName, at: 1)
                myArray.insert (fieldResNumber, at: 2)
                myArray.insert (fieldSmoking, at: 3)
                myArray.insert (message, at: 4)
                
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        return myArray
    }
    
    
    //Count record function
    class func countRecords() -> Int {
        
        var database:OpaquePointer? = nil
        let result = sqlite3_open(dataFilePath(), &database)
            
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        
        let query = "SELECT COUNT(*) FROM CRSteakHouse"
        var statement:OpaquePointer? = nil
        var count = 0
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                count = Int(sqlite3_column_int(statement, 0));
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        return count
    }
    
    //Update record function
    class func updateRecord(row: Int, resname: String, resnumber: String) -> String{
        var database:OpaquePointer? = nil
        let result = sqlite3_open(dataFilePath(), &database)
        var message: String = ""
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
            message = "Failed to open database"
        }
    
        let update:String = "UPDATE CRSteakHouse SET ResName='\(resname)',ResNumber='\(resnumber)' WHERE row='\(row)'"
        
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Sucessfully updated row.")
                message = "Record Updated"
            } else {
                print("Could not update row.")
                message = "Record NOT Updated"
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        return message
    }
    
    
    //Function provides path to sqlite database
    class func dataFilePath() -> String {
        let urls = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        return urls.first!.appendingPathComponent("CRSteakHouse.sqlite").path
    }
}
