/**
 * A building has 100 floors. One of the floors is the highest floor an
 * egg can be dropped from without breaking.
 *
 * If an egg is dropped from above that floor, it will break. If it is
 * dropped from that floor or below, it will be completely undamaged and
 * you can drop the egg again.
 *
 * Given two eggs, find the highest floor an egg can be dropped from
 * without breaking, with as few drops as possible.
 */
var debug = function() {
  console.log(arguments);
  return;
};

var Game = function(options) {
  this.topFloor = typeof options.topFloor === 'number' ? options.topFloor : 100;
  this.eggs = typeof options.eggs === 'number' ? options.eggs : 2;
  this.floorWhereEggBreaks = typeof options.floorWhereEggBreaks === 'number' ? options.floorWhereEggBreaks : Math.ceil(Math.random() * this.topFloor);
  return this;
};

var findMaxSafeFloor = function(game) {
  game.itterations = 1;
  return 1;
};

fdescribe("Not Quite Binary Search", function() {
  describe("construction", function() {
    it("should support ranch homes", function() {
      var game = new Game({
        topFloor: 0
      });
      expect(game).toEqual(new Game({
        eggs: 2,
        topFloor: 0,
        floorWhereEggBreaks: 0,
      }));
      expect(findMaxSafeFloor(game)).toEqual(1);
    });

    it("should accept a max floor", function() {
      var game = new Game({
        topFloor: 1
      });
      expect(game).toEqual(new Game({
        eggs: 2,
        topFloor: 1,
        floorWhereEggBreaks: 1,
      }));
      expect(findMaxSafeFloor(game)).toEqual(1);
    });

    it("should find a random safe floor", function() {
      var games = [new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      }), new Game({
        topFloor: 2
      })];
      var floorsWhereEggBreaks = games.map(function(game) {
        return game.floorWhereEggBreaks;
      });
      debug('random floorsWhereEggBreaks', floorsWhereEggBreaks);
      expect(floorsWhereEggBreaks).toContain(1);
      expect(floorsWhereEggBreaks).toContain(2);
      expect(floorsWhereEggBreaks).not.toContain(0);
      expect(floorsWhereEggBreaks).not.toContain(3);
    });

    it("should find a random safe floor in a high building", function() {
      var game = new Game({
        topFloor: 20
      });
      expect(game).toEqual(new Game({
        eggs: 2,
        topFloor: 20,
        floorWhereEggBreaks: game.floorWhereEggBreaks,
      }));
      expect(game.floorWhereEggBreaks).toBeGreaterThan(1);
      expect(game.floorWhereEggBreaks).toBeLessThan(21);
    });
  });

  describe("search", function() {
    it("should be able to find max safe flore in finite time", function() {});
  });

  describe("performance", function() {
    it("should run in better than N time", function() {
      var startTime;
      var samples = [];
      var size = 500;
      var k;

      var matrix = [];
      for (k = 1; k < 5; k++) {
        startTime = Date.now();
        matrix[k] = new Game(k);
        samples.push((Date.now() - startTime));
      }

      debug(samples);
    });
  });
});
