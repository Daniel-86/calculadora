'use strict';

function ListCtrl($scope, ConceptoResource, conceptoList, pageSize) {
    var self = this;
    self.conceptoList = conceptoList;
	
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

        ConceptoResource.list(params).then(function(items) {
            self.conceptoList = items;
        });
    };

    self.reload = function() {
        self.page = 1;
        self.load();
    }
}

function ShowCtrl(concepto) {
    var self = this;
    self.concepto = concepto;
};

function CreateEditCtrl(concepto ) {
    var self = this;
	
    self.concepto = concepto;
}

angular.module('app.concepto.controllers', [])
    .controller('ListCtrl', ListCtrl)
    .controller('ShowCtrl', ShowCtrl)
    .controller('CreateEditCtrl', CreateEditCtrl);