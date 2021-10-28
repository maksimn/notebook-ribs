//
//  WordListBuildable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListBuildable: Buildable {
    func build() -> WordListRouting
}
