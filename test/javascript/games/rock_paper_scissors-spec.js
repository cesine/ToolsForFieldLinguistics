/* globals RockPaperScissorsGame */

/**
 <pre>
  ======== A Handy Little Jasmine Reference ========
  https://github.com/pivotal/jasmine/wiki/Matchers

  Spec matchers:
    expect(x).toEqual(y); compares objects or primitives x and y and passes if they are equivalent
    expect(x).toBe(y); compares objects or primitives x and y and passes if they are the same object
    expect(x).toMatch(pattern); compares x to string or regular expression pattern and passes if they match
    expect(x).toBeDefined(); passes if x is not undefined
    expect(x).toBeUndefined(); passes if x is undefined
    expect(x).toBeNull(); passes if x is null
    expect(x).toBeTruthy(); passes if x evaluates to true
    expect(x).toBeFalsy(); passes if x evaluates to false
    expect(x).toContain(y); passes if array or string x contains y
    expect(x).toBeLessThan(y); passes if x is less than y
    expect(x).toBeGreaterThan(y); passes if x is greater than y
    expect(function(){fn();}).toThrow(e); passes if function fn throws exception e when executed

    Every matcher's criteria can be inverted by prepending .not:
    expect(x).not.toEqual(y); compares objects or primitives x and y and passes if they are not equivalent

    Custom matchers help to document the intent of your specs, and can help to remove code duplication in your specs.
    beforeEach(function() {
      this.addMatchers({

        toBeLessThan: function(expected) {
          var actual = this.actual;
          var notText = this.isNot ? " not" : "";

          this.message = function () {
            return "Expected " + actual + notText + " to be less than " + expected;
          }

          return actual < expected;
        }

      });
    });
</pre>

* @requires FieldDB
* @requires Jasmine
*
* @example FieldDB
* @module  FieldDBTest
* @extends  Jasmine.spec
*/
describe("rock paper scissors game", function() {

	it("should load ", function() {
		var game = new RockPaperScissorsGame();
		expect(game).toBeDefined();
	});

	it("should run ", function() {
		var game = new RockPaperScissorsGame();
		expect(game.run).toBeDefined();
	});

	it("should compare choices ", function() {
		var game = new RockPaperScissorsGame();
		expect(game.compare).toBeDefined();
	});

	describe("compare", function() {
		var game = new RockPaperScissorsGame();

		it("should decide paper beats rock ", function() {
			expect(game.compare("paper", "rock")).toEqual("paper wins");
		});
		it("should decide paper beats rock ", function() {
			expect(game.compare("rock", "paper")).toEqual("paper wins");
		});

		it("should decide paper beats rock ", function() {
			expect(game.compare("paper", "scissors")).toEqual("scissors wins");
		});

		it("should decide scissors beats paper", function() {
			expect(game.compare("scissors", "paper")).toEqual("scissors wins");
		});

		it("should decide rock beats scissors ", function() {
			expect(game.compare("rock", "scissors")).toEqual("rock wins");
		});
		it("should decide rock beats scissors ", function() {
			expect(game.compare("scissors", "rock")).toEqual("rock wins");
		});

		it("should decide rock ties rock ", function() {
			expect(game.compare("rock","rock")).toEqual("The result is a tie!");
		});

		it("should decide scissors ties scissors ", function() {
			expect(game.compare("scissors", "scissors")).toEqual("The result is a tie!");
		});

		it("should decide paper ties paper ", function() {
			expect(game.compare("paper","paper")).toEqual("The result is a tie!");
		});
	});

});