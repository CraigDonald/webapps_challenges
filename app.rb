# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all

  #   response = albums.map do |album|
  #     album.title
  #   end.join(', ')

  #   return response
  
  #   # Use album_id to retrieve the corresponding
  #   # album from the database.
  # end

  get '/' do
    return erb(:index)
  end

  get '/about' do
    return erb(:about)
  end

  get '/albums' do
    repo = AlbumRepository.new
    album1 = repo.find(1)
    album2 = repo.find(2)
    album3 = repo.find(3)
    album4 = repo.find(4)
    album5 = repo.find(5)
    album6 = repo.find(6)
    

    @title1 = album1.title
    @year1 = album1.release_year
    @title2 = album2.title
    @year2 = album2.release_year
    @title3 = album3.title
    @year3 = album3.release_year
    @title4 = album4.title
    @year4 = album4.release_year
    @title5 = album5.title
    @year5 = album5.release_year
    @title6 = album6.title
    @year6 = album6.release_year
    return erb(:albums)

    # Use album_id to retrieve the corresponding
    # album from the database.
  end

  get '/albums2' do
    repo = AlbumRepository.new
    all_albums = repo.all

    all_albums.each do |album|
      @title = album.title
      @release_year = album.release_year
      return erb(:albums2)
    end
    
    # Use album_id to retrieve the corresponding
    # album from the database.
  end



  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo.create(new_album)
    return 'New album added'
  end
  
  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    output = artists.map do |artist|
      artist.name
    end.join(', ')

    return output
  end

  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    repo.create(new_artist)
    return 'New artist added'
  end

  get '/albums/:id' do
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    return erb(:selection)
  end
end