//
//  WordListRouter.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListInteractable: Interactable {
    var router: WordListRouting? { get set }
    var listener: WordListListener? { get set }

    func removeFromRepository(_ wordItem: WordItem)
}

protocol WordListViewControllable: ViewControllable {
    // Declare methods the router invokes to manipulate the view hierarchy.
}

extension UINavigationController: WordListViewControllable {

}

final class WordListRouter: LaunchRouter<WordListInteractable, WordListViewControllable>, WordListRouting {

    //  Constructor inject child builder protocols to allow building children.
    override init(interactor: WordListInteractable, viewController: WordListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
