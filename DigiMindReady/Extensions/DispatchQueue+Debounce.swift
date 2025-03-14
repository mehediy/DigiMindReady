//
//  DispatchQueue+Debounce.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 1/11/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import Foundation

//Simple CGD Based Debouncing / Deduping

extension DispatchQueue {

    /**
     - parameters:
        - target: Object used as the sentinel for de-duplication.
        - delay: The time window for de-duplication to occur
        - work: The work item to be invoked on the queue.
     Performs work only once for the given target, given the time window. The last added work closure
     is the work that will finally execute.
     Note: This is currently only safe to call from the main thread.
     Example usage:
     ```
     DispatchQueue.main.asyncDebounced(target: self, after: 1.0) { [weak self] in
         self?.doTheWork()
     }
     ```
     */
    func asyncDebounced(target: AnyObject, after delay: TimeInterval, execute work: @escaping @convention(block) () -> Void) {
        let debounceIdentifier = DispatchQueue.debounceIdentifierFor(target)
        if let existingWorkItem = DispatchQueue.workItems.removeValue(forKey: debounceIdentifier) {
            existingWorkItem.cancel()
            print("Debounced work item: \(debounceIdentifier)")
        }
        let workItem = DispatchWorkItem {
            DispatchQueue.workItems.removeValue(forKey: debounceIdentifier)

            for ptr in DispatchQueue.weakTargets.allObjects {
                if debounceIdentifier == DispatchQueue.debounceIdentifierFor(ptr as AnyObject) {
                    work()
                    NSLog("Ran work item: \(debounceIdentifier)")
                    break
                }
            }
        }

        DispatchQueue.workItems[debounceIdentifier] = workItem
        DispatchQueue.weakTargets.addPointer(Unmanaged.passUnretained(target).toOpaque())

        asyncAfter(deadline: .now() + delay, execute: workItem)
    }
    
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

// MARK: - Static Properties for De-Duping
private extension DispatchQueue {

    static var workItems = [AnyHashable : DispatchWorkItem]()

    static var weakTargets = NSPointerArray.weakObjects()

    static func debounceIdentifierFor(_ object: AnyObject) -> String {
        return "\(Unmanaged.passUnretained(object).toOpaque())." + String(describing: object)
    }

}
