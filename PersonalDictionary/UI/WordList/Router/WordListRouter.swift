//
//  WordListRouter.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

final class WordListRouter: LaunchRouter<WordListInteractable, WordListViewControllable>, WordListRouting {

    private let newWordBuilder: NewWordBuildable
    private var newWord: NewWordRouting?

    init(interactor: WordListInteractable,
         viewController: WordListViewControllable,
         newWordBuilder: NewWordBuildable) {
        self.newWordBuilder = newWordBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToNewWord() {
        let newWord = newWordBuilder.build(withListener: interactor)

        self.newWord = newWord
        attachChild(newWord)
        viewController.present(viewController: newWord.viewControllable)
    }

    func hideNewWord() {
        if let newWord = newWord {
            detachChild(newWord)
            viewController.dismiss(viewController: newWord.viewControllable)
            self.newWord = nil
        }
    }
}
