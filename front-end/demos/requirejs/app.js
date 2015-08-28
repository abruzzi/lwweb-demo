require.config({
　　　　paths: {
　　　　　　"underscore": "libs/underscore/underscore"
　　　　},
      shim: {
　　　　　　'underscore':{
　　　　　　　　exports: '_'
　　　　    }
      }
　　});

require(['underscore', 'city-population'], function(_, population) {
  var numbers = _.pluck(population, "population");
  console.log(numbers);
});
