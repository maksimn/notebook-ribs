//
//  NewWordRouter.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs

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
