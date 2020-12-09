# Clean Architecture + MVVM + Coordinator

## Table of content

* [Clean Architecture](#clean-architecture)
* [MVVM](#mvvm)
  * [Data Binding](#data-binding)
* [Coordinator](#coordinator)
  * [Summary](#summary)
  * [Coordinator structure](#coordinator-structure)
* [MVVM + Coordinator](#mvvm--coordinator)
* [Module presentation style](#module-presentation-style)
* [Module live cycle](#module-live-cycle)
* [Module data passing](#module-data-passing)
* [UNIT Testing](#unit-testing) (:warning: in progress)
* [Templates](#templates)


## Clean Architecture

Clean architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of clean architecture is that code dependencies can only come from the outer levels inward.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83876559-b8997900-a741-11ea-8c7b-5d559778b9f8.png" >
</div>

* **Domain Layer** (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models), Workers, and Store Interfaces. This layer could be potentially reused within different projects. Such separation allows for not using the host app within the test target because no dependencies (also 3rd party) are needed — this makes the Domain Workers tests take just a few seconds. Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)
* **Presentation Layer** contains UI. Views are coordinated by ViewModels (Presenters) which execute one or many Workers Presentation Layer depends only on the Domain Layer.
* **Data Layer** contains Store Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data to Domain Models.

***Dependency Direction**
* Presentation Layer (MVVM) = ViewModels + Views(UI)
* Domain Layer = Entities + Workers + Store Interfaces
* Data Store Layer = Store Implementations + API(Network) + Persistence DB

# MVVM

The Model-View-ViewModel (MVVM) pattern is a UI design pattern. It provides a clean separation of concerns between the UI and Domain.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83877081-948a6780-a742-11ea-86e5-a3bd5ef7ab63.png" >
</div>

**Responsibilities:**

* **ViewModel** - The primary responsibility of the ViewModel is to provide data to the view, so that view can put that data on the screen. The ViewModel should not contain any UI components or parts. The best way to achieve this it avoids importing UIKit or any UI frameworks.
* **View** - The main purpose and responsibilities of views is to define the structure of what the user sees on the screen. The View should not contain any business logic just UI.
* **Model** - It is the client side data model that supports the views in the application.

The relationships between the three components of the MVVM pattern, just following these strict rules:
* The View has a reference to the ViewModel through the protocol, but not vice-versa.
* The ViewModel has a reference to the Model, but not vice-versa.
* The View has no reference to the Model or vice-versa. 

## Data Binding

Data Binding between View and ViewModel can be done for example with closures, delegates or observables (e.g. RxSwift). Combine and SwiftUI also can be used but only if our minimum supported iOS system is 13. The View has a direct relationship to ViewModel and notifies it whenever an event inside View happens. From ViewModel, there is no direct reference to View (only Data Binding)

In this project, we will use a simple combination of Closure and didSet to avoid third-party dependencies. It is **Observable** class. (Need to add link)

```swift
// SomeViewModel.swift

var isLoading: Observable<Bool> = Observable(false)

... 
// notify ViewController that loading begins
isLoading.value = true
...

//  SomeViewController.swift

if bind(_ viewModel: ViewModelProtocol) {
  viewModel.isLoading.observe(on: self) { [weak self] in 
    self?.setRefreshControl(isLoading: $0) 
  }
}
```

# Coordinator

## Summary

If we are going to stick to one architecture, we must define several rules.

| :loudspeaker: Rule #1 Create a Coordinator only if the module has child navigation. |
| - |

When we are talking about navigation we assume navigation is a push, pop, present, dismiss. All actions which look like navigation to somewhere. Do not need to create a coordinator if the module does not have nested navigation.

| :loudspeaker: Rule #2 Each coordinator must have a navigation controller. |
| - |

The second rules are based on the first as each coordinator contains nested navigation it means that must have a navigation controller. Each coordinator has to be created with a parent navigation controller, and internally he can decide whether he wants to use the parent as his main navigation controller or wants to create a new one. (this will be implementation-dependent)

## Coordinator structure

All coordinators will be linked. Each coordinators knows about a parent coordinator and children coordinators. Beside main coordinator, as it has been created as first. In result this structure makes linked list. More detail has described below:

```swift
protocol Coordinator: class {
  
  var id: UUID { get }
  
  /// Reference on the parent coordinator
  var parentCoordinator: Coordinator? { get set }
  
  /// References on the child coordinators
  var childCoordinators: [UUID: WeakCoordinator] { get }
  
  /// `navigationController` in which all navigation for the current coordination takes place
  var navigationController: UINavigationController { get }
  
  /// This method in which describe an implementation of how to present screen
  /// - Parameters:
  ///   - style: determinate how would be presented coordinator
  ///   - animated: animated
  func start(style: CoordinatorPresentationStyle, animated: Bool)
  
  /// Present child coordinator
  /// - Parameters:
  ///   - coordinator: child coordinator
  ///   - style: determinate how would be presented coordinator
  ///   - animated: animated
  func start(coordinator: Coordinator, style: CoordinatorPresentationStyle, animated: Bool)
  
  /// Pop coordinator from stack. Removing the dependency for a parent and child coordinators
  func stop()
  
  /// Remove child coordinator by id
  func removeChild(by id: UUID)
  
}
```

# MVVM + Coordinator

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617320-2a1bf200-3a19-11eb-818e-ab2b9e70e988.png">
</div>

As we see we have to stay original dependencies in Model, View, and ViewModel. We improved MVVM and added some components like Worker, Store, Factory, Coordinator, Assembly. These components do not original of the MVVM approach but they do architecture more modular, logically and reusable.

**Responsibilities:**

* **Worker** - Combines data from User and Repositories. Note: on the internet, you can face with name "Interactor", in our case a Worker has the same responsibility as Interactor

* **Store** - Each Store returns data from a remote data (Network), persistent DB Storage Source or In-memory Data  (Remote or Cached). Note: on the internet, you can face with name "repository", in our case a Store has the same responsibility as Repository

* **Factory** - The Factory pattern is a way to encapsulate the implementation details of creating objects, which adheres to a common base class or interface. The Factory pattern allows the client that receives the created object to use the object return via the common interface without caring about the type of concrete object that is actually created.
This is a factory pattern which is used to create MVVM submodules. You need to pass Models Factory entities to create module with specific configurations. A factory generates full MVVM module and return ViewController.

* **Coordinator** - Creates independent and reusable module. Is used to navigate inside Coordinator module, passing data between modules and navigation between MVVM submodules.

* **Assembly** - Factory for Coordinators. This module generates a full coordinator instance so we don't need initialize appropriate coordinator one more time.

# Module presentation style

Every first ViewController in a coordinator must be added to NavigationController and it can happen in a few ways. This options determined in enum **CoordinatorPresentationStyle**. Also, some of them can implement in the base implementation.

**Note:** *This presentation relates only to a coordinator and does not relate to MVVM modules (without a coordinator). It describes how to be presented  base view controller of coordinator on a navigation controller.*

```swift
enum CoordinatorPresentationStyle {
  
   /// `custom` case using for custom presentation coordinator, in this case needs to override `start` method and describe needed presentation
  case custom
  
  /// `setRoot` case added a ViewController in the root of the navigation stack
  case setRoot
  
  /// `push` case added a ViewController in the end of the navigation stack
  case push
  
  /// `presentSecondarySteck` case presents a ViewController in the new navigation, create new NavigationController with ViewController and present NavigationController
  case presentSecondarySteck
  
}
```

***Example how to use:***

* Presentation a main coordinator
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617135-ede89180-3a18-11eb-8e6e-c1b111e4ed4a.png">
</div>

```swift
let coordinator = baseAssembly.makeMainCoordinator(with: navigation)
mainCoordinator = coordinator
mainCoordinator?.start(style: .setRoot, animated: false)
```

* Parent coordinator pushes a child coordinator
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617134-ed4ffb00-3a18-11eb-9e44-fc338279ee8f.png">
</div>

```swift
let coordinator = assembly.makeMoviesCoordinator(with: navigationController)
start(coordinator: coordinator, style: .push)
```

* Parent coordinator presents a child coordinator in secondary stack
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617131-ec1ece00-3a18-11eb-9b72-52f9121bc2d5.png">
</div>

```swift
let coordinator = assembly.makeCounterCoordinator(with: navigationController, isDismissButtonHidden: true)
start(coordinator: coordinator, style: .presentSecondarySteck)
```

* Parent coordinator needs to push a ViewController
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617125-eb863780-3a18-11eb-9e95-16bdf0bfc769.png">
</div>

```swift
let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true, didChangeCount: didChangeCount)
navigationController?.pushViewController(viewController, animated: true)
```

* Parent coordinator needs to present a ViewController
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101617122-ea550a80-3a18-11eb-91b8-e5ee3933e8da.png">
</div>

```swift
let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false, didChangeCount: didChangeCount)
navigationController?.present(viewController, animated: true)
```

# Module live cycle

In the implementation, we keep the child coordinators weak. When the ViewController disappears, it trigged a chain of destroys and all dependencies between objects break in this order:
1. VIewController -> ViewModel
2. ViewModel -> Coordinator (after this step stays one weak reference on a coordinator from child array.)
3. Coordinator (patent) -> Coordinator (when the coordinator deinitializes, it removes references on itself from the parent and recursive called *stop()* for the children)
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101641944-0ff30b80-3a3b-11eb-916f-9387dc07ac37.png">
</div>

# Module data passing

If a module needs concrete data on which it is based. The initialization of the module must be happening with an obviously determinate type of data. Data passing:
* to destination module - in function parameters
* from destination module - notify using closure & delegate 
<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101642694-f3a39e80-3a3b-11eb-8aaf-e78fa2a3af9d.png">
</div>

# UNIT Testing

// in progress

# Templates

* [Download archive by link](https://drive.google.com/file/d/18ZsVgFIXLXTjgRB8t_NoO08ipaTOKrmH)
* MVVM Core Templates.zip and unarchive it.
* We need to navigate to where Xcode stores its templates. 
  * In Finder, press **Cmd+Shift+G** to bring up the _“Go to the folder…”_ prompt.
  * Enter in this path:~/Library/Developer/Xcode/Templates/File Templates/
* Move the MVVM Core folder to File Templates directory.
* Reload Xcode.
