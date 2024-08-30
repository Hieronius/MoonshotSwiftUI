import Foundation

/// Protocol to define a behaviour of our service to decode data
protocol JSONDecoderServiceProtocol {

	/// Static Method to decode the given data into generic output
	static func decodeData<T: Decodable>(inputData: Data) -> T
}

/// Service to decode the given data
enum JSONDecoderService: JSONDecoderServiceProtocol {

	// MARK: - Methods

	/// Decodes JSON data into a specified Decodable type.
	///
	/// - Parameter inputData: The JSON data to decode, provided as a `Data` object.
	/// - Returns: An instance of type `T` decoded from the JSON data.
	/// - Throws: A runtime error if decoding fails due to issues such as missing keys, type mismatches, or corrupted data.
	///
	/// - Note:
	///   - The method uses a `DateFormatter` with the format "yyyy-MM-dd" to decode date strings.
	///   - If decoding fails, the method will terminate the program using `fatalError` with a descriptive message. This is suitable for debugging but should be handled more gracefully in production code.
	static func decodeData<T: Decodable>(inputData: Data) -> T {
		let decoder = JSONDecoder()

		let formatter = DateFormatter()
		formatter.dateFormat = "y-MM-dd"
		decoder.dateDecodingStrategy = .formatted(formatter)

		do {
			return try decoder.decode(T.self, from: inputData)

		} catch DecodingError.keyNotFound(let key, let context) {
			fatalError("Failed to decode \(inputData) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
		} catch DecodingError.typeMismatch(_, let context) {
			fatalError("Failed to decode \(inputData) from bundle due to type mismatch – \(context.debugDescription)")
		} catch DecodingError.valueNotFound(let type, let context) {
			fatalError("Failed to decode \(inputData) from bundle due to missing \(type) value – \(context.debugDescription)")
		} catch DecodingError.dataCorrupted(_) {
			fatalError("Failed to decode \(inputData) from bundle because it appears to be invalid JSON.")
		} catch {
			fatalError("Failed to decode \(inputData) from bundle: \(error.localizedDescription)")
		}
	}
}
