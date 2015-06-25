package mx.com.scitum

import grails.converters.JSON
import grails.converters.deep.JSON as deepJSON

class CalculadoraController {

    def index() {
        [categories: [
                 [descripcion: 'Tipo de cliente',
                  multiple: false,
                  items: [
                          [descripcion: 'Gobierno', costo: 1],
                          [descripcion: 'Privado', costo: 2],
                          [descripcion: 'Financiero', costo: 3]]],
                 [descripcion: 'Arquitectura',
                  multiple: false,
                  items: [
                          [descripcion: 'Centralizado', costo: 1],
                          [descripcion: 'Distribuido', costo: 2]
                          ]],
                 [descripcion: 'Ingeniería en sitio',
                  multiple: false,
                  items: [
                          [descripcion: 'Sí', costo: 1],
                          [descripcion: 'No', costo: 2]]],
                 [descripcion: 'Tecnología',
                  multiple: true,
                  items: [
                          [descripcion: 'Firewall', costo: 1],
                          [descripcion: 'IPS', costo: 2],
                          [descripcion: 'Filtrado web', costo: 3]]]
                 ]
        ]
    }

    def add() {}

    def list() {
        List categories = Categoria.list(fetch:[conceptos: "eager", componentes: 'eager']);
//        JSON.use('deep') {
//            render categories as JSON
//        }
        render ([categories: categories, currentCatego: [techSelected: [currentItem: null, propiedades: [], arr: []]]]
                as JSON)
    }

    def cms() {

    }

    def doCalc() {
        
    }
}
