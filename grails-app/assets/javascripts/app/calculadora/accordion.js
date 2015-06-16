angular.module('accordion', ['ui.bootstrap']).controller('accordionCtrl', function ($scope) {
    $scope.oneAtATime = true;

    $scope.groups = [
        {
            title: 'Dynamic Group Header - 1',
            content: 'Dynamic Group Body - 1'
        },
        {
            title: 'Dynamic Group Header - 2',
            content: 'Dynamic Group Body - 2'
        }
    ];

    $scope.items = ['Item 1', 'Item 2', 'Item 3'];

    $scope.addItem = function() {
        var newItemNo = $scope.items.length + 1;
        $scope.items.push('Item ' + newItemNo);
    };

    $scope.status = {
        isFirstOpen: true,
        isFirstDisabled: false
    };

    $scope.updateItems = function(category, item) {
        console.log(item);
        if(!category.selected)
            category.selected = [];
        if(item.selected)
            category.selected.push(item);
        else {
            var indx = category.selected.indexOf(item);
            category.selected.splice(indx, 1);
        }
    };
});
