//
//  HealthService.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 19.04.2021.
//

import Foundation
import HealthKit
import Combine

class HealthService: ObservableObject {
    let store = HKHealthStore()

    static let supportTypes: [HKQuantityTypeIdentifier] = [.height, .heartRate]

    var profile = ProfileViewModel(name: "Leo",
                                   email: "test@test.ru")

    let firestoreService = FirestoreService()

    @Published
    var samples: [String: [QuantityViewModel]] = [:] {
        didSet {
            profile.measures = samples
            firestoreService.saveToStore(for: profile)
        }
    }

    init() {
        
    }

    func authorize() {
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
                let height = HKObjectType.quantityType(forIdentifier: .height),
                let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
                let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {

                //completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }

        store.requestAuthorization(toShare: nil, read: [dateOfBirth, bloodType, biologicalSex, bodyMassIndex,
                                                        height, bodyMass, activeEnergy, sleepAnalysis]) { success, error in
            print(success, error)
        }
    }


    func collectData(completion: @escaping ([HKQuantitySample]) -> ()) {
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        let sampleQuery = HKSampleQuery(sampleType: HKSampleType.quantityType(forIdentifier: .height)!,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard let samples = samples else {
                    //completion(nil, error)
                    return
              }
                self.samples["height"] = samples.compactMap { $0 as? HKQuantitySample }.map {
                    return QuantityViewModel(name: $0.quantityType.identifier, value: $0.quantity.doubleValue(for: HKUnit.meter()), date: $0.endDate)
                }
                //completion()
            }
          }
        store.execute(sampleQuery)
    }
}
