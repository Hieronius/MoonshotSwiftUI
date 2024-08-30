import SwiftUI

final class AstronautViewModel: ObservableObject {

	// MARK: - State Properties

	/// Property to store selected astronaut's info
	@Published var astronaut: Astronaut

	// MARK: - Initialization
	
	/// Designated Initializer
	/// - Parameter astronaut: pass astronaut info from Detailed Screen
	init(astronaut: Astronaut) {
		self.astronaut = astronaut
	}
}
