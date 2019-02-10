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

var Game = function(options = {}) {
  this.topFloor = typeof options.topFloor === 'number' ? options.topFloor : 100;
  this.eggs = typeof options.eggs === 'number' ? options.eggs : 2;
  this.itterations = 0;
  this.floorWhereEggBreaks = typeof options.floorWhereEggBreaks === 'number' ? options.floorWhereEggBreaks : Math.ceil(Math.random() * this.topFloor);
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
  var firstRound = 0;

  for (var i = game.multiplier; i < game.topFloor; i += game.multiplier) {
    console.log('Dropping at ', i);
    game.itterations += 1;

    if (game.floorWhereEggBreaks <= i) {
      console.log('  Shplat ' + game.eggs + ' break at ', i, game.floorWhereEggBreaks);

      game.eggs -= 1;
      firstRound = i - game.multiplier;
      break;
    }
    console.log('  Egg didnt break at ', i);
  }

  for (var j = firstRound + 1; j <= game.topFloor; j += 1) {
    console.log('Dropping at ', j);
    game.itterations += 1;

    if (game.floorWhereEggBreaks <= j) {
      console.log('  Shplat ' + game.eggs + ' at  ', j, game.floorWhereEggBreaks);

      game.eggs -= 1;
      return j - 1;
    }
    console.log('  Egg didnt break at ', j);
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
    it("should be able to find max safe flore in finite time", function() {
      var game = new Game();

      var safeFloor = findMaxSafeFloor(game);
      expect(safeFloor).toEqual(game.floorWhereEggBreaks - 1);

      // expect(game.itterations).toEqual(game.floorWhereEggBreaks-1);
    });
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
