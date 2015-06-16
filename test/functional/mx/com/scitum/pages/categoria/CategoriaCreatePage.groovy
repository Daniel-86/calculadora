package mx.com.scitum.pages.categoria

import geb.Module
import geb.Page

class CategoriaCreatePage extends Page {

    static url = "categoria#/create"

    static at = { $('h2').text() == 'Create Categoria' }

    static content = { 
		descripcionField {$("input[ng-model='ctrl.categoria.descripcion']")}
		multipleField {$("input[ng-model='ctrl.categoria.multiple']")}
		requiredField {$("input[ng-model='ctrl.categoria.required']")}
        saveButton { $('button[crud-button="save"]') }
    }

}