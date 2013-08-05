@app = angular.module('quantified', ['$strap.directives'])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['quantified'])
)

@app.controller('DayCtrl', ($scope) ->
  $scope.form_count = 0
)

@app.controller('MetadataCtrl', ($scope, $rootScope) ->
  $rootScope.form_count = 0
)

@app.controller('MDCtrl', ($scope, $rootScope) ->
  $rootScope.form_count += 1
  $scope.input_name = (field) ->
    "day[metadata_attributes][#{$scope.form_id}][#{field}]"
  $scope.form_id = $rootScope.form_count
)
