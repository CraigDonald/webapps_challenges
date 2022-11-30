require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'should return a list of albums' do
      response = get('/albums')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('Surfer Rosa')
      #expect(response.body).to include('<div>')
    end
  end

  context 'Post /albums' do
    it 'should add a new album to the list' do
      response = post('/albums',title: 'OK Computer', release_date: '1997', artist_id: '1')

      expect(response.status).to eq(200)
      expect(response.body).to eq('New album added')

      check = get('/albums')
      expect(check.body).to include('OK Computer')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK and list of artists' do
      response = get('/artists')
      expected_return = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_return)
    end
  end

  context 'POST /artists/' do
    it 'adds a new artist' do
      response = post('/artists', name: 'Megadeth', 
      genre:'Rock')

      expect(response.status).to eq(200)
      expect(response.body).to eq(('New artist added'))
      check = get('/artists')
      expect(check.body).to include('Megadeth')
    end
  end

  context "GET /albums/find" do
    it 'returns 200 OK and one albums' do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('Surfer Rosa')
      expect(response.body).to include('Pixies')
    end
  end
end
