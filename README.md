# Clean Architecture + MVVM + Router

## Clean Architecture

Clean architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of clean architecture is that code dependencies can only come from the outer levels inward.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83876559-b8997900-a741-11ea-8c7b-5d559778b9f8.png" >
</div>

* Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models), Workers, and Store Interfaces. This layer could be potentially reused within different projects. Such separation allows for not using the host app within the test target because no dependencies (also 3rd party) are needed — this makes the Domain Workers tests take just a few seconds. Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)
* Presentation Layer contains UI. Views are coordinated by ViewModels (Presenters) which execute one or many Workers Presentation Layer depends only on the Domain Layer.
* Data Layer contains Store Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data to Domain Models.

## Dependency Direction
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

# Data Binding

Data Binding between View and ViewModel can be done for example with closures, delegates or observables (e.g. RxSwift). Combine and SwiftUI also can be used but only if our minimum supported iOS system is 13. The View has a direct relationship to ViewModel and notifies it whenever an event inside View happens. From ViewModel, there is no direct reference to View (only Data Binding)

In this project, we will use a simple combination of Closure and didSet to avoid third-party dependencies. It is **Observable** class. (Need to add link)

```
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
# MVVM + Coordinator

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/101611964-cdb5d400-3a12-11eb-8277-e453a28aec18.png" >
</div>

As we see we have to stay original dependencies in Model, View, and ViewModel. We improved MVVM and added some components like Worker, Store, Factory, Coordinator, Assembly. These components do not original of the MVVM approach but they do architecture more modular, logically and reusable.

**Responsibilities:**

* **Worker** - Combines data from User and Repositories. Note: on the internet, you can face with name "Interactor", in our case a Worker has the same responsibility as Interactor

* **Store** - Each Store returns data from a remote data (Network), persistent DB Storage Source or In-memory Data  (Remote or Cached). Note: on the internet, you can face with name "repository", in our case a Store has the same responsibility as Repository

* **Factory** - The Factory pattern is a way to encapsulate the implementation details of creating objects, which adheres to a common base class or interface. The Factory pattern allows the client that receives the created object to use the object return via the common interface without caring about the type of concrete object that is actually created.
This is a factory pattern which is used to create MVVM submodules. You need to pass Models Factory entities to create module with specific configurations. A factory generates full MVVM module and return ViewController.

* **Coordinator** - Creates independent and reusable module. Is used to navigate inside Coordinator module, passing data between modules and navigation between MVVM submodules.

* **Assembly** - Factory for Coordinators. This module generates a full coordinator instance so we don't need initialize appropriate coordinator one more time.

# Coordinator

# UNIT Testing

# Templates

* [Download archive by link](https://drive.google.com/file/d/18ZsVgFIXLXTjgRB8t_NoO08ipaTOKrmH)
* MVVM Core Templates.zip and unarchive it.
* We need to navigate to where Xcode stores its templates. 
  * In Finder, press **Cmd+Shift+G** to bring up the _“Go to the folder…”_ prompt.
  * Enter in this path:~/Library/Developer/Xcode/Templates/File Templates/
* Move the MVVM Core folder to File Templates directory.
* Reload Xcode.
