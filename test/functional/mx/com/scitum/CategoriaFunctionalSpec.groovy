package mx.com.scitum

import mx.com.scitum.pages.categoria.*
import geb.spock.GebReportingSpec


class CategoriaFunctionalSpec extends GebReportingSpec {

	def "should be able to view list page"() {
		when:
		to CategoriaListPage

		then:
		at CategoriaListPage
	}
	
	def "should be able to create a valid Categoria"() {
		when:
		to CategoriaListPage

		and:
		createButton.click()

		then:
		at CategoriaCreatePage

		when:
		descripcionField = "Foo"
		multipleField = multipleField.find('option').value()
		requiredField = requiredField.find('option').value()
			
		and:
		saveButton.click()

		then:
		at CategoriaShowPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Categoria was successfully created"
	}
	
	def "should be able to sort the Categoria List"() {
		given:
		to CategoriaListPage

		when:
		descripcionSort.click()
		
		then:
		descripcionSort.classes().contains("asc")

		when:
		multipleSort.click()
		
		then:
		multipleSort.classes().contains("asc")

		when:
		requiredSort.click()
		
		then:
		requiredSort.classes().contains("asc")
	
	}
	
	def "should be able to filter the Categoria List"() {
		given:
		to CategoriaListPage

		when:
		descripcionFilter = "Foo"
		
		then:
		waitFor { rows.size() > 0 }

		when:
		multipleFilter = multipleFilter.find('option').value()
		
		then:
		waitFor { rows.size() > 0 }

		when:
		requiredFilter = requiredFilter.find('option').value()
		
		then:
		waitFor { rows.size() > 0 }
	
	}
	
	def "should be able to edit the first Categoria"() {
		when:
		to CategoriaListPage

		and:
		rows.first().editButton.click()

		then:
		at CategoriaEditPage
		
		when:
		descripcionField = "Foo!"
		multipleField = multipleField.find('option').value()
		requiredField = requiredField.find('option').value()
		
		and:
		saveButton.click()
		
		then:
		at CategoriaShowPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Categoria was successfully updated"
	}
	
	def "should be able to delete the first Categoria"() {
		when:
		to CategoriaListPage

		and:
		rows.first().deleteButton.click()

		then:
		at CategoriaListPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Categoria was successfully deleted"
      }
	
}