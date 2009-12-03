module LastfmTags
  include Radiant::Taggable

  desc %{
    Gives access to users last.fm user profile [user="username"]
  }
  tag 'lastfm' do |tag|
    raise StandardError::new('the lastfm tag needs a username in the user attribute') if tag.attr['user'].blank?
    tag.locals.user = Scrobbler::User.new(tag.attr['user'])
    tag.expand
  end

  desc %{
    Retrieve a users recent tracks
  }
  tag 'lastfm:tracks' do |tag|
    tag.locals.tracks = tag.locals.user.recent_tracks
    tag.expand
  end

  desc %{
    Loops through a users tracks.
  }
  tag 'lastfm:tracks:each' do |tag|
    tag.locals.tracks.collect do |track|
      tag.locals.track = track
      tag.expand
    end
  end

  desc %{
    Returns the number of tracks.
  }
  tag 'lastfm:tracks:length' do |tag|
    tag.locals.tracks.length
  end
  
  desc %{
    Creates the context for a single track.
  }
  tag 'lastfm:tracks:each:track' do |tag|
    tag.expand
  end

  desc %{
    Renders the artist name for the current track.
  }
  tag 'track:artist' do |tag|
    track = tag.locals.track
    track.artist
  end

  desc %{
    Renders the name for the current track.
  }
  tag 'track:name' do |tag|
    track = tag.locals.track
    track.name
  end

  desc %{
    Renders the date for the current track.
  }
  tag 'track:date' do |tag|
    track = tag.locals.track
    track.date
  end

  desc %{
    Renders the url for the current track.
  }
  tag 'track:url' do |tag|
    track = tag.locals.track
    track.url
  end
end
