//
//  Bundle-Decoder.swift
//  Moonshot
//
//  Created by @andreev2k on 13.09.2022.
//

import Foundation

// создаем расширение "extension Bundle" с помощью ДЖЕНЕРИКОВ<T>(для работы с разными .json файлами), для расширения функциональности приложения
extension Bundle {
    // метод для расшифровки данных из локальных ".json"
    func decode<T: Codable>(_ file: String) -> T {
        // ищем файл(file) в собственных(self.url) ресурсах приложения
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Неудалось найти \(file) в пакете приложения")
        }
        // загружаем данные, если file найден
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Невозможно загрузить \(file) из пакета приложения")
        }
        
        let decoder = JSONDecoder()
        
        // добавляем форматирование даты полученной из .json
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // расшифровываем даные из file
        guard let loadData = try? decoder.decode(T.self, from: data) else {
            fatalError("Неправильный формат \(file) в пакете приложения")
        }
        return loadData
    }
}
