import SwiftUI

extension ShapeStyle where Self == Color {

	/// A custom color for dark mode backgrounds.
	static var darkBackground: Color {
		Color(red: 0.1, green: 0.1, blue: 0.2)
	}

	/// A custom color for light mode backgrounds.
	static var lightBackground: Color {
		Color(red: 0.2, green: 0.2, blue: 0.3)
	}
}
