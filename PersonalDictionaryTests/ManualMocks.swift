//
//  ManualMocks.swift
//  PersonalDictionaryTests
//
//  Created by Maxim Ivanov on 06.11.2021.
//

import RxSwift
import RIBs

extension MockWordListRouting: LaunchRouting {
    func launchFromWindow(_ window: UIWindow) {
        fatalError()
    }

    var viewControllable: ViewControllable {
        fatalError()
    }

    var interactable: Interactable {
        fatalError()
    }

    var children: [Routing] {
        []
    }

    func load() {
    }

    func attachChild(_ child: Routing) {

    }

    func detachChild(_ child: Routing) {

    }

    var lifecycle: Observable<RouterLifecycle> {
        fatalError()
    }
}

extension WordListRoutingStub: LaunchRouting {
    func launchFromWindow(_ window: UIWindow) {
        fatalError()
    }

    var viewControllable: ViewControllable {
        fatalError()
    }

    var interactable: Interactable {
        fatalError()
    }

    var children: [Routing] {
        []
    }

    func load() {
    }

    func attachChild(_ child: Routing) {

    }

    func detachChild(_ child: Routing) {

    }

    var lifecycle: Observable<RouterLifecycle> {
        fatalError()
    }
}
