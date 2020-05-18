

import UIKit
import RealmSwift

class PopOverForm: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    
    var items: Results<Data>?
    
    let numbers = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let unitMeasurement = ["piece","lb","oz","dozen","ct","bunch","kg","gr"]
    
    var unitMeasurementSelected = ""
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var store: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var estimatedPrice: UITextField!
    @IBOutlet weak var quantityPriceTag: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var buyingQuantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        

    }

    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        print("\(brand.text!)")
        
        let newItem = Data()
        
        newItem.store = store.text!
        newItem.itemName = itemName.text!
        newItem.brand = brand.text!
        newItem.estimatedPrice = Float(estimatedPrice.text!)!
        newItem.buyingQuantity = Double(buyingQuantity.text!)!
        newItem.note = note.text!
        newItem.quantityForEstimatedPrice = Double(quantityPriceTag.text!)!
        newItem.unitMeasurement = unitMeasurementSelected
        
        self.saveItems(itemArray: newItem)
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func saveItems(itemArray: Data) {
        do {
            try realm.write {
                realm.add(itemArray)
            }
        } catch {
            print("Error Saving Item \(error)")
        }
    }
    
    
    //MARK: - Picker View Delegate and Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitMeasurement.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        unitMeasurementSelected = unitMeasurement[row]
        print(unitMeasurement[row])

    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return unitMeasurement[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Times New Roman", size: 18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = unitMeasurement[row]
        pickerLabel?.textColor = UIColor.blue

        return pickerLabel!
    }

}