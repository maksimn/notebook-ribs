//
//  WordListRouting.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListRouting: LaunchRouting {
    // Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol WordListViewControllable: ViewControllable {
    // Declare methods the router invokes to manipulate the view hierarchy.
}
