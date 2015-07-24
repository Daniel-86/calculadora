package mx.com.scitum

class CalculadoraTagLib {
    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    static encodeAsForTags = [header: [taglib: 'raw']]

    static namespace = "calculadora"

    def header = { attrs, body->
        out << render(template: '/backoffice/templates/header-bar')
    }
}
