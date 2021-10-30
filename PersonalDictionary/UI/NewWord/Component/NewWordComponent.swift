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
}
