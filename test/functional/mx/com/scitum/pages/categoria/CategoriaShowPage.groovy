package mx.com.scitum.pages.categoria

import geb.Page

class CategoriaShowPage extends Page {

    static at = { $('h2').text().startsWith 'Show Categoria' }

    static content = {
        successMessage { $(".alert-success") }
    }

}