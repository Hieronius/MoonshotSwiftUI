import SwiftUI

/// Content View for Astronaut's Screen
struct AstronautView: View {

	// MARK: - State Properties

	@StateObject private var viewModel: AstronautViewModel

	// MARK: - Initialization

	init(viewModel: AstronautViewModel) {
		_viewModel = StateObject(wrappedValue: AstronautViewModel(astronaut: viewModel.astronaut))
	}

	// MARK: - Body

	var body: some View {
		ScrollView {
					VStack {
						Image(viewModel.astronaut.id)
							.resizable()
							.scaledToFit()

						Text(viewModel.astronaut.description)
							.padding()
					}
				}
				.background(.darkBackground)
				.navigationTitle(viewModel.astronaut.name)
				.navigationBarTitleDisplayMode(.inline)
	}
}

// MARK: - Preview

#Preview {
	AstronautView(
		viewModel: AstronautViewModel(
			astronaut: Astronaut(
				id: "9",
				name: "Again You Nil",
				description: "Yep, it's him again"
			)
		)
	)
}
