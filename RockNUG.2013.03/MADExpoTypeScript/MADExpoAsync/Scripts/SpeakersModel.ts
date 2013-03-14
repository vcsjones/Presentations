/// <reference path="knockout.d.ts" />

class SpeakersModel {
    speakers: KnockoutObservableArray;

    constructor(speakers: KnockoutObservableArray) {
        this.speakers = speakers;
    }

    sort(sortBy: string): (left: string, right: string) => number {
        return (left, right) => {
            return left[sortBy] < right[sortBy] ? -1 : left[sortBy] > right[sortBy] ? 1 : 0;
        };
    }

    sortFirstName(): void {
        this.speakers.sort(this.sort('FirstName'));
    }

    sortLastName(): void {
        this.speakers.sort(this.sort('LastName'));
    }
}