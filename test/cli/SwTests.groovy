import grails.test.AbstractCliTestCase

class SwTests extends AbstractCliTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSw() {

        execute(["sw"])

        assertEquals 0, waitForProcess()
        verifyHeader()
    }
}
