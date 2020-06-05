# Clean Architecture + MVVM + Router

##Clean Architecture

Clean architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of clean architecture is that code dependencies can only come from the outer levels inward.

* Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models), Workers, and Store Interfaces. This layer could be potentially reused within different projects. Such separation allows for not using the host app within the test target because no dependencies (also 3rd party) are needed — this makes the Domain Workers tests take just a few seconds. Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)
* Presentation Layer contains UI. Views are coordinated by ViewModels (Presenters) which execute one or many Workers Presentation Layer depends only on the Domain Layer.
* Data Layer contains Store Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data to Domain Models.

##Dependency Direction
* Presentation Layer (MVVM) = ViewModels (Presenters) + Views(UI)
* Domain Layer = Entities + Workers + Store Interfaces
* Data Store Layer = Store Implementations + API(Network) + Persistence DB

# MVVM

The Model-View-ViewModel (MVVM) pattern is a UI design pattern. It provides a clean separation of concerns between the UI and Domain.

Responsibilities:

* ViewModel - The primary responsibility of the ViewModel is to provide data to the view, so that view can put that data on the screen. The ViewModel should not contain any UI components or parts. The best way to achieve this it avoids importing UIKit or any UI frameworks.
* View - The main purpose and responsibilities of views is to define the structure of what the user sees on the screen. The View should not contain any business logic just UI.
* Model - It is the client side data model that supports the views in the application.

The relationships between the three components of the MVVM pattern, just following these strict rules:
* The View has a reference to the ViewModel through the protocol, but not vice-versa.
* The ViewModel has a reference to the Model, but not vice-versa.
* The View has no reference to the Model or vice-versa. 
