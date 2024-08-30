import SwiftUI

/// ViewModel for DetailedView
final class DetailedViewModel: ObservableObject {

	// MARK: - Published Properties

	/// Property to store astronauts from the `astronauts.json` file
	@Published var astronauts: [String: Astronaut] = [:]

	/// Property to store an information about selected Mission with default value
	@Published var mission: Mission = Mission(
		id: 10,
		launchDate: .now,
		crew: [Mission.CrewRole(
			name: "Harry",
			role: "Magician"
		)],
		description: "The best student of Severus Snape"
	)

	/// Property to store an actual list of Crew Members of the selected Mission
	@Published var crew: [CrewMember] = []

	// MARK: - Properties

	/// Struct to identify properties of Crew Member of the selected Mission
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	}

	// MARK: - Initialization
	
	/// Designated Initializer
	/// - Parameters:
	///   - astronaunts: pass astronaunts list from MainScreen
	///   - mission: pass selected mission
	init(astronaunts: [String: Astronaut], mission: Mission) {
		self.astronauts = astronaunts
		self.mission = mission
		self.getCrew()
	}

	// MARK: - Private Methods

	/// Private method to get a specific team of mission's members to display at the bottom of the view
	private func getCrew() {
		self.crew = mission.crew.map { member in
			if let astronaut = astronauts[member.name] {
				return DetailedViewModel.CrewMember(role: member.role, astronaut: astronaut)
			} else {
				return DetailedViewModel.CrewMember(role: "asdads", astronaut: Astronaut(id: "asd", name: "asdasd", description: "asdds"))
			}

		}
	}
}
