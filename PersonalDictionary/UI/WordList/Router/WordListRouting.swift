//
//  WordListRouting.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

// Declare methods the interactor can invoke to manage sub-tree via the router.
protocol WordListRouting: LaunchRouting {

    func routeToNewWord()

    func hideNewWord()
}

// Declare methods the router invokes to manipulate the view hierarchy.
protocol WordListViewControllable: ViewControllable {

    func present(viewController: ViewControllable)

    func dismiss(viewController: ViewControllable)
}
