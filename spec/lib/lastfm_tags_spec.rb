require File.dirname(__FILE__) + '/../spec_helper'

describe 'LastfmTags' do
  dataset :pages

  describe '<r:lastfm> The main context' do
    it 'should require a lastfm username in the name attribute' do
      tag = %{<r:lastfm />}

      pages(:home).should render(tag).with_error('the lastfm tag needs a username in the user attribute')
    end

    # TODO ??
    #it 'should assign the username' do
    #  tag = %{<r:lastfm user='polymorphic' />}
    #  expected = ''
    #
    #  lastfm_user_obj.username.should.equal user
    #end

    it 'should give no output' do
      tag = %{<r:lastfm user='polymorphic' />}
      expected = ''

      pages(:home).should render(tag).as(expected)
    end
  end

  describe '<r:lastfm:tracks> Collect the users recent tracks' do
    it 'should give no output' do
      tag = %{<r:lastfm user='polymorphic' ><r:tracks></r:tracks></r:lastfm>}
      expected = ''

      pages(:home).should render(tag).as(expected)
    end

    it 'should report the correct number of tracks' do
      tag = %{<r:lastfm user='polymorphic'><r:tracks:length /></r:lastfm>}

      lastfm_user_obj = Scrobbler::User.new("polymorphic")
      Scrobbler::User.should_receive(:new).and_return(lastfm_user_obj)
      lastfm_user_obj.should_receive(:recent_tracks).and_return(["track1","track2","track3"])

      expected = "3"
      pages(:home).should render(tag).as(expected)
    end

    it 'should return the correct name' do
      tag = %{<r:lastfm user='polymorphic' ><r:tracks:each><r:track:name /></r:tracks:each></r:lastfm>}

      track1 = setup_track1

      expected = track1.name
      mock_recent_tracks(track1)

      pages(:home).should render(tag).as(expected)
    end

    it 'should return the correct artist' do
      tag = %{<r:lastfm user='polymorphic' ><r:tracks:each><r:track:artist /></r:tracks:each></r:lastfm>}

      track1 = setup_track1

      expected = track1.artist
      mock_recent_tracks(track1)

      pages(:home).should render(tag).as(expected)
    end

    it 'should return the correct url' do
      tag = %{<r:lastfm user='polymorphic' ><r:tracks:each><r:track:url /></r:tracks:each></r:lastfm>}

      track1 = setup_track1

      expected = track1.url
      mock_recent_tracks(track1)

      pages(:home).should render(tag).as(expected)
    end

    it 'should return the correct date' do
      tag = %{<r:lastfm user='polymorphic' ><r:tracks:each><r:track:date /></r:tracks:each></r:lastfm>}

      track1 = setup_track1

      expected = track1.date.to_s
      mock_recent_tracks(track1)

      pages(:home).should render(tag).as(expected)
    end
  end

  def setup_track1
    track1 = Scrobbler::Track.new("peverelist","bluez")
    track1.url = "http://last.fm/music/peverelist/bluez/blah"
    track1.date = Time.now
    return track1
  end

  def mock_recent_tracks(track1)
    lastfm_user_obj = Scrobbler::User.new("polymorphic")
    Scrobbler::User.should_receive(:new).and_return(lastfm_user_obj)
    lastfm_user_obj.should_receive(:recent_tracks).and_return([track1])
  end

end