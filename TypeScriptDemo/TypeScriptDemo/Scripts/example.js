var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
}
var Person = (function () {
    function Person(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    Person.prototype.ToString = function () {
        return this.firstName + " " + this.lastName;
    };
    return Person;
})();
var Student = (function (_super) {
    __extends(Student, _super);
    function Student(firstName, lastName, grade) {
        this.grade = grade;
        _super.call(this, firstName, lastName);
    }
    return Student;
})(Person);
var Greeter = (function () {
    function Greeter() { }
    Greeter.prototype.Greet = function (person) {
        alert("Hello, " + person.firstName);
    };
    return Greeter;
})();
var kevin = new Student("Kevin", "Jones", 1);
var g = new Greeter();
g.Greet(kevin);
