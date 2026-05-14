//
//  BiometricAuthManager.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import LocalAuthentication

final class BiometricAuthManager {
    
    static let shared = BiometricAuthManager()
    private init() {}
    
    func authenticate(
        completion: @escaping (Bool) -> Void
    ) {
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context
            .canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            )
        if canEvaluate {
            let reason = "Access your favorite characters"
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { success, _ in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
