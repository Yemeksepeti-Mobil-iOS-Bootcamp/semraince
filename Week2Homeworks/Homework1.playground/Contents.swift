import UIKit

//MARK: - Extension Homework
/*
 Extension homework
 Extension for detect prime numbers
 */
print("Question1")
extension Int {
    func isPrime() -> Bool {
        if (self <= 1){
            return false;
        }
        
        let sqrt = Int(Double(self).squareRoot());
        if(sqrt <= 2){
            for i in 2...self {
                if(self % i == 0){
                    return false;
                }
            }
        }
        for i in 2...sqrt {
            if(self % i == 0){
                return false;
            }
        }
        return true;
    }
    func getInfoForPrime(_ isNumberPrime: Bool){
        if(isNumberPrime){
            print("\(self) is a prime number");
        }
        else{
            print("\(self) is not a prime number");
        }
        
    }
    
}
var primeNumberCandidate = 53;
primeNumberCandidate.getInfoForPrime(primeNumberCandidate.isPrime());
primeNumberCandidate = 105;
primeNumberCandidate.getInfoForPrime(primeNumberCandidate.isPrime());
print("\nQuestion2")
//MARK: - Generic Homework
/*
 Write a function that accepts 2 different generic parameters.
 */
protocol Fly {
    var speed: Double { get }
    func fly() -> Void;
}
protocol Walk{
    var stepNumber: Int { get }
    func walk() -> Void;
}

class Bird: Fly {
    let speed: Double
    init(speed: Double){
        self.speed = speed;
    }
    func fly(){
        print("I can fly with \(speed) m/s.")
    }
    
}
class Human: Walk {
    let stepNumber: Int
    init(stepNumber: Int){
        self.stepNumber = stepNumber;
    }
    func walk() {
        print("I aim for \(stepNumber) steps per minute");
    }
    
}

func fetch<T: Fly, U: Walk>(modelFlyable: T,  modelWalkable: U ) {
    modelWalkable.walk();
    modelFlyable.fly();
}

let bird: Bird = Bird(speed: 10.0)
let human: Human = Human(stepNumber: 100);
fetch(modelFlyable: bird, modelWalkable: human);
//MARK: -Euler Problem 6
print("\nQuestion 3")
func findSumSquareDifference(peak: Int) -> Int {
    let sumOfTotal = peak * (peak + 1)/2;
    let squaredOfSum = sumOfTotal * sumOfTotal;
    let sumOfSquared = (peak * (peak + 1) * (2 * peak + 1)) / 6;
    return squaredOfSum - sumOfSquared;
}
let sumOfSquareDifferenceForHundred = findSumSquareDifference(peak: 100);
print(sumOfSquareDifferenceForHundred); //25164150
//MARK: -Euler Problem 7

//MARK: - Static Field
/*
 Why static keyword is used in Swift ? Give an example
 */
/*
 if a field is declared static, then exactly a single copy of that field is created and shared among all instances of that class/struct. It doesn't matter how many times we initialize a class/struct; there will always be only one copy of static field belonging to it. The value of this static field will be shared across all objects.
 */
print("\nQuestion 4")
func getNtthPrimeNumber(n: Int) -> Int{
    var numberOfPrimeNNumbers = 2;
    var number = 3;
   
    while numberOfPrimeNNumbers != n {
       if(number.isPrime()){
            numberOfPrimeNNumbers += 1;
        }
        if(numberOfPrimeNNumbers == n){
            return number;
        }
        number += 2;
    }
    return -1;
}
let wantedPrimeNumber = getNtthPrimeNumber(n: 10_001);
print(wantedPrimeNumber);

//MARK: - If let vs guard let
/*
 if let and guard let serve similar, but distinct purposes.

 The "else" case of guard must exit the current scope. Generally that means it must call return or abort the program. guard is used to provide early return without requiring nesting of the rest of the function.

 if let nests its scope, and does not require anything special of it. It can return or not.

 In general, if the if-let block was going to be the rest of the function, or its else clause would have a return or abort in it, then you should be using guard instead. This often means (at least in my experience), when in doubt, guard is usually the better answer. But there are plenty of situations where if let still is appropriate.
 */

//MARK: - Static keyword
/*
 Sometimes we may need data or functions that operate on a class level.
 Example: Think of a counter that maintains number of objects of a class created.

 Such data can be shared across objects of a class, but still it is specific to the class itself.
 Using static keyword in Swift we can declare class specific artifacts.

 We have two uses of static keyword in Swift.
 A Class can have Properties that are common to all instances of the class. Such properties are called static properties, and are declared with the static keyword. Let us see an example below
 */
print("\Question 5")
class User
{
    static var userCount = 0;
}
/*
 As you can see in the above example, we created a class called User and created a static variable called userCount.
 This variable can now be shared among all objects as follows.
 */
User.userCount += 1
var user1: User = User()
User.userCount += 1
var user2: User = User()
print(User.userCount)
/*
 A Class can have method that are common to all instances of the class. Such methods are called static method, and are declared with the static keyword. Let us see an example below
 */
class UserUpdated
{
    static var userCount: Int = 0

    static func incrementUserCount()
    {
        UserUpdated.userCount += 1
    }

    static func getUserCount() -> Int
    {
        return userCount
    }
}
UserUpdated.incrementUserCount()
UserUpdated.incrementUserCount()
print(UserUpdated.getUserCount())





