@app = angular.module('quantified', [])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['quantified'])
)

@app.controller('DayCtrl', ($scope) ->
)

@app.controller('MetadataCtrl', ($scope, $rootScope) ->
  $rootScope.form_count = 0
)

@app.controller('MDCtrl', ($scope, $rootScope) ->
  $rootScope.form_count += 1
  $scope.form_id = $rootScope.form_count
  $scope.input_name = (field) ->
    "day[metadata_attributes][#{$scope.form_id}][#{field}]"
  $scope.input_id = (field) ->
    "day_metadata_attributes_#{$scope.form_id}_#{field}"

)
