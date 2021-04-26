//
//  Alert.swift
//  Space Experiment Module
//
//  Created by 曹亚索 on 2021/1/12.
//

import UIKit

class Alert: UIViewController {

    var strongSelf : Alert?
    var action : ((UITapGestureRecognizer)->Void)? = nil
    
    override func loadView() {
        view = UIView()
        strongSelf = self
    }
    //MARK:方法主体
    func showimageAlert(imageName:String,action:@escaping ((UITapGestureRecognizer)->Void)){
        let scoreAndBest = [currentScore,highestScore]
        let window: UIWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
                    window.addSubview(view)
                    window.bringSubviewToFront(view)
                    view.frame = window.bounds
        self.action = action
        let width1 : CGFloat = 400
        let height1 : CGFloat = 400
        let imageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX - width1 / 2, y: UIScreen.main.bounds.midY - height1 / 2, width: width1, height: height1))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:))))
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        let labelWidth : CGFloat = 200
        let labelHeight : CGFloat = 50
        let yArray : [CGFloat] = [view.frame.minY+390,view.frame.minY+450]
        for y in yArray{
            let currentIndex = Int(yArray.firstIndex(of: y)!)
            let label = UILabel(frame: CGRect(x: view.frame.midX, y: y, width: labelWidth, height: labelHeight))
            label.autoresizesSubviews = true
            label.font = UIFont(name: "System", size: 20)
            label.textColor = UIColor.red
            label.textAlignment = NSTextAlignment.center
            label.text = String(scoreAndBest[currentIndex]!)
            view.addSubview(label)
        }
    }
    //MARK:diyAlert
    func showDiyAlert(action:@escaping ((UITapGestureRecognizer)->Void)){
        let window: UIWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
                    window.addSubview(view)
                    window.bringSubviewToFront(view)
        view.frame = CGRect(x: UIScreen.main.bounds.midX-150, y: UIScreen.main.bounds.midY-200, width: 300, height: 400)
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.action = action
        let labelWidth : CGFloat = 200
        let labelHeight : CGFloat = 50
        //排行榜
        if scrollArray != nil{
            let yArray : [CGFloat] = [view.frame.minY-200,view.frame.minY-150,view.frame.minY-100,view.frame.minY-50,view.frame.minY]
            for y in yArray{
                let currentIndex = Int(yArray.firstIndex(of: y)!)
                let label = UILabel(frame: CGRect(x: view.frame.minX, y: y, width: labelWidth, height: labelHeight))
                label.autoresizesSubviews = true
                label.font = UIFont(name: "System", size: 20)
                label.textColor = UIColor.red
                label.textAlignment = NSTextAlignment.center
                label.text = String(scrollArray[currentIndex])
                view.addSubview(label)
            }
        }else{
            let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - labelWidth/2, y: view.frame.minY, width: labelWidth, height: labelHeight))
            label.autoresizesSubviews = true
            label.font = UIFont(name: "System", size: 20)
            label.textColor = UIColor.red
            label.textAlignment = NSTextAlignment.center
            label.text = "未能获取排行榜"
            view.addSubview(label)
        }
        //用户最高分
        let label = UILabel(frame: CGRect(x: view.frame.minX, y: view.frame.minY+50, width: labelWidth, height: labelHeight))
        label.autoresizesSubviews = true
        label.font = UIFont(name: "System", size: 20)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        label.text = "个人最高分:\(String(highestScore))"
        view.addSubview(label)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:))))
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(tap:UITapGestureRecognizer){
        if tap.state == .ended{
            if action != nil{
                action!(tap)
            }
            self.view.removeFromSuperview()
        }
    }
    
    
    
    
    
    
}
