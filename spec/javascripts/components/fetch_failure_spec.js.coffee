#= require spec_helper
#= require components/fetch

# TODO
# These tests need to be better
describe "MyGists.Fetch#tags", ->
  describe "failure", ->
    beforeEach ->
      sinon.spy $, "ajax"

    afterEach ->
      $.ajax.restore()

    it "should make an ajax request", (done) ->
      MyGists.Fetch.tags('/badprofile', $)
      chai.expect($.ajax.calledOnce).to.be.true
      done()

    it "to the passed profiles tags", (done) ->
      MyGists.Fetch.tags('/badprofile', $)
      chai.expect($.ajax.getCall(0).args[0].url).to.equal('/badprofile/tags')
      done()

    # TODO
    # Test error callback
    #it "and error callback invoked", (done) ->
    #  sinon.spy MyGists.Fetch, "error"
    #  MyGists.Fetch.tags('/badprofile', $)
    #  chai.expect(MyGists.Fetch.error.calledOnce).to.be.true
    #  done()
