describe('Categoria Routes: ', function() {
    beforeEach(module('app.categoria'));
	var location, route, rootScope;

	beforeEach(module(function($provide) {          
		$provide.value('rootUrl', '/');
	}));	
	
	
	beforeEach(inject(
		function($location, $route, $rootScope) {
			location = $location;
			route = $route;
			rootScope = $rootScope;
		}	
	));
	
	describe('Index route: ', function() {
		beforeEach(inject(
			function($httpBackend) {
				$httpBackend.whenGET('list.html').respond(200, 'list page');
				$httpBackend.whenGET('/api/categoria').respond([]);

			}
		));
		
		it('should load the list page on successful load of /', function() {
			location.path('/');
			rootScope.$digest();
			expect(route.current.controller).toBe('ListCtrl as ctrl');
		});
		
		it('should redirect to the list page on non-existent route', function() { 
			location.path('bogus/route/foo/bar'); 
			rootScope.$digest(); 
			expect(route.current.controller).toBe('ListCtrl as ctrl');
		});
	
		it('should load the list page on successful load of /', function() {
			location.path('/');
			rootScope.$digest();
			expect(route.current.controller).toBe('ListCtrl as ctrl');
		});
	
	});

	describe('Create route: ', function() {
		beforeEach(inject(
			function($httpBackend) {
				$httpBackend.whenGET('create-edit.html').respond(200, 'list page');
				$httpBackend.whenGET('/api/categoria/create').respond([]);

			}
		));
		
		it('should load the create page on successful load of /create', function() {
			location.path('/create');
			rootScope.$digest();
			expect(route.current.controller).toBe('CreateEditCtrl as ctrl');
		});
	
	});
	
	describe('Edit route: ', function() {
		beforeEach(inject(
			function($httpBackend) {
				$httpBackend.whenGET('create-edit.html').respond(200, 'list page');
				$httpBackend.whenGET('/api/categoria/1').respond([]);

			}
		));
		
		it('should load the edit page on successful load of /edit', function() {
			location.path('/edit/1');
			rootScope.$digest();
			expect(route.current.controller).toBe('CreateEditCtrl as ctrl');
		});
	
	});	
	

});