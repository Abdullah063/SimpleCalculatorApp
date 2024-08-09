//
//  ViewController.swift
//  SimpleCalculatorApp
//
//  Created by Abdullah Altun on 26.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblCalculator: UILabel!
    var firstNum : String = ""
    var operation : String = ""
    var secondNum : String = ""
    var havePoint : Bool = false
    
    var resultNum : String = ""
    var resultView : String = " = "
    var afterResultNum : String = ""
    
    @IBOutlet var btnCollection: [UIButton]!
    
    var originalFontSize: CGFloat = 0
        var originalFont: UIFont?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for button in btnCollection{
            button.layer.cornerRadius = 20
           
        }
    }
    
    @IBAction func btnClear(_ sender: Any) {
        firstNum = ""
        operation  = ""
        secondNum  = ""
        havePoint  = false
        resultNum  = ""
        resultView = " = "
        afterResultNum  = ""
        lblResult.text = ""
        lblCalculator.text = ""
    }
    @IBAction func btnDel(_ sender: Any) {
        if operation == "" {
                if !firstNum.isEmpty {
                    firstNum.removeLast()
                    lblCalculator.text = firstNum
                    lblResult.text = resultView + firstNum
                }
            } else {
                if !secondNum.isEmpty {
                    secondNum.removeLast()
                    lblCalculator.text = lblCalculator.text?.dropLast().description
                    lblResult.text = "= \(doOperation())"
                }
            }
        print("operation \(operation) , firstNum \(firstNum),  secondNum \(secondNum)  resultNum \(resultNum)  ")
    }
    
    @IBAction func btnFunc(_ sender: Any) {
        print("operation: \(operation) , firstNum: \(firstNum)  secondNum: \(secondNum)  resultNum: \(resultNum) havePoint: \(havePoint) ")
    }
    @IBAction func btnPoint(_ sender: Any) {
        if lblCalculator.text == "" && havePoint == false{
            firstNum = "0"
            havePoint = true
        }else{
            
        }
    }
    @IBAction func numPressed(_ sender: UIButton) {
        
        if  operation == ""{
            firstNum += String(sender.tag)
            lblCalculator.text = firstNum
            lblResult.text = resultView + firstNum
        }else {
            firstNum += String(sender.tag)
            if let label = lblCalculator {
                label.text = "\(label.text!)\(String(sender.tag))"
                
                if let firstValue = Double(firstNum), let secondValue = Double(secondNum) {
                   
                    switch operation {
                        case "+":
                        resultNum = (String(firstValue + secondValue))
                        lblResult.text = "= \(resultNum)"
                        case "-":
                        resultNum = String(secondValue - firstValue)
                        lblResult.text = "= \(resultNum)"
                        case "*":
                        resultNum = String(firstValue * secondValue)
                        lblResult.text = "= \(resultNum)"
                        case "/":
                        if firstValue != 0.0 {
                                    resultNum = String(secondValue / firstValue)
                                } else {
                                    lblResult.text = "Error" // Sıfıra bölme hatasını önlemek için
                                    firstNum = ""
                                    secondNum = ""
                                    resultNum = ""
                                }
                        lblResult.text = "= \(resultNum)"
                        case "%":
                        resultNum = String((firstValue / 100) * secondValue)
                        lblResult.text = "= \(resultNum)"
                        default:
                        resultNum = String(firstValue + secondValue)
                        lblResult.text = "= \(resultNum)"
                        }
                } else {
                    // Hata durumu yönetimi
                    resultNum = "Error"
                }
                
                }
            
        }
        
        print("operation \(operation) , firstNum \(firstNum),  secondNum \(secondNum)  resultNum \(resultNum)  ")
       
    }
    
    @IBAction func percent(_ sender: Any) {
        operation = "%"
        design()
    }
    @IBAction func divide(_ sender: Any) {
        operation = "/"
        design()
    }
    @IBAction func multiply(_ sender: Any) {
        operation = "*"
        design()
    }
    @IBAction func subtract(_ sender: Any) {
        operation = "-"
        design()
    }
    @IBAction func add(_ sender: Any) {
        operation = "+"
        design()
    }
    @IBAction func equals(_ sender: Any) {
        resultNum = String(doOperation())
        print(resultNum)
        if let label = lblCalculator
        {
               label.text = "\(label.text!) = \(resultNum)"
        }

        lblResult.font = UIFont.boldSystemFont(ofSize: lblResult.font.pointSize + 10)
                
                // Fontu 2 saniye sonra eski haline döndür
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                    self.lblResult.font = self.originalFont
                }
        firstNum = lblCalculator.text!
        secondNum = ""
        resultNum = ""
    }
    
    func doOperation() -> Double{
        if operation == "+"
        {
            if firstNum != "" && secondNum != ""
            {

                firstNum = String(Double(firstNum)! + Double(secondNum)!)
                secondNum = ""
                resultNum = ""
                print("operation  \(operation) , firstNum \(firstNum),  secondNum \(secondNum)  resultNum \(resultNum) ")
            }
            else
            {
                return (Double(firstNum)! + Double(secondNum)!)
            }
        }
        else if operation == "-"
        {
            if firstNum != "" && secondNum != ""
            {

                return Double(firstNum)! - Double(secondNum)!
             }
            else
            {
                return Double(resultNum)! - Double(afterResultNum)!
            }
            
        }
        else if operation == "*"
        {
            if firstNum != "" && secondNum != ""
            {
                
                return Double(firstNum)! * Double(secondNum)!
             }
            else
            {
                return Double(resultNum)! * Double(afterResultNum)!
            }
            
        }
        else if operation == "/"
        {
            if firstNum != "" && secondNum != "" && firstNum == "0"
            {
                return Double(firstNum)! / Double(secondNum)!
             }
            else
            {
                return Double(resultNum)! / Double(afterResultNum)!
            }
            
        }else if operation == "%"
        {
            if firstNum != "" && secondNum != ""
            {
               
                return Double(firstNum)! / Double(secondNum)!*100
             }
            else
            {
                return Double(resultNum)! / Double(afterResultNum)!*100
            }
            
        }
        print("operation  \(operation), firstNum \(firstNum),  secondNum \(secondNum)  resultNum \(resultNum) ")
        return 0
    }
    
    func design(){
        if resultNum == ""{
            secondNum = firstNum
            firstNum = ""
        }else{
            secondNum = resultNum
            firstNum = ""
            resultNum = ""
        }
        print("operation \(operation) , firstNum \(firstNum),  secondNum \(secondNum)  resultNum \(resultNum)  ")
        if let label = lblCalculator
        {
               label.text = "\(label.text!) \(operation)"
        }
    }
    
    
    
}
