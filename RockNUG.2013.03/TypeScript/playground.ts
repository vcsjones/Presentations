module Fortigent {
    export class Person {
        private firstName: string;
        private lastName: string;
        private siblings: Person[];
        constructor(firstName: string, lastName: string) {
            this.siblings = [];
            this.firstName = firstName;
            this.lastName = lastName;
        }

        getGreeter(): () => void {
            return () => {
				WScript.Echo(this.firstName);
			};
        }

        addSibling(sibling: Person): void {
            this.siblings.push(sibling);
        }
    }
	export class Employee extends Person {
		employeeId : number;
		constructor(firstName : string, lastName : string, employeeId : number) {
			super(firstName, lastName);
			this.employeeId = employeeId;
		}
	}
}

var kevin = new Fortigent.Employee("Kevin", "Jones", -1);
var greeter = kevin.getGreeter();
greeter();