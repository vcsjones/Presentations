ko.bindingHandlers.MADText = {
    update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var container = $(element);
        var value = valueAccessor();
        var name = ko.utils.unwrapObservable(value);
        var letterContainer = $('<span class="hiText">');
        letterContainer.text(name.charAt(0));
        container.append(letterContainer);
        container.append(document.createTextNode(name.substring(1)));
    }
};

ko.bindingHandlers.oddItemClass = {
    update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var value = valueAccessor();
        var data = ko.utils.unwrapObservable(value);
        var cls = data['class'];
        var index = data.index;
        if (index % 2 === 0) {
            $(element).addClass(cls);
        }
    }
};

ko.bindingHandlers.twitter = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var value = valueAccessor();
        var twitterTag = ko.utils.unwrapObservable(value);
        if (!twitterTag) {
            return;
        }
        var frame = $('<iframe allowtransparency="true" frameborder="0" scrolling="no" src="//platform.twitter.com/widgets/follow_button.html?show_count=false&screen_name=' + twitterTag + '" style="width:300px; height:20px;"></iframe>');
        $(element).append(frame);
    }
};