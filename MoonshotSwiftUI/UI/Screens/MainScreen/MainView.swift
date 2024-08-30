import SwiftUI

/// Content View for the MainScreen
struct MainView: View {

	// MARK: - State Properties

	@StateObject private var viewModel: MainViewModel

	/// Custom Toggle to change Grid/List presentation of the Missions
	@State private var gridToggleOn = false

	// MARK: - Properties

	/// Custom layout for the GridView
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]

	// MARK: - Initialization

	/// Designated Initializer
	/// - Parameter viewMode: MainViewModel accordingly to MVVM architecture
	init(viewMode: MainViewModel) {
		_viewModel = StateObject(wrappedValue: MainViewModel())

	}

	// MARK: - Body

	var body: some View {
		NavigationStack {
			ZStack {
				Color.darkBackground
					.ignoresSafeArea()

				Group {
					if gridToggleOn {
						getGridView()
					} else  {
						getListView()
					}
				}
			}
			.navigationTitle("Moonshot")
			.toolbar {
				Button {
					gridToggleOn.toggle()
					print("Grid Toggle is now: \(gridToggleOn)")
				} label: {
					Text("Switch mode")
						.font(.headline)
						.tint(.gray)
				}
			}
			.background(Color.darkBackground)
		}
		.background(Color.darkBackground)
	}
}

// MARK: UI Elements

private extension MainView {

	/// Private Method to encapsulate the list of Missions as GridView
	private func getGridView() -> some View {
		ScrollView {
			LazyVGrid(columns: columns) {
				ForEach(viewModel.missions) { mission in
					NavigationLink {
						DetailedView(viewModel: DetailedViewModel(astronaunts: viewModel.astronauts, mission: mission))
					} label: {
						VStack {

							// Image of the mission (label)
							Image(mission.image)
								.resizable()
								.scaledToFit()
								.frame(width: 100, height: 100)
								.padding()

							// Title of the mission
							VStack {
								Text(mission.displayName)
									.font(.headline)
									.foregroundStyle(.white)
								Text(mission.formattedLaunchDate)
									.font(.caption)
									.foregroundStyle(.gray)
							}
							.padding(.vertical)
							.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
							.background(.lightBackground)
						}
						.clipShape(.rect(cornerRadius: 20))
						.overlay(
							RoundedRectangle(cornerRadius: 20)
								.stroke(.lightBackground))
						.padding(8)
					}

				}
			}
			.padding([.horizontal, .bottom])
		}
		.background(Color.darkBackground)
	}

	/// Private Method to encapsulate the list of Missions as GridView
	private func getListView() -> some View {
		List {
			ForEach(viewModel.missions) { mission in
				NavigationLink {
					DetailedView(viewModel: DetailedViewModel(astronaunts: viewModel.astronauts, mission: mission))
				} label: {
					HStack {
						// Image of the mission (label)
						Image(mission.image)
							.resizable()
							.scaledToFit()
							.frame(width: 100, height: 100)
							.background()

						VStack(alignment: .leading) {
							// Title of the mission
							Text(mission.displayName)
								.font(.title2)
								.foregroundStyle(.white)
							Text(mission.formattedLaunchDate)
								.font(.caption)
								.foregroundStyle(.gray)
						}
						.padding(.vertical)
						.background(Color.darkBackground)
					}
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.darkBackground)
					)
					.padding(8)
				}
			}
			.listRowBackground(Color.darkBackground)
		}
		.background(Color.darkBackground)
		.scrollContentBackground(.hidden)
	}
}

// MARK: - Preview

#Preview {
	MainView(viewMode: MainViewModel())
}
