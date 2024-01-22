//
//  ApiManager.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 21/01/2024.
//

import Foundation

import Foundation

class ApiManager {
    private static let apiUrl = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")!
    private static let apiKey = "LpPDOtAzVYjTSBVmASp3MNWb3U0AVlVfps7jFIGM"  

    static func fetchMarsPhotos(completion: @escaping (MarsCamera?) -> Void) {
        var components = URLComponents(url: apiUrl, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = components?.url else {
            print("Ошибка при формировании URL.")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Ошибка при выполнении запроса: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Пустой ответ от сервера.")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let marsCamera = try decoder.decode(MarsCamera.self, from: data)
                completion(marsCamera)
            } catch {
                print("Ошибка при декодировании JSON: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }
}
