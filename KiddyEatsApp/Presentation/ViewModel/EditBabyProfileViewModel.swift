//
//  EditBabyProfileViewModel.swift
//  KiddyEatsApp
//
//  Created by Gusti Rizky Fajar on 20/08/24.
//

import Foundation
import SwiftData

@Observable
class EditBabyProfileViewModel {
	
	var fetchedBabyProfile: BabyProfile?
    
    var toUpdateBabyName: String = ""
    var toUpdateBabyDate: Date = Date.now
    var toUpdateAllergenList: [String] = []
		
	// Use Case
	var getBabyProfileUseCase: GetBabyProfileDataProtocol
	// TODO: add variable to update baby profile
	var updateBabyProfileUseCase: UpdateBabyProfileDataProtocol
	
	init(
		getBabyProfileUseCase: GetBabyProfileDataProtocol,
		updateBabyProfileUseCase: UpdateBabyProfileDataProtocol
	) {
		self.getBabyProfileUseCase = getBabyProfileUseCase
		self.updateBabyProfileUseCase = updateBabyProfileUseCase
	}
	
	func initBabyProfile(modelContext: ModelContext) {
		self.fetchedBabyProfile = getBabyProfileUseCase.execute(modelContext: modelContext)
	}
	
	func updateBabyProfile(modelContext: ModelContext) {
        guard let fetchedBabyProfile = fetchedBabyProfile else {
            return
        }
        
		let toUpdateBabyProfile = BabyProfile(
            id: fetchedBabyProfile.id,
            name: toUpdateBabyName,
            gender: fetchedBabyProfile.gender,
            allergies: toUpdateAllergenList,
            dateOfBirth: toUpdateBabyDate,
            location: fetchedBabyProfile.location
        )
		
		updateBabyProfileUseCase.execute(modelContext: modelContext, toUpdateBabyProfile: toUpdateBabyProfile)
	}
    
    func setupViewModel(){
        if let fetchedBabyProfile = fetchedBabyProfile {
            toUpdateBabyName = fetchedBabyProfile.name
            toUpdateBabyDate = fetchedBabyProfile.dateOfBirth
            toUpdateAllergenList = fetchedBabyProfile.allergies
        }
        
    }
}
