//
//  UnlockViewController.swift
//  guessNumber
//
//  Created by Simon on 2018/4/7.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit

class UnlockViewController: UIViewController {
    //亂數
    var random = 0
    //剩餘次數
    var remainingNumber = 6
    //最大數字提示
    var maxNumber = 100
    //最小數字提示
    var minNumber = 0
    //判斷
    func judgment(number:Int){
        //如果使用者輸入大於100
        if number > 100{
            caveat(title: "錯誤", message: "輸入小於100的數字")
        }else if number > random {         //猜的數字大於亂數
            maxNumber = number - 1
            rangeLabel.text = rangeHint()
            remainingNumber -= 1
            remainingLabel.text = "\(remainingNumber)"
        }else if number < random{          //猜的數字小於亂數
            minNumber = number + 1
            rangeLabel.text = rangeHint()
            remainingNumber -= 1
            remainingLabel.text = "\(remainingNumber)"
        }else{                             //猜對了
            caveat(title: "Good", message: "解鎖成功")
        }
    }
    //警告控制器
    func caveat (title:String , message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    //重新開始
    func renew()  {
        random =  Int(arc4random_uniform(100))
        maxNumber = 100
        minNumber = 0
         rangeLabel.text = rangeHint()
         remainingNumber = 6
        remainingLabel.text = "\(remainingNumber)"
    }
    //重新開始
    @IBAction func againButton(_ sender: Any) {
        renew()
    }
    //提示範圍
    func rangeHint() -> String {
        return "\(minNumber)~\(maxNumber)"
    }
    //剩餘次數
    @IBOutlet weak var remainingLabel: UILabel!
    //範圍
    @IBOutlet weak var rangeLabel: UILabel!
    //使用者輸入
    @IBOutlet weak var numberTextField: UITextField!
    //go案妞
    @IBAction func goButon(_ sender: UIButton) {
         view.endEditing(true)
        if numberTextField.text == "" {                 //沒輸入就按按鈕
            caveat(title: "錯誤", message: "輸入小於100的數字")
        }else if Int(numberTextField.text!) == nil{     //輸入字串
            caveat(title: "只能輸入數字", message: nil)
        }else if remainingNumber > 0{                   //生命大於0
            let n = Int(numberTextField.text!)
            judgment(number: n!)
        }else{                                          //沒有生命
            caveat(title: "失敗", message: "解鎖失敗")
            renew()
        }
        numberTextField.text = ""                       //每次按完按鈕把text field清空
        print("\(random)")
    }
    var tap = 0
    //隱藏navigation bar 的方法
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
        if tap == 0{
            self.navigationController?.isNavigationBarHidden = false
            tap = 1
        }else if tap == 1 {
            self.navigationController?.isNavigationBarHidden = true
            tap = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //隱藏navigation
        self.navigationController?.isNavigationBarHidden = true
        //取亂數
        random =  Int(arc4random_uniform(100))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
