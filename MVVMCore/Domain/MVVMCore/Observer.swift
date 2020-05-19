//
//  Observer.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

public final class Observable<Value> {
  
  struct Observer<Value> {
    weak var observer: AnyObject?
    let block: (Value) -> Void
  }
  
  private var observers = [Observer<Value>]()
  
  public var value: Value {
    didSet { notifyObservers(value) }
  }
  
  public init(_ value: Value) {
    self.value = value
  }
  
  /// Subscribing an observer on value
  /// - Parameters:
  ///   - observer: an observer
  ///   - observerBlock: observerBlock
  public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
    observers.append(Observer(observer: observer, block: observerBlock))
  }
  
  
  /// Subscribing an observer on value. Replay the starting value when the first subscription added.
  /// - Parameters:
  ///   - observer: an observer
  ///   - observerBlock: observerBlock
  public func observeWithStartingValue(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
    observers.append(Observer(observer: observer, block: observerBlock))
    DispatchQueue.main.async { observerBlock(self.value) }
  }
  
  public func remove(observer: AnyObject) {
    observers = observers.filter { $0.observer !== observer }
  }
  
  private func notifyObservers(_ value: Value) {
    for observer in observers {
      DispatchQueue.main.async {
        observer.block(value)
      }
    }
  }
}
