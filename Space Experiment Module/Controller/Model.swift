//
//  Model.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2021/4/24.
//


import UIKit

var testmode : Bool = false

let characterIdArray : [String] = ["sunflower","chili","eggplant"]
var currentCharacter : Int! = 0
var currentScore : Int! = 0
var no1Scroll : Int! = 0
var no2Scroll : Int! = 0
var no3Scroll : Int! = 0
var no4Scroll : Int! = 0
var no5Scroll : Int! = 0
var assets : Int! = 0
var scrollArray : [Int]!
let objectIdArray : [String] = ["60805f3e2a5bb23590bcf745","608060a9f5766f41e9c2a01d","608061482a5bb23590bcf810","6080614e2a5bb23590bcf812","608061522a5bb23590bcf813"]
let Tomato = Character()
let Chili = Character()
let Eggplant = Character()
var characterArray : [Character] = [Tomato,Chili,Eggplant]
var levelArray : [Any] = [Tomato.Lever!,Chili.Lever!,Eggplant.Lever!]
var highestScore : Int! = 0

class Character{
    var Lever : Int! = 1
    var image : UIImage!
    var naturalEnemies : String!
}

class User{
    var userName : String!
    var assets : Int!
    var characterLevel : [Int]!
}

class LevelUp{
    var level2Needed : Int = 300
    var level3Needed : Int = 800
}

func setdata(){
    UserDefaults.standard.setValue(assets, forKey: "assets")
    UserDefaults.standard.setValue(Tomato.Lever, forKey: "tomatolevel")
    UserDefaults.standard.setValue(Chili.Lever, forKey: "chililevel")
    UserDefaults.standard.setValue(Eggplant.Lever, forKey: "eggplantlevel")
}

func getdata(){
    if let data = UserDefaults.standard.string(forKey: "assets"){
        assets = Int(data)
    }
    if let data = UserDefaults.standard.string(forKey: "tomatolevel"){
        Tomato.Lever = Int(data)
    }
    if let data = UserDefaults.standard.string(forKey: "chililevel"){
        Chili.Lever = Int(data)
    }
    if let data = UserDefaults.standard.string(forKey: "eggplantlevel"){
        Eggplant.Lever = Int(data)
    }
    if let data = UserDefaults.standard.string(forKey: "topscore"){
        highestScore = Int(data)
    }
}
