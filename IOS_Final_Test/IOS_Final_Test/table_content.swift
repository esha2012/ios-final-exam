//
//  table_content.swift
//  IOS_Final_Test
//
//  Created by Esha  on 2022-12-15.
//Student Name: Esha Naik
//Student ID: 301297804
//

import UIKit

class table_content: UITableViewCell {
    
    var w_ui: UILabel!
    var bmi_ui: UILabel!
    var c_ui: UILabel!
    var d_ui: UILabel!
    var cell_ui: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
                
        let value_weight = CGRect(x:130, y:0, width: 150, height: 30)
        w_ui = UILabel(frame: value_weight)
        w_ui.font = UIFont(name: w_ui.font.fontName, size: 15)
        contentView.addSubview(w_ui)
        
        let value_bmi = CGRect(x:130, y:16, width: 80, height: 30)
        bmi_ui = UILabel(frame: value_bmi)
        bmi_ui.font = UIFont(name: bmi_ui.font.fontName, size: 15)
        contentView.addSubview(bmi_ui)
        
        let value_category = CGRect(x:130, y:32, width: 150, height: 30)
        c_ui = UILabel(frame: value_category)
        c_ui.font = UIFont(name: c_ui.font.fontName, size: 15)
        contentView.addSubview(c_ui)
        
        let value_date = CGRect(x:130, y:48, width: 150, height: 30)
        d_ui = UILabel(frame: value_date)
        d_ui.font = UIFont(name: d_ui.font.fontName, size: 12)
        contentView.addSubview(d_ui)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
  


    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20))
    }

}
