var expect = chai.expect;

describe("Calculator", function() {
    it("should return 5 when add 2 and 3", function() {
        var calc = new Calculator();
        expect(calc.add(2, 3)).to.equal(5);
    });

    it("should return 1 when sub 2 and 3", function() {
        var calc = new Calculator();
        expect(calc.sub(2, 3)).to.equal(-1);
    });

    this.timeout(6000);

    it("should return 5 after a while", function(done) {

        var calc = new Calculator();
        calc.longAdd(2, 3, function(x) {
          expect(x).to.equal(5);
          done();
        });
    });

    it("should return 6 when mul 2 and 3");
    it("should return 1.5 when div 3 and 2");
    it("should throw exception when div by 0");
});
