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

    $scope.updateItems = function(parent, item) {
        console.log(item);
        if(!parent.selected)
            parent.selected = [];
        if(item.selected)
            parent.selected.push(item);
        else {
            var indx = parent.selected.indexOf(item);
            parent.selected.splice(indx, 1);
        }
    };

    //$scope.showOptions = function(item) {
    //    console.log("componente: "+item);
    //    console.log('scope: '+$scope.paquete);
    //    $scope.shwOpts = true;
    //    //$scope.options = item.propiedades;
    //    $scope.options = $scope.paquete.propiedades;
    //};
});
