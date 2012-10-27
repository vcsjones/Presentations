interface IHuman {
    ToString() : string;
}

class Person implements IHuman {
    firstName : string;
    lastName : string;
    constructor (firstName : string, lastName : string) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    ToString() : string {
        return this.firstName + " " + this.lastName;
    }
}

class Student extends Person {
    grade: number;
    constructor (firstName: string, lastName: string, grade: number) {
        this.grade = grade;
        super(firstName, lastName);
    }
}

class Greeter {
    Greet(person : Person) {
        alert("Hello, " + person.firstName);
    }
}

var kevin = new Student("Kevin", "Jones", 1);
var g = new Greeter();
g.Greet(kevin);