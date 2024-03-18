//
//  HealthManager.swift
//  HealthKitLearner
//
//  Created by Angela on 3/12/24.
//

import Foundation
import HealthKit
import FamilyControls


extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfYesterday: Date? {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return nil
        }
        return Calendar.current.startOfDay(for: yesterday)
    }

    static var endOfYesterday: Date? {
        guard let startOfYesterday = startOfYesterday else {
            return nil
        }
        return Calendar.current.date(byAdding: .second, value: -1, to: Calendar.current.date(byAdding: .day, value: 1, to: startOfYesterday)!)
    }
    
    // Starts on Monday
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2 // Monday
        
        return calendar.date(from: components)!
    }
}


class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [String: Activity] = [:] // start with empty dictionary, each on we will display in our HomeView
    
    init(){
        let steps = HKQuantityType(.stepCount)
        let sleep = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        //let sleepSampleType = HKCategoryType(.sleepAnalysis)
        let healthTypes: Set = [steps, sleep]
        
        Task {
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                // This code is what enables each activity card to be made in HOME
            
                fetchTodaySteps()
                fetchSleepAnalysis()

                
                
                //fetchExercise()
                //fetchExercise()
            } catch {
                print("Error fetching health data")
            }
            
        }
    }
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays step data")
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Today steps", subtitle: "Goal 10,000", image: "figure.walk", amount: stepCount.formattedString())
            
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchSleepAnalysis() {
        let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        let predicate = HKQuery.predicateForSamples(withStart: .startOfYesterday, end: .endOfYesterday)
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                print("Error fetching sleep data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Filter samples to find in-bed samples
            let inBedSamples = samples.filter { $0.value == HKCategoryValueSleepAnalysis.inBed.rawValue}
            // Assuming you already have the definition of inBedSamples as you provided earlier


            /*
            // Iterate over each sample in inBedSamples (DEBUGGING)
            for sample in inBedSamples {
                // Print out relevant information about the sample
                print("Sample Start Date: \(sample.startDate)")
                print("Sample End Date: \(sample.endDate)")
                // If sample is HKCategorySample, print out its value
                if let categorySample = sample as? HKCategorySample {
                    print("Category Value: \(categorySample.value)")
                }
                // Add more information as needed
                print("---")
            }
             */


            
            // Calculate total time in bed
            var totalTimeInBed: TimeInterval = 0
            for sample in inBedSamples {
                totalTimeInBed += sample.endDate.timeIntervalSince(sample.startDate)
            }
            
            // totalTimeInBed now contains the total time the user spent in bed
            print("Total time in bed: \(totalTimeInBed) seconds")
            let totalTimeInBedInHours = totalTimeInBed / 3600

            print("Total time in bed: \(totalTimeInBedInHours) hours")
        }

        // Execute the query
        healthStore.execute(query)

        }
    

    

    /*
    
    func fetchCurrentWeekStrengthTrainingStats() {
        let workout = HKSampleType.workoutType()

        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .traditionalStrengthTraining)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: 20, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }

            var count: Int = 0
            for workout in workouts {
                let duration = Int(workout.duration)/60
                count += duration
            }
            let activity = Activity(id: 2, title: "Strength Training", subtitle: "This week", image: "dumbbell", amount: "\(count) minutes")

            DispatchQueue.main.async {
                self.activities["weekRunning"] = activity

            }
        }
        healthStore.execute(query)
    }
     */

    
   
}

func convertToHours(timeInterval: TimeInterval, unit: Calendar.Component) -> Double {
    let secondsInHour: TimeInterval = 3600 // Number of seconds in an hour
    
    // Convert the time interval to seconds based on the provided unit
    let seconds: TimeInterval
    switch unit {
    case .second:
        seconds = timeInterval
    case .minute:
        seconds = timeInterval * 60
    case .hour:
        seconds = timeInterval * secondsInHour
    case .day:
        seconds = timeInterval * secondsInHour * 24
    case .month:
        // Assuming a month has 30 days for simplicity
        seconds = timeInterval * secondsInHour * 24 * 30
    case .year:
        // Assuming a year has 365 days for simplicity
        seconds = timeInterval * secondsInHour * 24 * 365
    default:
        fatalError("Unsupported unit")
    }
    
    // Convert seconds to hours
    let hours = seconds / secondsInHour
    return hours
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

extension TimeInterval {
    func formattedSleepDuration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.maximumUnitCount = 2
        return formatter.string(from: self) ?? ""
    }
}
