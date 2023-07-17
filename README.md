# NennosPizza
[![CI](https://github.com/abin0992/NennosPizza/actions/workflows/ci.yml/badge.svg)](https://github.com/abin0992/NennosPizza/actions/workflows/ci.yml)

The main task is covered and bussiness logic is coved using unit tests
## MVVM-C architecture is used
- Combine framework is used for binding between view and viewmodel.
- Navigation is handled by using Coordinators
## Project developed with product-oriented approach 
This Project only has the UI and business logic for this project. The network API calls and models are managed in a different apple framework project - [PizzaEngine](https://github.com/abin0992/PizzaEngine/). This approach is the primary step in app modularisation which helps for the separation of responsibilities. The advantages of this approach are
- Its easy to make a separate iPad app /tvOS app / watchOS app / macOS app since this framework can be integrated and many functions and business logic becomes readily available to use.
- Ease to add new features and maintainability
- Serparation of responsibilities

### Continous Integration implemented using [Github Actions](https://github.com/abin0992/GHFollowers/actions)

### Installation
The project comes ready to test. 
Clone and run on your machine. No additional steps required.

  ```bash
  git clone [https://github.com/abin0992/GHFollowers.git](https://github.com/abin0992/NennosPizza.git)
  ```
  #### Dependencies 
  1. [Pizza Engine](https://github.com/abin0992/PizzaEngine/) - the core of app, (internal dependency)
  2. [KIngFisher](https://github.com/onevcat/Kingfisher) - remote image loading and cacheing - MIT License
  3. [SwiftEntryKit](https://github.com/huri000/SwiftEntryKit) - showing banners over navigation bar - MIT License

     Added using Swift Package Manager, so no additional steps required using running the project
  
### Todos

 - Write MORE Tests
  
### License

MIT

----

