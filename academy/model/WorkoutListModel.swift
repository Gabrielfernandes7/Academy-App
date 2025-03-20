//
//  TaskModel.swift
//  AcademyApp
//
//  Created by User on 12/03/25.
//

import Foundation
import Observation

import SwiftData

@Model
class WorkoutModel: Identifiable {
    
    var title: String
    var repetition: String
    var weight: Int
    var isDone: Bool
    
    init(title: String, repetition: String, weight: Int, isDone: Bool = false) {
        self.title = title
        self.repetition = repetition
        self.weight = weight
        self.isDone = isDone
    }
}
