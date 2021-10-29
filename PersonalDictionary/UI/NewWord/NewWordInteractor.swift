//
//  NewWordInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs
import RxSwift

protocol NewWordRouting: ViewableRouting {
    // Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol NewWordListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class NewWordInteractor: PresentableInteractor<NewWordViewModel>, NewWordInteractable {

    weak var router: NewWordRouting?
    weak var listener: NewWordListener?

    weak var viewModel: NewWordViewModel?

    private var langRepository: LangRepository

    // Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(viewModel: NewWordViewModel, langRepository: LangRepository) {
        self.langRepository = langRepository
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

    func fetchData() {
        viewModel?.allLangs = langRepository.allLangs
        viewModel?.sourceLang = langRepository.sourceLang
        viewModel?.targetLang = langRepository.targetLang
    }

    func save(sourceLang: Lang) {
        langRepository.sourceLang = sourceLang
    }

    func save(targetLang: Lang) {
        langRepository.targetLang = targetLang
    }

    func sendNewWordEvent(_ newWordText: String) {
    }
}
