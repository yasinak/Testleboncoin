# Testleboncoin

This project has the ambition create a mini application that fetches the list of Ads display them in a list, in the assessment context ask by leboncoin company.


## Prerequisite

You need to install the last Xcode from Apple Store.


## How to install it

After download this project. You don't need to install something else.


## How to Use

To open the project, double click to Testleboncoin.xcodeproj file, Xcode will be launch. 

After you can run the project and test it on a simulator.


## Architecture

After thinking about the objective and expectations of the technical test, I decided to implement a Clean Architecture (VIP), because it allows good separation of the application and the components are testable.

In addition, a technical constraint was added, that of my hardware, my MacBook is old. I don't have an Xcode allowing me to develop an app with async/await, it is the reason why i use Combine.


## Design

Given the needs of the application, I chose to go with a TableView for Home and i I would have done a simple screen for the detail screen (if I had the time).


## Tests

I'm at 82.4% code coverage.

I set up unit tests for interactions, presenters and workers.

And I set up a UI Test for a very short flow of the application by going from Home to the menu.


## If I had more time

I would like to finish the details view screen.

Accessibility of data in offline mode.

I would like to manage dark mode.

I would have added some behaviors to the application to manage all error cases.

And I would also have set up a activity indicator to indicate to the user that the application is loading/fetching data.
