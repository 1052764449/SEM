//
//  GameSection.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/18.
//

import UIKit

class GameSection: UIViewController {

    var sectionnum : Int!
    @IBOutlet weak var sectionView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSectionView()
        // Do any additional setup after loading the view.
    }
    
    private func setSectionView(){
        sectionView.layer.borderWidth = 10
        sectionView.layer.borderColor = CGColor(red: 158, green: 158, blue: 158, alpha: 0.5)
        sectionView.image = UIImage(named: "gameScene1")
        sectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:))))
        sectionView.isUserInteractionEnabled = true
        sectionnum = 1
    }
    
    //MARK:游戏章节选择器
    @objc func handleSwipe(swipe:UIGestureRecognizer){
        if swipe.state == .ended{
            switch sectionnum {
            case 1:
                sectionView.image = UIImage(named: "gameScene2")
                sectionnum = 2
            case 2:
                sectionView.image = UIImage(named: "gameScene1")
                sectionnum = 1
            default:
                print("")
            }
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toSection"{
            
            let vc = segue.destination as! SectionController
            vc.sectionVer = self.sectionnum
            

        }
    }
    

}
