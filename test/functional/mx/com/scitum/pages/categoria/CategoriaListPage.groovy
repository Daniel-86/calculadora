package mx.com.scitum.pages.categoria

import geb.Module
import geb.Page

class CategoriaListPage extends Page {

    static url = "categoria"

    static at = { $('h2').text() == 'Categoria List' }

    static content = {
		descripcionFilter {$("input[ng-model='ctrl.filter.descripcion']")}
		multipleFilter {$("input[ng-model='ctrl.filter.multiple']")}
		requiredFilter {$("input[ng-model='ctrl.filter.required']")}
	
		descripcionSort { $("table#list th[property='descripcion']") }
		multipleSort { $("table#list th[property='multiple']") }
		requiredSort { $("table#list th[property='required']") }
    
	    createButton { $("button[crud-button='create']") }
        successMessage { $(".alert-success") }
		
        rows { moduleList CategoriaListRow, $("table#list tbody tr") }
    }

}

class CategoriaListRow extends Module {

	static content = {
		cell { $("td") }
        editButton {$("button[crud-button='edit']")}
        deleteButton {$("button[crud-button='delete']")}
    }

}