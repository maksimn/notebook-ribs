//
//  WordListRouter.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

extension UINavigationController: WordListViewControllable {

}

final class WordListRouter: LaunchRouter<WordListInteractable, WordListViewControllable>, WordListRouting {

    let navigationController = UINavigationController()

    //  Constructor inject child builder protocols to allow building children.
    override init(interactor: WordListInteractable, viewController: WordListViewControllable) {
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController.setViewControllers([viewController.uiviewController], animated: false)
        super.init(interactor: interactor, viewController: navigationController)
        interactor.router = self
    }
}
