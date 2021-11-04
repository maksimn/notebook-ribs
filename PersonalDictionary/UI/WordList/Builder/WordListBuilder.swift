//
//  WordListBuilder.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

final class WordListBuilder: Builder<EmptyDependency>, WordListBuildable {

    init() {
        super.init(dependency: EmptyComponent())
    }

    func build() -> WordListRouting {
        let component = WordListComponent(globalSettings: pdGlobalSettings)
        let navigationController = UINavigationController()
        let viewController = WordListViewController(params: component.viewParams)

        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController.setViewControllers([viewController], animated: false)

        let viewModel = WordListViewModel(view: viewController)

        viewController.viewModel = viewModel

        let interactor = WordListInteractor(viewModel: viewModel,
                                            wordListRepository: component.wordListRepository,
                                            translationService: component.translationService)

        viewModel.interactor = interactor

        let newWordBuilder = NewWordBuilder(dependency: component)

        return WordListRouter(interactor: interactor,
                              viewController: navigationController,
                              newWordBuilder: newWordBuilder)
    }
}

extension UINavigationController: WordListViewControllable {

    func present(viewController: ViewControllable) {
        let uiviewController = viewController.uiviewController

        uiviewController.modalPresentationStyle = .overFullScreen
        topViewController?.present(uiviewController, animated: true, completion: nil)
    }

    func dismiss(viewController: ViewControllable) {
        viewController.uiviewController.dismiss(animated: true, completion: nil)
    }
}
