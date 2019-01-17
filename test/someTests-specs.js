const expect = require('expect.js');
const { multiplyAll } = require('../src/problems');

describe('Fun challenges', () => {
  it('Test Mocha: ', () => {
    expect(true).to.be(true);
    expect(true).to.not.be(false);
    expect([1, 2, 3]).to.eql([1, 2, 3]);
  });

  it('should return [24, 12, 8, 6]', () => {
    const result = multiplyAll([1,2,3,4]);
    expect(result).to.eql([24, 12, 8, 6]);
  });
});
