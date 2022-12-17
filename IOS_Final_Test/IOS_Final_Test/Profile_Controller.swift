//
//  Profile_Controller.swift
//  IOS_Final_Test
//
//  Created by Esha  on 2022-12-15.

//Student Name: Esha Naik
//Student ID: 301297804

//

import UIKit
import Firebase
import FirebaseDatabase

class Profile_Controller: UIViewController {
    
    
    let referenc=Database.database().reference()
    
    
    @IBOutlet weak var height_unit: UILabel!
    @IBOutlet weak var weight_unit: UILabel!
    
    @IBOutlet weak var e_height: UITextField!
    @IBOutlet weak var e_weight: UITextField!
    @IBOutlet weak var e_name: UITextField!
    @IBOutlet weak var e_age: UITextField!
    
    @IBOutlet weak var e_result: UITextField!
    @IBOutlet weak var e_category: UITextField!
    
    @IBOutlet weak var e_switch: UISwitch!
    @IBOutlet weak var bmi_calculate_view: UIView!
    
    
    
    var mode = "Metric"
    private var bmiScores: [Calc_model] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        e_result.text = ""
        e_category.text = ""
        unit_modify()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }
    func unit_modify(){
        if(mode == "Metric") {
            height_unit.text = "(m)"
            weight_unit.text = "(kg)"
        } else {
            height_unit.text = "(inch)"
            weight_unit.text = "(lbs)"
            
        }
    }
    
    
    @IBAction func done(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    

    @IBAction func unit_change_fun(_ sender: UISwitch) {
        if(sender.isOn) {
            mode = "Metric"
        } else {
            mode = "Imperial"
        }
        self.height_unit.text = ""
        self.weight_unit.text = ""
        unit_modify()
    }
    
    
    
    
    
    @IBAction func calculate_bmi(_ sender: Any) {
        if(!e_height.text!.isEmpty && !e_weight.text!.isEmpty) {
            if(Double(e_height.text!) != nil && Double(e_weight.text!) != nil) {
               
                let answer = IOS_Final_Test.calculate_bmi(weight: Double(e_weight.text!)!, height: Double(e_height.text!)!, mode: mode)
                var f_bmi = answer.bmi
                e_result.text = String(format: "%.1f", f_bmi)
                e_category.text = answer.Category
                let currentDate = Date()
                let dates = DateFormatter()
                dates.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = dates.string(from: currentDate)
                let f_name = e_name.text
                let f_age = e_age.text
                let f_height = e_height.text
                let f_weight = e_weight.text
                let f_category = e_category.text
                
               
                self.referenc.child(date1).setValue([
                    "name": f_name!,
                    "age": f_age!,
                    "height": f_height!,
                    "weight": f_weight!,
                    "bmi": f_bmi,
                    "category": f_category!,
                    "mode": mode,
                    "date": date1
                ])
            }
        } else {
            e_result.text = ""
            e_category.text = ""
        }
    }
    func load()
    {
        referenc.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { [self] (child) in
            if
                let snapshot = child as? DataSnapshot,
                let data_changed = snapshot.value as? [String:AnyObject],
                let n_name = data_changed["name"] as? String?,
                let n_age = data_changed["age"] as? String?,
                let n_height = data_changed["height"] as? String?,
                let n_weight = data_changed["weight"] as? String?,
                let n_mode = data_changed["mode"] as? String?,
                let n_bmi = data_changed["bmi"] as? Double?,
                let n_category = data_changed["category"] as? String {

                
                self.e_name.text = n_name
                self.e_age.text = n_age
                self.e_height.text = n_height
                self.e_weight.text = n_weight
                self.e_result.text = String(format: "%.1f", n_bmi!)
                self.e_category.text = n_category
                self.mode = n_mode!
               
                
                self.unit_modify()
            }
        });
    }
    
}
