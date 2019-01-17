const expect = require('expect.js');

describe('Fun challenges', () => {

  it('should test expectations', () => {
    expect(true).to.be(true);
    expect(true).to.not.be(false);
    expect([1, 2, 3]).to.eql([1, 2, 3]);
  });

});
