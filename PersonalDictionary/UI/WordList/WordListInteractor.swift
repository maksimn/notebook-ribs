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

protocol WordListPresentable: Presentable {
    var listener: WordListPresentableListener? { get set }
    // Declare methods the interactor can invoke the presenter to present data.
}

protocol WordListListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class WordListInteractor: PresentableInteractor<WordListPresentable>,
                                WordListInteractable,
                                WordListPresentableListener {

    weak var router: WordListRouting?
    weak var listener: WordListListener?

    private let wordListRepository: WordListRepository
    private let translationService: TranslationService

    init(presenter: WordListPresentable,
         wordListRepository: WordListRepository,
         translationService: TranslationService) {
        self.wordListRepository = wordListRepository
        self.translationService = translationService
        super.init(presenter: presenter)
        presenter.listener = self
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
