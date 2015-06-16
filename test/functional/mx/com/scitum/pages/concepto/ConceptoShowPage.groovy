package mx.com.scitum.pages.concepto

import geb.Page

class ConceptoShowPage extends Page {

    static at = { $('h2').text().startsWith 'Show Concepto' }

    static content = {
        successMessage { $(".alert-success") }
    }

}