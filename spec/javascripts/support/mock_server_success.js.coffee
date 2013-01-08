window.MockServerSuccess = sinon.fakeServer.create()

MockServerSuccess.respondWith(
  "GET",
  "/simeonwillbanks/tags",
  [
    200,
    { "Content-Type": "text/html" },
    '''
    <ul class='inline'>
      <li>
        <a href="/simeonwillbanks/tags/ruby" class="btn btn-success">#Ruby</a>
      </li>
      <li>
        <a href="/simeonwillbanks/tags/without-tags" class="btn">Without Tags</a>
      </li>
    </ul>
    '''
  ]
)
