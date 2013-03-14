var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var Fortigent;
(function (Fortigent) {
    var Person = (function () {
        function Person(firstName, lastName) {
            this.siblings = [];
            this.firstName = firstName;
            this.lastName = lastName;
        }
        Person.prototype.getGreeter = function () {
            var _this = this;
            return function (bar) {
                WScript.Echo(_this.firstName);
            };
        };
        Person.prototype.addSibling = function (sibling) {
            this.siblings.push(sibling);
        };
        return Person;
    })();
    Fortigent.Person = Person;    
    var Employee = (function (_super) {
        __extends(Employee, _super);
        function Employee(firstName, lastName, employeeId) {
                _super.call(this, firstName, lastName);
            this.employeeId = employeeId;
        }
        return Employee;
    })(Person);
    Fortigent.Employee = Employee;    
})(Fortigent || (Fortigent = {}));
var kevin = new Fortigent.Employee("Kevin", "Jones", -1);
var greeter = kevin.getGreeter();
greeter("cat");
