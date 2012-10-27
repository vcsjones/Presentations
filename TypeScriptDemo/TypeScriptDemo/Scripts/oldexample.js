var Greeter = function() {

};

Greeter.prototype.Greet = function Greet(name) {
    alert("Hello, " + name.firstName);
};

Greeter.prototype.Sendoff = function Sendoff(name) {
    alert("Goodbye, " + name.firstName);
};

var person = {
    firstName: "Kevin",
    lastName: "Jones"
};

var g = new Greeter();
g.Greet(person);