//
//  NetworkDataFetcher.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol NetworkDataFetherProtocol {
    func getSession(completion: @escaping (Result<SessionResponse?, Error>) -> Void)
    func getNotes(session: String,  completion: @escaping (Result<NoteResponse?, Error>) -> Void)
    func createNewNote(session: String, userText: String, completion: @escaping (Result<SessionResponse?, Error>) -> Void)
}

final class NetworkDataFether: NetworkDataFetherProtocol {
    
    let networking = NetworkService()
    
    func getSession(completion: @escaping (Result<SessionResponse?, Error>) -> Void) {
        let param = ["a": API.newSession]
        self.fetchJSONData(params: param, response: completion)
    }
    
    func getNotes(session: String,  completion: @escaping (Result<NoteResponse?, Error>) -> Void) {
        let param = ["session": session, "a": API.getEntries]
        self.fetchJSONData(params: param, response: completion)
    }
    
    func createNewNote(session: String, userText: String, completion: @escaping (Result<SessionResponse?, Error>) -> Void) {
        let param = ["session": session,
                     "body"   : userText,
                     "a"      : API.addEntry]
        
        self.fetchJSONData(params: param, response: completion)
    }
    
    private func fetchJSONData<T: Decodable>(params: [String: String], response: @escaping (Result<T?, Error>) -> Void) {
        networking.request(params: params) { (result) in
            switch result {
            case .success(let data):
                let decodedData = self.decodeJSON(type: T.self, from: data)
                response(.success(decodedData))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
