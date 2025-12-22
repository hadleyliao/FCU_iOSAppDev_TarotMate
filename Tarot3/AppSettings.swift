import SwiftUI

@Observable
class AppSettings {
    var colorScheme: ColorScheme? = nil // nil means follow system setting
}
