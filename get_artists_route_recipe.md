GET /albums Route Design Recipe

Copy this design recipe template to test-drive a Sinatra route.

1. Design the Route Signature
You'll need to include:

the HTTP method
the path
any query parameters (passed in the URL)
or body parameters (passed in the request body)

Method: GET
Path: /artists

Method: POST
Path: /artists


2. Design the Response
The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return 200 OK if the post exists, but 404 Not Found if the post is not found in the database.

Your response might return plain text, JSON, or HTML code.

Replace the below with your own design. Think of all the different possible responses your route will return.

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

```
'Pixies', 'ABBA', 'Taylor Swift', 'Nina Simone', 'Kiasmos'
etc.
```
Returns text list of artists


3. Write Examples
Replace these with your own design.

# Request:

GET /artists

# Expected response:

Response for 200 OK

Pixies
ABBA
Taylor Sift
Nina Simone
Kiasmos

# Request:

POST /artists

# Expected response:

''
May add in string to say 'New album #{albumname} added'

4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /artists" do
    it 'returns 200 OK and list of artists' do
      # Assuming the post with id 1 exists.
      response = get('/artists')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

  context 'POST /artists/' do
    it 'adds a new artist' do
      response = post('/artists', name:'Led Zeppelin', genre:'Rock')

      expect(response.status).to eq(200)
      expect(response.body).to eq('New artist added')

      check = get('/artists')
      expect(check).to include('Led Zeppelin')
    end
  end
end

```

5. Implement the Route
Write the route and web server code to implement the route behaviour.