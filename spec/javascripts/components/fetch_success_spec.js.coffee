#= require spec_helper
#= require support/mock_server_success
#= require components/fetch

# TODO
# These tests need to be better
describe "MyGists.Fetch#tags", ->
  describe "success", ->
    beforeEach ->
      sinon.spy $, "ajax"
      MockServerSuccess.respond()

    afterEach ->
      $.ajax.restore()

    it "should make an ajax request", (done) ->
      MyGists.Fetch.tags('/simeonwillbanks', $)
      chai.expect($.ajax.calledOnce).to.be.true
      done()

    it "to the passed profiles tags", (done) ->
      MyGists.Fetch.tags('/simeonwillbanks', $)
      chai.expect($.ajax.getCall(0).args[0].url).to.equal('/simeonwillbanks/tags')
      done()

    # TODO
    # Test success callback
    #it "and success callback invoked", (done) ->
    #  sinon.spy MyGists.Fetch, "success"
    #  MyGists.Fetch.tags('/simeonwillbanks', $)
    #  chai.expect(MyGists.Fetch.success.calledOnce).to.be.true
    #  done()
