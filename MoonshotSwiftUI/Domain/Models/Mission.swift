import Foundation

/// Data type to describe a mission info from mission.json
struct Mission: Codable, Identifiable {

	/// Internal Data type for Mission crew members
	struct CrewRole: Codable {

		/// Name of the Member
		let name: String

		/// Role of the crew member
		let role: String
	}

	/// Special Identifier of the mission from json file
	let id: Int

	/// Specific time of starting the mission
	let launchDate: Date?

	/// Team comp of the crew
	let crew: [CrewRole]

	/// Some general information about the mission or it's members
	let description: String

	/// Computed property to automatically update mission name to display in UI
	var displayName: String {
		"Apollo \(id)"
	}

	/// Computed property to automatically update mission image to display in UI
	var image: String {
		"apollo\(id)"
	}

	/// Computed property to automatically convert the launching date of the mission
	var formattedLaunchDate: String {
		launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
	}
}
