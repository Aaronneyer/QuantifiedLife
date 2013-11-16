@app = angular.module('quantified', [])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['quantified'])
)

@app.controller('DayCtrl', ($scope) ->
  $scope.field_name = 'day';
)

@app.controller('UserCtrl', ($scope) ->
  $scope.field_name = 'user';
)

@app.controller('MetadataCtrl', ($scope, $rootScope) ->
  $rootScope.form_count = 0
)

@app.controller('MDCtrl', ($scope, $rootScope) ->
  $rootScope.form_count += 1
  $scope.form_id = $rootScope.form_count
  $scope.input_name = (field) ->
    "#{$scope.field_name}[extra_info_attributes][#{$scope.form_id}][#{field}]"
  $scope.input_id = (field) ->
    "#{$scope.field_name}_extra_info_attributes_#{$scope.form_id}_#{field}"

  $scope.delete = (md) ->
    $scope.metadata.splice($scope.metadata.indexOf(md), 1)

)
