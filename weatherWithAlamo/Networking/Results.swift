//
//  Results.swift
//  weatherWithAlamo
//
//  Created by Angus Muller on 02/03/2018.
//  Copyright © 2018 Angus Muller. All rights reserved.
//

/// Results come through this enum allowing easy switch statement on success or failure.
enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
