//
//  ProfileView.swift
//  KiddyEatsApp
//
//  Created by Gusti Rizky Fajar on 20/08/24.
//

import SwiftUI

struct ProfileView: View {
	@Environment(\.modelContext)
	var modelContext
	
	@Bindable
	var viewModel = EditBabyProfileViewModel(
		getBabyProfileUseCase: GetBabyProfileData(repo: BabyProfileRepositoryImpl.shared),
		updateBabyProfileUseCase: UpdateBabyProfileData(repo: BabyProfileRepositoryImpl.shared)
	)
	
    var body: some View {
		NavigationStack {
			if let babyProfile = viewModel.babyProfile {
				VStack(alignment: .leading) {
					Section {
						// Baby Gender, Baby Age months old
						Text("\(babyProfile.gender), \(babyProfile.ageMonths) months old")
							.padding(.bottom, 20)
					} header: {
						// Baby Name
						Text("\(babyProfile.name)")
							.font(.title2)
							.fontWeight(.semibold)
					}
					
					Section {
						Text(viewModel.getAllergies())
							.padding()
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(
								RoundedRectangle(cornerRadius: 10)
									.foregroundStyle(.exploreCardBackground)
									.overlay(
										RoundedRectangle(cornerRadius: 10)
											.stroke(lineWidth: 3)
											.foregroundStyle(.greenPrimary)
									)
							)

					} header: {
						Text("Allergy Analysis")
							.font(.title2)
							.fontWeight(.semibold)
					}
					
					Spacer()
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(.appBackground)
				.navigationTitle("Your Baby's Profile")
				.toolbar {
					ToolbarItem(placement: .primaryAction) {
						Button {
							withAnimation {
								
							}
						} label: {
							Label("Edit Profile", systemImage: "gear")
						}
					}
				}

			}
		}
		.onAppear {
			print("onappear")
			viewModel.initBabyProfile(modelContext: modelContext)
		}
    }
}

#Preview {
    ProfileView()
}
