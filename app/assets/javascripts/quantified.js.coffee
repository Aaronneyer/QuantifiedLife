@app = angular.module('quantified', ['$strap.directives'])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['quantified'])
)

@app.controller('DaySummaryCtrl', ->
)
