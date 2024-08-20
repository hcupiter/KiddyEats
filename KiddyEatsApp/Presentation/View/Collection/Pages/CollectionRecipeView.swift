//
//  CollectionFavoriteView.swift
//  KiddyEatsApp
//
//  Created by Gusti Rizky Fajar on 19/08/24.
//

import SwiftUI

struct CollectionRecipeView: View {
	var babyMeal: [BabyMealSchema]
	
    var body: some View {
		List {
			ForEach(babyMeal) { meals in
				NavigationLink {
					// TODO: Change the destination to recipe detail page
					EmptyView()
				} label: {
					RecipeListView(mealRecipe: meals)
				}
			}
			.listRowSeparator(.hidden)
			.listRowBackground(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.gray, lineWidth: 0.5)
			)
		}
		.listRowSpacing(10)
		.scrollContentBackground(.hidden)
		.padding(.top, -20)
    }
}
