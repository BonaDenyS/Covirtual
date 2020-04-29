//
//  HomeViewModelProtocol.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

protocol HomeViewModelProtocol {
    var title: String { get }
    var coordinatorDelegate: HomeCoordinatorViewModelDelegate? { get set }
    
    func provinces(completion:@escaping (_ data:[String]) -> Void)
    func province(province:[String:Any], completion:@escaping (_ data:Case) -> Void)
    func timeUpdate() -> String
}
