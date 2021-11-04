//
//  NewWordComponent.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

final class NewWordComponent: Component<NewWordDependency> {

    let langRepository: LangRepository

    let viewParams: NewWordViewParams

    init(dependency: NewWordDependency, globalSettings: PDGlobalSettings) {
        self.langRepository = dependency.langRepository
        viewParams = NewWordViewParams(
            staticContent: NewWordViewStaticContent(
                selectButtonTitle: NSLocalizedString("Select", comment: ""),
                arrowText: NSLocalizedString("⇋", comment: ""),
                okText: NSLocalizedString("OK", comment: ""),
                textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
            ),
            styles: NewWordViewStyles(backgroundColor: globalSettings.appBackgroundColor)
        )
        super.init(dependency: dependency)
    }
}
