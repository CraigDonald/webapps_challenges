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

  get '/albums' do
    repo = AlbumRepository.new
    album1 = repo.find(1)
    album2 = repo.find(2)

    @title1 = album1.title
    @year1 = album1.release_year
    @title2 = album2.title
    @year2 = album2.release_year
    return erb(:albums)

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