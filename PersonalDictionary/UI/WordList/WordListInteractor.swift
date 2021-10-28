//
//  WordListInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs
import RxSwift

protocol WordListRouting: LaunchRouting {
    // Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol WordListListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class WordListInteractor: PresentableInteractor<WordListViewModellable>, WordListInteractable {

    weak var router: WordListRouting?
    weak var listener: WordListListener?

    private let wordListRepository: WordListRepository
    private let translationService: TranslationService

    init(viewModel: WordListViewModellable,
         wordListRepository: WordListRepository,
         translationService: TranslationService) {
        self.wordListRepository = wordListRepository
        self.translationService = translationService
        super.init(presenter: viewModel)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // Pause any business logic.
    }

    func removeFromRepository(_ wordItem: WordItem) {

    }
}
