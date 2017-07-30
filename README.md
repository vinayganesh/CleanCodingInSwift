# Clean Coding in Swift

Clean coding in any programming language is not just about naming the classes, variables, constants and functions right. Only 10 percent of clean coding involves working on naming conventions in the right way. Clean coding is mostly about how well you can picture what goes into the class that you are creating in terms of composition. This brings another topic of why we are talking only about composition and not inheritance. I will keep that in another article as there is a lot to talk about it and it deserves an article by itself. For this article, just consider composition is mostly always the right answer during clean coding.

So what is clean coding?

Lets work with an example. Please download the playgrounds page before reading further as i will be talking only about the contents of the playgrounds page in reference to clean coding. This is going to be a lengthy article so brace yourself. The main idea of this application is to get the total number of steps and an array of dates that the user was active. The playgrounds consists of 3 files.

1. ActivityModel.swift which consists of a struct that models the data that is obtained from the CMPedometer class. We will be getting the data from CMPedometer class and create a model call Activity and find the total steps and the number of active days.
2. DataProvider.swift which consists of a class that fetches data from CMPedometer of CoreMotion. DataProvider will be used in StepCountManager to get the data.
3. StepCountManager.swift which consists of a class that fetches the data from DataProvider and splits that into steps and dates. Picture this as a class that will interact with your view.

Why is the DataProvider class a separate class? because DataProvider only provides data and doesn’t have to know about what StepCountManager does with the data from it and neither should StepCountManager know about how the DataProvider gets across the data. Hence the DataProvider implements a protocol that consists of one function fetchData with a completion handler. This protocol serves as an interface for the DataProvider.

The StepCountManager will create a private property of the DataProvidingProtocol and through its initializer it will inject the DataProvider. This process is called Dependency injection. The StepCountManager is composed of a DataProvider and also, StepCountManager has a dependency on DataProvider. Why do we do this? Because this helps during unit testing. How? Since we are injecting a type of protocol and not the object of a class into StepCountManager, we can create a MockDataProvider, whose fetchData function will return data that is a dummy data that we an create and unit test StepCountManager for edge cases, valid/invalid scenarios.

StepCountManager calls DataProvider’s fetchData and in the completionHandler creates an Activity Model and sets the activity which intern splits the dates and steps and creates an API with perfectly encapsulated class where we will be able to set the steps or the dates only through setActivity function.

Why are there addSteps and addDate functions when setActivity is just internally calling these functions? the reason is because what if you want to get the information from HealthKit in the future, you would want a handle just in case. When you are creating a class, always think about what can go wrong in the future?, what can you add to the class? what can you remove from the class and of course what happens when you do any of these.

Lets talk a bit about unit testing. In the playgrounds page you can see an Test class for StepCountManager that consists of 2 mock classes for DataProvider. Before we start mocking the DataProvider, you have to mock the CMPedometerData class and it is done with the MockPedoMeterData class where we are extending the CMPedometerData class and overriding the numberOfSteps and startDate variables to return some hardcoded data that we can use to test StepCountManager.

The MockDataProvider class will just provide numberOfSteps as 10 and startDate as current date. The MockDataProviderWithError class will provide the same number of steps as MockDataProvider but it also simulates an error that we can unit test against to check if we really got the steps data or some error and how well we handle the error conditions in StepCountManager.

To write clean code, all that is needed is to picture how to split the code into multiple dependencies and inject these dependencies into a class that is composed of all the dependencies to put together into something where you might present a view or inject that composed class into another class. The visualization in your mind should be about object graphs. If this can be achieved, your solution is going to be great and definitely scalable.
