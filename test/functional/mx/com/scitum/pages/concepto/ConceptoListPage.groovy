package mx.com.scitum.pages.concepto

import geb.Module
import geb.Page

class ConceptoListPage extends Page {

    static url = "concepto"

    static at = { $('h2').text() == 'Concepto List' }

    static content = {
		descripcionFilter {$("input[ng-model='ctrl.filter.descripcion']")}
		costoFilter {$("input[ng-model='ctrl.filter.costo']")}
	
		descripcionSort { $("table#list th[property='descripcion']") }
		costoSort { $("table#list th[property='costo']") }
    
	    createButton { $("button[crud-button='create']") }
        successMessage { $(".alert-success") }
		
        rows { moduleList ConceptoListRow, $("table#list tbody tr") }
    }

}

class ConceptoListRow extends Module {

	static content = {
		cell { $("td") }
        editButton {$("button[crud-button='edit']")}
        deleteButton {$("button[crud-button='delete']")}
    }

}