//
//  ValueType.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

enum PropertyType: CaseIterable {
    case name
    case model
    case year
    case mileage
    case bodyType
    case manufacturer
    case country
    
    func getName() -> String {
        switch self {
        case .name:
            return "Название"
        case .model:
            return "Модель"
        case .year:
            return "Год"
        case .mileage:
            return "Пробег"
        case .bodyType:
            return "Тип кузова"
        case .manufacturer:
            return "Производитель"
        case .country:
            return "Страна"
        }
    }
    
    func getPlaceholderValue() -> String {
        switch self {
        case .name:
            return "здесь пишем название"
        case .model:
            return "здесь пишем модель"
        case .year:
            return "здесь пишем год"
        case .mileage:
            return "здесь пишем пробег"
        case .bodyType:
            return "здесь пишем тип кузова"
        case .manufacturer:
            return "здесь пишем производителя"
        case .country:
            return "здесь пишем страну"
        }
    }
    
    func applyPropertyToCar(_ car: inout LocalCar, value: String) {
        switch self {
        case .name:
            car.name = value
        case .model:
            car.model = value
        case .year:
            car.year = value
        case .mileage:
            car.mileage = value
        case .bodyType:
            car.bodyType = value
        case .manufacturer:
            car.manufacturer = value
        case .country:
            car.country = value
        }
    }
    
    func extractPropertyFromCar(_ car: LocalCar) -> String {
        switch self {
        case .name:
            return car.name ?? ""
        case .model:
            return car.model ?? ""
        case .year:
            return car.year ?? ""
        case .mileage:
            return car.mileage ?? ""
        case .bodyType:
            return car.bodyType ?? ""
        case .manufacturer:
            return car.manufacturer ?? ""
        case .country:
            return car.country ?? ""
        }
    }
}
