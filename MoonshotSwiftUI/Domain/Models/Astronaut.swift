import Foundation

/// The `Astronaut` struct conforms to both the `Codable` and `Identifiable` protocols, making it suitable for use in data models that require encoding/decoding to and from JSON, as well as uniquely identifying instances in SwiftUI views.
struct Astronaut: Codable, Identifiable {

	// MARK: - Properties

	/// Unique Identifier from JSON file
	let id: String

	/// Name of the Astronaut
	let name: String

	/// Info about an Astronaut
	let description: String
}
