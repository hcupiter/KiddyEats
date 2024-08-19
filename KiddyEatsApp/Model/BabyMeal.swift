//
//  BabyMeal.swift
//  WeaningFoodApp
//
//  Created by Arya Adyatma on 15/08/24.
//

import Foundation
import SwiftUI

struct BabyMeal: Identifiable, Codable {
    var id: UUID
    var name: String
    var emoji: String
    var ingredients: [String]
    var allergens: [String]
    var cookingSteps: String
    var servingSize: Int
    var estimatedCookingTimeMinutes: Int
    
    init(id: UUID = UUID(), name: String, emoji: String, ingredients: [String], allergens: [String], cookingSteps: String, servingSize: Int, estimatedCookingTimeMinutes: Int) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.ingredients = ingredients
        self.allergens = allergens
        self.cookingSteps = cookingSteps
        self.servingSize = servingSize
        self.estimatedCookingTimeMinutes = estimatedCookingTimeMinutes
    }

}
