//
//  NewWordBuildable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

protocol NewWordBuildable: Buildable {
    func build(withListener listener: NewWordListener) -> NewWordRouting
}
