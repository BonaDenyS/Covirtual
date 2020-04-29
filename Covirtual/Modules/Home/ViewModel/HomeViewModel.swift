//
//  HomeViewModel.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

struct HomeViewModel {
    var coordinatorDelegate: HomeCoordinatorViewModelDelegate?
    var title = "Home"
    
}

extension HomeViewModel: HomeViewModelProtocol {
    func timeUpdate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        return "Pembaharuan terakhir \(formatter.string(from: Date()))"
    }
    
    func province(province: [String:Any], completion: @escaping (Case) -> Void) {
        let appNetwork = AppNetwork()
        appNetwork.get(url: "province",params: province, method: .post) { (data, response, error) in
            do {
                completion(try JSONDecoder().decode(Case.self, from: data!))
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
    
    func provinces(completion: @escaping ([String]) -> Void) {
        let appNetwork = AppNetwork()
        appNetwork.get(url: "provinces",params: [:], method: .post) { (data, response, error) in
            do {
                completion(try JSONDecoder().decode([String].self, from: data!))
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}
