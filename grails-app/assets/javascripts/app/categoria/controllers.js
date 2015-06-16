'use strict';

function ListCtrl($scope, CategoriaResource, categoriaList, pageSize) {
    var self = this;
    self.categoriaList = categoriaList;
	
    self.pageSize = pageSize;
    self.page = 1;
    self.filter = {};

    $scope.$watchCollection(function() { return self.filter }, function() {
        self.reload();
    });

    self.load = function() {
        var params = {page: self.page};

        if (self.sort) {
            angular.extend(params, self.sort);
        }
		if (self.filter) {
			params.filter = self.filter
		}

        CategoriaResource.list(params).then(function(items) {
            self.categoriaList = items;
        });
    };

    self.reload = function() {
        self.page = 1;
        self.load();
    }
}

function ShowCtrl(categoria) {
    var self = this;
    self.categoria = categoria;
};

function CreateEditCtrl(categoria ) {
    var self = this;
	
    self.categoria = categoria;
}

angular.module('app.categoria.controllers', [])
    .controller('ListCtrl', ListCtrl)
    .controller('ShowCtrl', ShowCtrl)
    .controller('CreateEditCtrl', CreateEditCtrl);