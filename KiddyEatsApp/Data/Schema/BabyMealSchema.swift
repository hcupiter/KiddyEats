//
//  BabyMealSchema.swift
//  KiddyEatsApp
//
//  Created by Hans Arthur Cupiterson on 19/08/24.
//

import Foundation
import SwiftData

@Model
final class BabyMealSchema {
    @Attribute(.unique) var id: UUID
    var name: String?
    var emoji: String?
    var ingredients: [String]?
    var allergens: [String]?
    var cookingSteps: String?
    var servingSize: Int?
    var estimatedCookingTimeMinutes: Int?
	var isAllergic: Bool?
    
    init(id: UUID, name: String, emoji: String, ingredients: [String], allergens: [String], cookingSteps: String, servingSize: Int, estimatedCookingTimeMinutes: Int) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.ingredients = ingredients
        self.allergens = allergens
        self.cookingSteps = cookingSteps
        self.servingSize = servingSize
        self.estimatedCookingTimeMinutes = estimatedCookingTimeMinutes
		self.isAllergic = isAllergic
    }
    
    func mapToBabyMeal() -> BabyMeal {
        return BabyMeal(
            id: self.id,
            name: self.name ?? "",
            emoji: self.emoji ?? "",
            ingredients: self.ingredients ?? [],
            allergens: self.allergens ?? [],
            cookingSteps: self.cookingSteps ?? "",
            servingSize: self.servingSize ?? -1,
			estimatedCookingTimeMinutes: self.estimatedCookingTimeMinutes ?? -1,
			isAllergic: false
        )
    }
}
