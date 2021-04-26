//
//  ViewController.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/17.
//

import UIKit
import LeanCloud

class MainViewController: UIViewController ,selectedDelegate{
    func selectedGet(renwu: UIImage) {
        currentCharacter.image = renwu
    }
    
    var label : UILabel!
    @IBOutlet weak var currentCharacter: UIImageView! 
    @IBOutlet weak var testModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //排行榜初始化
        loopGetRank()
        //初始化
        Initial()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showRank(_ sender: Any) {
        self.view.alpha = 0.5
        Alert().showDiyAlert() { (Rank) in
            self.view.alpha = 1
        }
    }
    @IBAction func showCharacter(_ sender: Any) {
    }
    
    func loopGetRank(){
        for object in objectIdArray{
            let query = LCQuery(className: "Rank")
            let _ = query.get(object) { (result) in
                switch result {
                case .success(object: let Rank):
                    let scroll = Int((Rank.get("Scroll")?.intValue)!)
                    let objectNO = Int((Rank.get("objectNO")?.intValue)!)
                    if objectNO == 1{
                        no1Scroll = scroll
                    }else if objectNO == 2{
                        no2Scroll = scroll
                    }else if objectNO == 3{
                        no3Scroll = scroll
                    }else if objectNO == 4{
                        no4Scroll = scroll
                    }else if objectNO == 5{
                        no5Scroll = scroll
                    }
                    //得到五个可选型的Number
                    scrollArray = [no1Scroll,no2Scroll,no3Scroll,no4Scroll,no5Scroll]
                case .failure(error: let error):
                    print(error)
                }
            }
        }
    }
    
    func Initial(){
        //data初始化
        getdata()
        //character image
        Tomato.image = #imageLiteral(resourceName: "sunflower")
        Chili.image = #imageLiteral(resourceName: "chili")
        Eggplant.image = #imageLiteral(resourceName: "eggplant")
        //
        currentCharacter.image = Chili.image
        testModeSwitch.setOn(false, animated: false)
    }
    
    @IBAction func TestModeSwitch(_ sender: Any) {
        if testmode == false{
            testmode = true
        }else{
            testmode = false
            getdata()
        }
        testMode()
    }
    
    func testMode(){
        if testmode == true{
            assets = 9999
            Tomato.Lever = 1
            Chili.Lever = 1
            Eggplant.Lever = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tocharacter"{
            let vc = segue.destination as! PlantsCharacter
            vc.SC = self
        }
    }
    
    
    
    
}


