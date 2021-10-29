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

    //  Constructor inject child builder protocols to allow building children.
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
        viewController.presentNewWord(viewController: newWord.viewControllable)
    }

    func hideNewWord() {
        if let newWord = newWord {
            detachChild(newWord)
            viewController.dismissNewWord(viewController: newWord.viewControllable)
            self.newWord = nil
        }
    }
}
