//
//  Calc_model.swift
//  IOS_Final_Test
//
//  Created by Esha  on 2022-12-15.

//Student Name: Esha Naik
//Student ID: 301297804
//

import Foundation

class Calc_model
{
    var name: String
    var age: Int
    var height: Double
    var weight: Double
    var bmi: Double
    var category: String
    var mode: String
    var date: String
   
   init( name: String, age:Int = 1, height: Double = 0.0, weight: Double = 0.0, bmi: Double = 0.0, category: String = "", mode: String = "", date: String = "")
   {
       self.name = name
       self.age = age
       self.height = height
       self.weight = weight
       self.bmi = bmi
       self.category = category
       self.mode =  mode
       self.date = date
   }
}
