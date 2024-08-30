import SwiftUI

/// ContentView of Detailed Screen
struct DetailedView: View {

	// MARK: - State Properties

	@StateObject private var viewModel: DetailedViewModel

	// MARK: - Initialization

	/// Designated Initializer
	/// - Parameter viewMode: DetailedViewModel accordingly to MVVM architecture
	init(viewModel: DetailedViewModel) {
		_viewModel = StateObject(wrappedValue: DetailedViewModel(astronaunts: viewModel.astronauts, mission: viewModel.mission))
	}

	// MARK: - Body

	var body: some View {
		ScrollView {
			VStack {
				Image(viewModel.mission.image)
					.resizable()
					.scaledToFit()
					.containerRelativeFrame(.horizontal) { width, axis in
						width * 0.6
					}
					.padding(.top)

				VStack(alignment: .leading) {
					Text("Mission Highlights")
						.font(.title.bold())
						.padding(.bottom, 5)

					Text("Launching Date")
						.font(.headline.bold())

					Text(viewModel.mission.formattedLaunchDate)

					getDivider()

					Text(viewModel.mission.description)

					getDivider()

					Text("Crew")
						.font(.title.bold())
						.padding(.bottom, 5)

					getHorizontalScrollView()
				}
				.padding(.horizontal)
			}
			.padding(.bottom)
		}
		.navigationTitle(viewModel.mission.displayName)
		.navigationBarTitleDisplayMode(.inline)
		.background(.darkBackground)
	}
}

// MARK: UI elements

private extension DetailedView {

	/// Separate method to create custom divider view
	func getDivider() -> some View {
		Rectangle()
			.frame(height: 2)
			.foregroundStyle(.lightBackground)
			.padding(.vertical)
	}

	/// Separate method to encapsulate logic and rendering of HorizontalScrollView which makes the structure of the whole screen
	func getHorizontalScrollView() -> some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(viewModel.crew, id: \.role) { crewMember in
					NavigationLink {
						AstronautView(viewModel: AstronautViewModel(astronaut: crewMember.astronaut))
					} label: {
						HStack {
							Image(crewMember.astronaut.id)
								.resizable()
								.frame(width: 104, height: 72)
								.clipShape(.capsule)
								.overlay(
									Capsule()
										.strokeBorder(.white, lineWidth: 1)
								)

							VStack(alignment: .leading) {
								Text(crewMember.astronaut.name)
									.foregroundStyle(.white)
									.font(.headline)

								Text(crewMember.role)
									.foregroundStyle(.white.opacity(0.5))
							}
						}
						.padding(.horizontal)
					}
				}
			}
		}
	}
}

// MARK: - Preview

#Preview {

	// Default mission for preview only

	DetailedView(
		viewModel: DetailedViewModel(
			astronaunts: ["Test": Astronaut(
				id: "2",
				name: "K2OM",
				description: "Test Object"
			)],
			mission: Mission(
				id: 5,
				launchDate: .now,
				crew: [Mission.CrewRole(
					name: "Ron",
					role: "Smart head"
				)],
				description: "Always hungry"
			)
		)
	)
}
