//
//  PlantsDataController.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2020/12/18.
//

/*MARK:CurrentCharacter
 characterArray[levelLabel.tag] -> Character()
 characterArray[levelLabel.tag].Level -> Character().level
*/
import UIKit
import AudioToolbox
//反向传值协议
protocol selectedDelegate {
    func selectedGet(renwu:UIImage)
}

class PlantsCharacter: UIViewController, selectedDelegate {
    func selectedGet(renwu: UIImage) {
    }
    
    struct location {
        var x : CGFloat
        var y : CGFloat
    }
    struct size {
        var width : CGFloat
        var height : CGFloat
    }
    //MARK:数据源
    var SC : selectedDelegate?
    var imageArray : [UIImage]!
    var imageViewArrray : [UIImageView]!
    var currentImage : UIImage!
    var imageView1  = UIImageView()
    var imageView2  = UIImageView()
    var imageView3  = UIImageView()
    let picSize1 = size(width: 100, height: 100*267/221)
    let picSize2 = size(width: 400, height: 400*221/267)
    let location1 = location(x: UIScreen.main.bounds.midX-200-221, y: UIScreen.main.bounds.midY-133.5)
    let location2 = location(x: UIScreen.main.bounds.midX-200, y: UIScreen.main.bounds.midY-400*221/267/2)
    let location3 = location(x: UIScreen.main.bounds.midX+200, y: UIScreen.main.bounds.midY-133.5)
    @IBOutlet weak var assetsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelUpButton: UIButton!
    @IBOutlet weak var littleSun: UIImageView!
    @IBOutlet weak var levelUpNeededLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
         // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        for imageView in imageViewArrray{
            imageView.removeFromSuperview()
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        locationBack(imageView: imageView1)
        locationBack(imageView: imageView2)
        locationBack(imageView: imageView3)
        levelForNext()
        upDateView()
    }
    @IBAction func nextBtn(_ sender: Any) {
        locationNext(imageView: imageView1)
        locationNext(imageView: imageView2)
        locationNext(imageView: imageView3)
        levelForBack()
        upDateView()
    }
    
    @IBAction func upGradeButton(_ sender: Any) {
        if levelLabel.text == "LV.1"{
            if assets >= LevelUp().level2Needed{
                //数据
                assets -= LevelUp().level2Needed
                characterArray[levelLabel.tag].Lever += 1
                //View
                assetsLabel.text = "\(String(assets))"
                levelLabel.text = "LV.\(String(characterArray[levelLabel.tag].Lever))"
                levelUpNeededLabel.text = "\(LevelUp().level3Needed) to level up"
                //数据库
                if testmode == true{
                    print("Test Mode")
                }else{
                    setdata()
                }
            }else{
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                assetsLabelChange()
            }
        }else if levelLabel.text == "LV.2"{
            if assets >= LevelUp().level3Needed{
                //数据
                assets -= LevelUp().level3Needed
                characterArray[levelLabel.tag].Lever += 1
                //View
                assetsLabel.text = "\(String(assets))"
                levelLabel.text = "LV.\(String(characterArray[levelLabel.tag].Lever))"
                upDateView()
                //数据库
                if testmode == true{
                    print("Test Mode")
                }else{
                    setdata()
                }
            }else{
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                assetsLabelChange()
            }
        }else{
            print("levelUpButton.alpha = 0")
        }
        
    }
    
    func assetsLabelChange(){
        assetsLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        var countDownNum = 30
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if countDownNum == 0 {
                self.assetsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                timer.invalidate()
            } else {
                countDownNum -= 10
            }
        }
    }
    
    @objc func tapHandle(tap:UIGestureRecognizer){
        if tap.state == .ended{
            for imageView in imageViewArrray{
                imageView.removeFromSuperview()
            }
            SC?.selectedGet(renwu: characterArray[levelLabel.tag].image)
            currentCharacter = levelLabel.tag
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func initialize(){
        //设置assetsLabel
//        assets = 9999
        assetsLabel.text = "\(String(assets))"
        assetsLabel.minimumScaleFactor = 0.5
        assetsLabel.adjustsFontSizeToFitWidth = true
        //设置image数据源
        imageArray = [characterArray[0].image,characterArray[1].image,characterArray[2].image]
        //通过levelLabel的tag显示相应level
        levelLabel.tag = 1
        levelLabel.text = "LV.\(String(characterArray[levelLabel.tag].Lever))"
        //设置LittleSun、levelUpNeededLabel、levelUpButtond
        upDateView()
        //view定位置
        imageView1 = UIImageView(frame: CGRect(x: location1.x, y: location1.y, width: picSize1.width, height: picSize2.height))
        imageView2 = UIImageView(frame: CGRect(x: location2.x, y: location2.y, width: picSize2.width, height: picSize2.height))
        imageView3 = UIImageView(frame: CGRect(x: location3.x, y: location3.y, width: picSize1.width, height: picSize1.height))
        //设置imageView数据源
        imageViewArrray = [imageView1,imageView2,imageView3]
        var tag = 0
        for imageView in imageViewArrray{
            imageView.tag = tag
            imageView.image = imageArray[tag]
            imageView.contentMode = .scaleAspectFit
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(tap:)))
            imageView.addGestureRecognizer(tap)
            imageView.isUserInteractionEnabled = true
            self.view.addSubview(imageView)
            tag += 1
        }
    }
    
    func locationNext(imageView:UIImageView){
        //在location1时
        if imageView.tag == 0{
            UIView.animate(withDuration: 0.3) { [self] in
                imageView.frame = CGRect(x: location2.x, y: location2.y, width: picSize2.width, height: picSize2.height)
                imageView.tag = 1
                currentImage = imageView.image
            }
        }else if imageView.tag == 1{
            UIView.animate(withDuration: 0.3) { [self] in
                imageView.frame = CGRect(x: location3.x, y: location3.y, width: picSize1.width, height: picSize1.height)
                imageView.tag = 2
            }
        }else if imageView.tag == 2{
            imageView.frame = CGRect(x: location1.x, y: location1.y, width: picSize1.width, height: picSize1.height)
            imageView.tag = 0
        }
    }
    
    func levelForNext(){
        if levelLabel.tag < 2{
            levelLabel.tag += 1
        }else{
            levelLabel.tag = 0
        }
        levelLabel.text = "LV.\(String(characterArray[levelLabel.tag].Lever))"
    }
    
    func locationBack(imageView:UIImageView){
        if imageView.tag == 0{
            imageView.frame = CGRect(x: location3.x, y: location3.y, width: picSize1.width, height: picSize1.height)
            imageView.tag = 2
        }else if imageView.tag == 1{
            UIView.animate(withDuration: 0.3) { [self] in
                imageView.frame = CGRect(x: location1.x, y: location1.y, width: picSize1.width, height: picSize1.height)
                imageView.tag = 0
            }
        }else if imageView.tag == 2{
            UIView.animate(withDuration: 0.3) { [self] in
                imageView.frame = CGRect(x: location2.x, y: location2.y, width: picSize2.width, height: picSize2.height)
                imageView.tag = 1
                currentImage = imageView.image
            }
        }
    }
    
    func levelForBack(){
        if levelLabel.tag > 0{
            levelLabel.tag -= 1
        }else{
            levelLabel.tag = 2
        }
        levelLabel.text = "LV.\(String(characterArray[levelLabel.tag].Lever))"
    }
    
    func upDateView(){
        if levelLabel.text == "LV.1"{
            levelUpNeededLabel.text = "\(LevelUp().level2Needed) to level up"
            littleSun.alpha = 1
            levelUpNeededLabel.alpha = 1
            levelUpButton.alpha = 1
        }else if levelLabel.text == "LV.2"{
            levelUpNeededLabel.text = "\(LevelUp().level3Needed) to level up"
            littleSun.alpha = 1
            levelUpNeededLabel.alpha = 1
            levelUpButton.alpha = 1
        }else if levelLabel.text == "LV.3"{
            littleSun.alpha = 0
            levelUpNeededLabel.alpha = 0
            levelUpButton.alpha = 0
        }
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

