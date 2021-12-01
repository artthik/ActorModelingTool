# ActorModelingTool

## Quick start

### Step 1

Download and open the latest image of the Glamorous toolkit from [their official homepage](https://gtoolkit.com/).
Open a **Playground** and execute the following script.

``` 
Metacello new
		baseline: 'AMT';
		repository: 'https://github.com/artthik/ActorModelingTool';
		load
```

### Step 2

To start with a blank canvas with an initial domain entity execute following command:
```
AMTController new
```
To start with a simple Hello World example execute following command:
```
AMTHelloWorldExample new 
```
To inspect the AMT use case execute following command:
```
AMTExampleATMWithdrawal new completeScenario
```
To inspect the Vostra example execute following command:
```
AMTVostraExample new completeScenario
```

## Simplified steps to model the ATM domain in our tool

### Create domain objects visually

Our example with the ATM needs multiple domain objects, which need to be created first.
The *ATM* object needs to communicate with a *bank* object to retrieve the *account* information.
Account information in our case would be the balance and the user credentials which will be validated by the ATM.
All of these domain objects (i.e. ATM, bank, and account) can be created visually by any stakeholder.
These empty domain objects can then be positioned in the tool as needed.

### Implement the object behavior in views

Once the domain objects are created, the technical stakeholders can use the default views (i.e. Main and All methods), change or create new views needed for all the stakeholders.
For the developers needs they can use the *All methods* default view.
In this view, software developers can implement domain object behavior and logic as needed.
The implementation needs to be abstracted to fit the actor model with message propagation.
By sending, receiving, and processing messages all behavior can be depicted.
In this step, the software developer can also implement unit tests and use case *example methods* for further prototype execution and testing.

### Execution and test the prototype

With objects created and behavior implemented, simple use cases can now be tested and visualized in the tool.
Any stakeholder can step through each process step of each domain object and audit the created domain model.
Further changes can then be iteratively and incrementally applied by all stakeholders.
