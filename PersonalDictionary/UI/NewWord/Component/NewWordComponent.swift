//
//  NewWordComponent.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

final class NewWordComponent: Component<NewWordDependency> {

    let langRepository: LangRepository

    override init(dependency: NewWordDependency) {
        self.langRepository = dependency.langRepository
        super.init(dependency: dependency)
    }

    let staticContent = NewWordViewStaticContent(
        selectButtonTitle: NSLocalizedString("Select", comment: ""),
        arrowText: NSLocalizedString("⇋", comment: ""),
        okText: NSLocalizedString("OK", comment: ""),
        textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
    )

    let styles = NewWordViewStyles(backgroundColor: appBackgroundColor)
}
