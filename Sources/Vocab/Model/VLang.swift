enum VLang: Codable, CaseIterable, CustomStringConvertible {
    case French, English, German, Japanese, Flemish

    var description: String {
        
        switch self {
        case .French: return "Français"
        case .English: return "Anglais"
        case .German: return "Allemand"
        case .Japanese: return "Japonais"
        case .Flemish: return "Flamand"
        }
        
    }
}