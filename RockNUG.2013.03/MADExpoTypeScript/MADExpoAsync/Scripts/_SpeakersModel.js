function SpeakersModel(items) {
    this.speakers = items;
}

SpeakersModel.prototype.sort = function (sortBy) {
    return function (left, right) {
        return left[sortBy] < right[sortBy] ? -1 : left[sortBy] > right[sortBy] ? 1 : 0;
    };
};

SpeakersModel.prototype.sortFirstName = function () {
    this.speakers.sort(this.sort('FirstName'));
};

SpeakersModel.prototype.sortLastName = function () {
    this.speakers.sort(this.sort('LastName'));
};