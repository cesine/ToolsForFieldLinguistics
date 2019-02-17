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
  this.topFloor = (options && typeof options.topFloor === "number") ? options.topFloor : 100;
  this.eggs = (options && typeof options.eggs === "number") ? options.eggs : 2;
  this.itterations = 0;
  this.floorWhereEggBreaks = (options && typeof options.floorWhereEggBreaks === "number") ? options.floorWhereEggBreaks : Math.ceil(Math.random() * this.topFloor);
  return this;
};

/**
 * Proof
 *
 * 100 floors:
 *   1: try each 10 floors
 *   2: try each floor
 * = 10, 20, 30, 40, 50, 60, 70, 80, 90, x1, x2, x3, x4, x5, x6, x7, x8, x9
 * = 17
 *
 * 100 floors:
 *   1: try each 20 floors
 *   2: try each floor
 * = 20, 40, 60, 80, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19
 * = 24
 *
 * 100 floors:
 *   1: try each 5 floors
 *   2: try each floor
 * = 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, x+1, x+2, x+3, x+4
 * = 24
 *
 * 100 floors:
 *   1: try each 9 floors
 *   2: try each floor
 * = 19
 *
 *
 * 48 floors:
 *  8 x 8
 *
 * @param  {[type]} game [description]
 * @return {[type]}      [description]
 */
var findMaxSafeFloor = function(game) {
  game.multiplier = Math.ceil(Math.sqrt(game.topFloor));
  var multiplier = game.multiplier * (game.eggs - 1);
  var currentFloor = 0;

  while (game.eggs && multiplier) {
    debug("Series: " + multiplier);
    for (var i = currentFloor + multiplier; i <= game.topFloor; i += multiplier) {
      debug(" Dropping at ", i);
      game.itterations += 1;

      if (game.floorWhereEggBreaks <= i) {
        debug("  Shplat egg " + game.eggs + " broke at " + i + " (" + game.floorWhereEggBreaks + ")");

        game.eggs -= 1;
        currentFloor = i - multiplier;
        if (game.eggs === 0) {
          debug(" I found the safe floor " + (i - multiplier) + " in " + game.itterations + " itterations.");
          return i - multiplier;
        }

        multiplier = game.eggs === 1 ? 1 : Math.ceil(game.multiplier / (game.eggs - 1));
        break;
      }
      debug("  Egg didnt break");
    }
  }

  return game.topFloor;
};

describe("Not Quite Binary Search", function() {
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
      expect(findMaxSafeFloor(game)).toEqual(0);
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
      expect(findMaxSafeFloor(game)).toEqual(0);
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
      debug("random floorsWhereEggBreaks", floorsWhereEggBreaks);
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
    it("should be able to find max safe floor in finite time", function() {
      var game = new Game();

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(game.floorWhereEggBreaks - 1);
      expect(game.itterations).toBeLessThan(20);
    });

    it("should be able to find max safe floor if safe floor is top floor", function() {
      var game = new Game({
        topFloor: 20,
        floorWhereEggBreaks: 21,
      });

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(20);
      expect(game.itterations).toEqual(1);
    });

    xit("should be able to find max safe floor if ^3", function() {
      var game = new Game({
        eggs: 2,
        topFloor: 100,
        floorWhereEggBreaks: 100
      });

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(game.floorWhereEggBreaks - 1);
      expect(game.itterations).toEqual(20);
    });

    xit("should be able to find max safe floor if 3 eggs", function() {
      var game = new Game({
        eggs: 3,
        topFloor: 64,
        floorWhereEggBreaks: 17
      });

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(game.floorWhereEggBreaks - 1);
      expect(game.itterations).toEqual(4);
    });

    xit("should be able to find max safe floor if 3 eggs", function() {
      var game = new Game({
        eggs: 3,
        topFloor: 64,
      });

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(game.floorWhereEggBreaks - 1);
      expect(game.itterations).toBeLessThan(14);
    });
  });

  describe("performance", function() {
    xit("should run in better than N time", function() {
      var game;
      var matrix = [];
      var startTime;
      var samples = [];
      var size = 100;
      var k;

      for (k = 0; k <= size; k++) {
        startTime = Date.now();
        game = new Game({ topFloor: k });
        console.log('game start', game);
        game.safeFloor = findMaxSafeFloor(game);
        console.log('game end', game);

        matrix[k] = game;
        samples[k] = Date.now() - startTime;
      }

      console.log(samples);
    });
  });
});
