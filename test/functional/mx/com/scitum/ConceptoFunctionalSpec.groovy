package mx.com.scitum

import mx.com.scitum.pages.concepto.*
import geb.spock.GebReportingSpec


class ConceptoFunctionalSpec extends GebReportingSpec {

	def "should be able to view list page"() {
		when:
		to ConceptoListPage

		then:
		at ConceptoListPage
	}
	
	def "should be able to create a valid Concepto"() {
		when:
		to ConceptoListPage

		and:
		createButton.click()

		then:
		at ConceptoCreatePage

		when:
		descripcionField = "Foo"
		costoField = 99
			
		and:
		saveButton.click()

		then:
		at ConceptoShowPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Concepto was successfully created"
	}
	
	def "should be able to sort the Concepto List"() {
		given:
		to ConceptoListPage

		when:
		descripcionSort.click()
		
		then:
		descripcionSort.classes().contains("asc")

		when:
		costoSort.click()
		
		then:
		costoSort.classes().contains("asc")
	
	}
	
	def "should be able to filter the Concepto List"() {
		given:
		to ConceptoListPage

		when:
		descripcionFilter = "Foo"
		
		then:
		waitFor { rows.size() > 0 }

		when:
		costoFilter = 99
		
		then:
		waitFor { rows.size() > 0 }
	
	}
	
	def "should be able to edit the first Concepto"() {
		when:
		to ConceptoListPage

		and:
		rows.first().editButton.click()

		then:
		at ConceptoEditPage
		
		when:
		descripcionField = "Foo!"
		costoField = 100
		
		and:
		saveButton.click()
		
		then:
		at ConceptoShowPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Concepto was successfully updated"
	}
	
	def "should be able to delete the first Concepto"() {
		when:
		to ConceptoListPage

		and:
		rows.first().deleteButton.click()

		then:
		at ConceptoListPage

		and:
		successMessage.displayed

		and:
		successMessage.text().contains "Concepto was successfully deleted"
      }
	
}