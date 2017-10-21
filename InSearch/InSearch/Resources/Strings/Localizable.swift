// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs

enum L10n {

  enum Auth {
    /// Enter
    static let enterButtonTitle = L10n.tr("Auth.EnterButtonTitle")
  }

  enum Events {
    /// Events
    static let title = L10n.tr("Events.Title")
  }

  enum Favors {
    /// Done
    static let done = L10n.tr("Favors.Done")
    /// What do you love?
    static let title = L10n.tr("Favors.Title")
  }

  enum Reactions {
    /// Mutual sympathy
    static let mutual = L10n.tr("Reactions.Mutual")
    /// Sympathy
    static let single = L10n.tr("Reactions.Single")

    enum Pickerview {
        /// Years
        static let ageLabelGenitivePlural = L10n.tr("PickerView.AgeLabelGenitivePlural")
        /// Years
        static let ageLabelGenitiveSingular = L10n.tr("PickerView.AgeLabelGenitiveSingular")
        /// Years
        static let ageLabelNominative = L10n.tr("PickerView.AgeLabelNominative")
        /// The list is empty, try again later
        static let emptyScreenLabel = L10n.tr("PickerView.EmptyScreenLabel")
        /// Invite
        static let inviteButtonTitle = L10n.tr("PickerView.InviteButtonTitle")
    }

extension L10n {
  fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:enable type_body_length
// swiftlint:enable nesting
// swiftlint:enable variable_name
// swiftlint:enable valid_docs
