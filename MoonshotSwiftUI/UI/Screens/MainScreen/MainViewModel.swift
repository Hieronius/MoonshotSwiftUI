import SwiftUI

/// ViewModel for MainView
final class MainViewModel: ObservableObject {

	// MARK: - Published Properties

	/// Property to store astronauts from file - `astronaunts.json`
	@Published var astronauts: [String: Astronaut] = [:]

	/// Property to store space mission from file - `missions.json`
	@Published var missions: [Mission] = []

	// MARK: - Properties

	/// Property to use JSONDecoder service
	let jsonDecoder: JSONDecoderServiceProtocol.Type

	// MARK: - Initialization
	
	/// Designated Initializer
	/// - Parameter jsonDecoder: Enum Service to decode data
	init(jsonDecoder: JSONDecoderServiceProtocol.Type = JSONDecoderService.self) {
		self.jsonDecoder = jsonDecoder

		prepareMissionsToDisplay()
		prepareAstronautsToDisplay()
	}

	// MARK: - Private Methods

	/// Load and decode (populate) missions
	private func prepareMissionsToDisplay() {
		if let data = loadDataFromBundle(fileName: "missions.json"),
		   let decodedMissions: [Mission] = jsonDecoder.decodeData(inputData: data) {
			self.missions = decodedMissions
		} else {
			self.missions = []
		}
	}

	/// Load and decode (populate) astronauts array
	private func prepareAstronautsToDisplay() {
		if let data = loadDataFromBundle(fileName: "astronauts.json"),
		   let decodedAstronauts: [String: Astronaut] = jsonDecoder.decodeData(inputData: data) {
			self.astronauts = decodedAstronauts
		} else {
			self.astronauts = [:]
		}
	}

	/// Utility function to load data from the bundle
	private func loadDataFromBundle(fileName: String) -> Data? {
		guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
			print("Failed to locate \(fileName) in bundle.")
			return nil
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(fileName) from bundle.")
		}

		return data
	}
}
