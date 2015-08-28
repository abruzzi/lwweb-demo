var Calculator = function() {
  this.add = function(a, b) {
    return a + b;
  },

  this.sub = function(a, b) {
    return a - b;
  },

  this.longAdd = function(a, b, cb) {
    var self = this;
    setTimeout(function() {
      cb(self.add(a, b));
    }, 5000);
  }
}
