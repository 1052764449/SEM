//
//  Section1Controller.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/18.
//
//MARK:游戏章节控制器
import UIKit
import SpriteKit
class SectionController: UIViewController {

    var score = 0
    var sectionVer = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        Section1Scene().viewcontroller = self
        if let spriteView = self.view as? SKView{
            spriteView.showsFPS = true
            spriteView.showsDrawCount = true
            spriteView.showsNodeCount = true
            
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        switch sectionVer {
        case 1:
            let scene = Section1Scene()
                scene.size = self.view.bounds.size
                if let spriteView = self.view as? SKView{
                    spriteView.presentScene(scene)
                }
        case 2:
            let scene = Section2Scene(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
                scene.size = self.view.bounds.size
                if let spriteView = self.view as? SKView{
                    spriteView.presentScene(scene)
                }
        default:
            print("")
        }
}
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
//        let scene = Section1Scene(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
//        scene.view?.isPaused = true
//
//        let alert = UIAlertController(title: "是否退出游戏？", message: "退出无法保存成绩", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (dismiss) in
//            SectionController().dismiss(animated: true, completion: nil)
//        }))
//        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
