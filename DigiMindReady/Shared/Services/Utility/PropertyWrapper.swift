//
//  PropertyWrapper.swift
//
//  Created by Md. Mehedi Hasan on 10/9/20.
//

import UIKit

@discardableResult
func with<T: AnyObject>(_ obj: T, task: (T)->Void) -> T {
  task(obj)
  return obj
}

@discardableResult
func with<T: AnyObject>(maybe obj: T?, task: (T)->Void) -> T? {
  if let obj = obj { task(obj) }
  return obj
}

@discardableResult
func with<T: Any>(value: T, task: (inout T)->Void) -> T {
  var newValue = value
  task(&newValue)
  return newValue
}

func safe<T: Any>(_ touple: (T?, T)) -> T {
    return touple.0 ?? touple.1
}

func catchLayoutCompletion(layout: @escaping () -> Void, completion: @escaping (Bool) -> Void) {
    UIView.animate(withDuration: 0, animations: {
        layout()
    }) { (finish) in
        completion(finish)
    }
}

func performSystemAnimation(_ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
    UIView.perform(
        .delete,
        on: [],
        options: UIView.AnimationOptions(rawValue: 0),
        animations: animations,
        completion: completion
    )
}
