import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
private var tipPercentage: Double = 15.0 {
didSet {
            tipPercentageLabel?.text = String(format: "%.0f%%", tipPercentage)
        }
    }
override func viewDidLoad() {
super.viewDidLoad()
tipSlider?.minimumValue = 0
tipSlider?.maximumValue = 30
tipSlider?.value = 15.0
if let value = tipSlider?.value {
let roundedValue = round(value / 5.0) * 5.0
tipSlider?.value = Float(roundedValue)
tipPercentage = Double(roundedValue)
} else {
tipPercentage = 15.0}
billTextField?.keyboardType = .decimalPad
billTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
       
        updateCalculations()
    }


    @IBAction func sliderChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / 5.0) * 5.0
        sender.value = roundedValue
        
        tipPercentage = Double(roundedValue)
        
        updateCalculations()
    }
    
    @objc func textFieldDidChange() {
        updateCalculations()
    }

    
    private func updateCalculations() {
        let billText = billTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        let billAmount = Double(billText) ?? 0.0
        
        let tip = billAmount * (tipPercentage / 100.0)
        let total = billAmount + tip
        
      
        tipAmountLabel?.text = String(format: "$%.2f", tip)
        totalAmountLabel?.text = String(format: "$%.2f", total)
    }
}
