//
//  NewWordRouter.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs

protocol NewWordInteractable: Interactable {

    var router: NewWordRouting? { get set }

    var listener: NewWordListener? { get set }

    var viewModel: NewWordViewModel? { get set }

    func save(sourceLang: Lang)

    func save(targetLang: Lang)

    func sendNewWord(_ text: String)

    func dismiss()
}

protocol NewWordViewControllable: ViewControllable {
    // Declare methods the router invokes to manipulate the view hierarchy.
}

final class NewWordRouter: ViewableRouter<NewWordInteractable, NewWordViewControllable>, NewWordRouting {

    // Constructor inject child builder protocols to allow building children.
    override init(interactor: NewWordInteractable, viewController: NewWordViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
