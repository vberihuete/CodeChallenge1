# Code Challenge 1
Based on a given Code Challenge, a clean MVC app holding a UITableView and scalable / testable code. This code also counts with the first version of the Filtered View which will be taken to a separete project and will soon be created as pod.

### Libraries
Using cocoapods with the following libraries:

 - 'Alamofire' v4.4'
 - 'SVProgressHUD' - latest
 - 'Kingfisher' v3.0'

### Design Patterns
The app architecture is made and using the following patterns:
 - SRP (Single Responsability Principle)
 - Adapter
 - Factory
 - Delegation
 - Singleton

### Unit Testing / UI Testing

This app is wired up for both testing types: Unit and UI. Right bellow is described which test are available and what they do.

- ##### Unit Testing
    - **testEventLoad**: This test runs the events load and see if a statusCode of 200 is given  
- ##### UI Testing
    -   **testFilterTabSuggested**: Goes to the suggested tab and checks if the down bar appears meaning it was selected.
    -   **testFilterTabViewed**: Goes to the viewed tab and checks if the down bar appears meaning it was selected
    -   **testFilterTabFavorites**: Goes to the favorites tab and checks if the down bar appears meaning it was selected
    -   **testFilterTabSuggested**: Goes to the suggested tab and checks if the down bar appears meaning it was selected
    -   **testTabInteraction**: Goes into some of the different view controllers through the tab bar ending in the home one

### How to run

In order to run the project make sure you have your cocoapods up to date. After that just run a `pod install` and then open the file `CodeChallengeTableView.xcworkspace`, finally run it in the device of your choice.

PD: You will need a developer account wired up in project setings.
