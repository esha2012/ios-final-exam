//
//  history.swift
//  IOS_Final_Test
//
//  Created by Esha  on 2022-12-15.
//Student Name: Esha Naik
//Student ID: 301297804
//

import UIKit
import Firebase
import FirebaseDatabase


class history: UITableViewController {
    
    
    let referenc = Database.database().reference()
    
    private var bmi_calc: [Calc_model] = []
    let cell_item = "historyCell"
    
    
    var name_last: String?
    var age_last: String?
    var height_last: String?
    var mode_last: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(table_content.self,
                               forCellReuseIdentifier: cell_item)
        tableView.rowHeight = 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get_atlast()
        load()
    }
    func get_atlast()
    {
        referenc.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { [self] (child) in
            if
                let snapshot = child as? DataSnapshot,
                let data_changed = snapshot.value as? [String:AnyObject],
                let label_name = data_changed["name"] as? String?,
                let label_age = data_changed["age"] as? String?,
                let label_height = data_changed["height"] as? String?,
                let label_mode = data_changed["mode"] as? String? {

                self.name_last = label_name!
                self.age_last = label_age!
                self.height_last = label_height!
                self.mode_last = label_mode!
                
            }
        });
    }
    
    func load()
    {
        bmi_calc.removeAll()
        referenc.observeSingleEvent(of: .value) {
            snapshot  in
            var bmi_array: [Calc_model] = []
            //
            for child in snapshot.children {
                //
                if
                    let snapshot = child as? DataSnapshot,
                    let data_changed = snapshot.value as? [String:AnyObject],
                    let name_label = data_changed["name"] as? String?,
                    let age_label = data_changed["age"] as? String?,
                    let height_label = data_changed["height"] as? String?,
                    let weight_label = data_changed["weight"] as? String?,
                    let bmi_label = data_changed["bmi"] as? Double,
                    let mode_label = data_changed["mode"] as? String?,
                    let date_label = data_changed["date"] as? String?,
                    let category_label = data_changed["category"] as? String {

                    bmi_array.append(Calc_model(name: name_label!, age: Int(age_label!)!, height: Double(height_label!)!, weight: Double(weight_label!)!, bmi: bmi_label, category: category_label, mode: mode_label!, date: date_label!))
                    
                }
            }
            self.bmi_calc.append(contentsOf: bmi_array)
            self.tableView.reloadData()
            self.referenc.removeAllObservers()
        }
        
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bmi_calc.count == 0 {
            self.tableView.blank("History is not Available")
        } else {
            self.tableView.refresh()
        }
        return bmi_calc.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let column = tableView.dequeueReusableCell(withIdentifier: cell_item, for: indexPath) as! table_content
        let row = bmi_calc[indexPath.row]
        
        if(row.mode == "Metric") {
            column.w_ui.text = "Weight: " + String(format: "%.1f", row.weight) + " kg"
        } else {
            column.w_ui.text = "Weight: " + String(format: "%.1f", row.weight) + " lbs"
        }
        column.bmi_ui.text = "BMI: " + String(format: "%.1f", row.bmi)
        column.c_ui.text = row.category
        column.d_ui.text = row.date
        return column
    }
    
    

}

extension UITableView {

    func blank(_ msg: String) {
        let msg_lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        msg_lbl.text = msg
        msg_lbl.textColor = .yellow
        msg_lbl.numberOfLines = 0
        msg_lbl.textAlignment = .center
        msg_lbl.font = UIFont(name: "Roboto", size: 20)
        msg_lbl.sizeToFit()

        self.backgroundView = msg_lbl
        self.separatorStyle = .none
    }

    func refresh() {
        self.backgroundView = nil
       
    }
}
