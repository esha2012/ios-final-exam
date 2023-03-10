//
//  table.swift
//  IOS_Final_Test
//
//  Created by Esha  on 2022-12-15.
//Student Name: Esha Naik
//Student ID: 301297804
//


import Foundation
import UIKit



func getCategory(bmi: Double) -> String
{
    var category = ""
    switch bmi {
    case let x where x < 16:
        category = "Severe Thinness"
    case 16...17:
        category = "Moderate Thinness"
    case 17...18.5:
        category = "Mild Thinness"
    case 18.5...25:
        category = "Normal"
    case 25...30:
        category = "Overweight"
    case 30...35:
        category = "Obese Class I"
    case 35...40:
        category = "Obese Class II"
    default:
        category = "Obese Class III"
    }
    
    return category
}

func calculate_bmi(weight: Double = 0, height: Double = 0, mode: String = "") -> (bmi: Double, Category: String)
{
    var bmi = 0.0
    if(mode == "Metric") {
        bmi = weight / (height * height)
    } else if(mode == "Imperial") {
        bmi = (weight / (height * height)) * 703
    }
    var Category = getCategory(bmi: bmi)
    
    return (bmi, Category)
}
