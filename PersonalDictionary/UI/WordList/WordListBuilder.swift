//
//  WordListBuilder.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListBuildable: Buildable {
    func build() -> WordListRouting
}

final class WordListBuilder: Builder<WordListDependency>, WordListBuildable {

    override init(dependency: WordListDependency) {
        super.init(dependency: dependency)
    }

    func build() -> WordListRouting {
        let component = WordListComponent()
        let viewController = WordListViewController(staticContent: component.staticContent,
                                                    styles: component.styles)
        let interactor = WordListInteractor(presenter: viewController,
                                            wordListRepository: component.wordListRepository,
                                            translationService: component.translationService)
        return WordListRouter(interactor: interactor, viewController: viewController)
    }
}
