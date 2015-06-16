package mx.com.scitum.pages.concepto

import geb.Module
import geb.Page

class ConceptoEditPage extends Page {

    static url = "concepto#/create"

    static at = { $('h2').text() == 'Edit Concepto' }

    static content = {
		descripcionField {$("input[ng-model='ctrl.concepto.descripcion']")}
		costoField {$("input[ng-model='ctrl.concepto.costo']")}
        saveButton { $('button[crud-button="save"]') }
    }

}