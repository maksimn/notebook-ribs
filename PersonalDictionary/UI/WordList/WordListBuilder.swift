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
        let navigationController = UINavigationController()
        let viewController = WordListViewController(staticContent: component.staticContent,
                                                    styles: component.styles)

        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController.setViewControllers([viewController], animated: false)

        let viewModel = WordListViewModel(view: viewController)

        viewController.viewModel = viewModel

        let interactor = WordListInteractor(viewModel: viewModel,
                                            wordListRepository: component.wordListRepository,
                                            translationService: component.translationService)

        viewModel.interactor = interactor

        return WordListRouter(interactor: interactor, viewController: navigationController)
    }
}
