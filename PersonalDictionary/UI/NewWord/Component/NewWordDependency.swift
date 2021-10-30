//
//  NewWordDependency.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

protocol NewWordDependency: Dependency {
    // Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var langRepository: LangRepository { get }
}
