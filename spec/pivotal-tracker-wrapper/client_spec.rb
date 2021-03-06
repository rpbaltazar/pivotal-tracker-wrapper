require "spec_helper"

describe PivotalTracker::Client do

  describe ".connection" do

    context "with no existing token" do

      before do
        PivotalTracker::Client.token = nil
      end

      it "raises a NoToken exception" do
        expect(lambda { PivotalTracker::Client.connection } ).to raise_error PivotalTracker::Client::NoToken
      end

      describe "after setting a new token" do

        before do
          PivotalTracker::Client.token = "anewtoken"
        end

        it "called to RestClient::Resource using the new token" do
          expect(RestClient::Resource).to receive(:new).
              with(PivotalTracker::Client.api_ssl_url, :headers => { 'X-TrackerToken' => "anewtoken", 'Content-Type' => 'application/json' })

          PivotalTracker::Client.connection
        end

        it "returned the connection for the new token" do
          @resource = Object.new

          expect(RestClient::Resource).to receive(:new).
              with(PivotalTracker::Client.api_ssl_url, :headers => { 'X-TrackerToken' => "anewtoken", 'Content-Type' => 'application/json' }).
              and_return(@resource)

          expect(PivotalTracker::Client.connection).to eq @resource

          # We need to clear the connections or it causes later spec failures
          PivotalTracker::Client.clear_connections
        end

      end

    end

    context "with an existing token" do

      before do
        PivotalTracker::Client.token = "abc123"
      end

      it "returned a RestClient::Resource using the token" do
        @resource = Object.new

        expect(RestClient::Resource).to receive(:new).
            with(PivotalTracker::Client.api_ssl_url, :headers => { 'X-TrackerToken' => "abc123", 'Content-Type' => 'application/json' }).
            and_return(@resource)

        expect(PivotalTracker::Client.connection).to eq @resource
      end

      describe "after setting a new token" do

        before do
          PivotalTracker::Client.token = "anewtoken"
        end

        it "called to RestClient::Resource using the new token" do
          expect(RestClient::Resource).to receive(:new).
              with(PivotalTracker::Client.api_ssl_url, :headers => { 'X-TrackerToken' => "anewtoken", 'Content-Type' => 'application/json' })

          PivotalTracker::Client.connection
        end

        it "returned the connection for the new token" do
          @resource = Object.new

          expect(RestClient::Resource).to receive(:new).
              with(PivotalTracker::Client.api_ssl_url, :headers => { 'X-TrackerToken' => "anewtoken", 'Content-Type' => 'application/json' }).
              and_return(@resource)

          expect(PivotalTracker::Client.connection).to eq @resource
        end

      end

    end
  end

  describe ".tracker_host" do
    it "returns www.pivotaltracker.com by default" do
      expect(PivotalTracker::Client.tracker_host).to eq 'www.pivotaltracker.com'
    end
  end

  describe ".tracker_host=" do
    it "sets the tracker_host" do
      tracker_host_url = 'http://some_other_tracker_tracker_host_url'
      PivotalTracker::Client.tracker_host = tracker_host_url
      expect(PivotalTracker::Client.tracker_host).to eq tracker_host_url
      PivotalTracker::Client.tracker_host = nil
    end
  end

  describe "#api_ssl_url" do
    context "when not passed a username and password" do
      before do
        PivotalTracker::Client.tracker_host = nil
        PivotalTracker::Client.use_ssl      = true
      end
      it "returns https://www.pivotaltracker.com/services/v5" do
        expect(PivotalTracker::Client.api_ssl_url).to eq 'https://www.pivotaltracker.com/services/v5'
      end
    end
    context "when passed a username and password" do
      before do
        PivotalTracker::Client.tracker_host = nil
        PivotalTracker::Client.use_ssl      = true
      end
      it "returns https://USER:PASSWORD@www.pivotaltracker.com/services/v5" do
        expect(PivotalTracker::Client.api_ssl_url('USER', 'PASSWORD')).to eq 'https://USER:PASSWORD@www.pivotaltracker.com/services/v5'
      end
    end
  end

  #TODO: Add VCR here to track the requests/answers
  describe "#token" do
    context "when passing valid username and password" do
      before do
        PivotalTracker::Client.name = nil
        PivotalTracker::Client.token = nil
      end
      it 'gets the api_token from the pivotal tracker' do
        VCR.use_cassette 'get-valid-api-token' do
          PivotalTracker::Client.token(USERNAME, PASSWORD)
        end
        #token is only writable, but if there is a name
        #means that there was a token also sent by the API
        expect(PivotalTracker::Client.name).to eq NAME
        #not raising an error also ensures that token has been filled
        expect(lambda { PivotalTracker::Client.connection } ).not_to raise_error
      end
    end
    context 'when passing wrong username and password' do
      it 'raises an error' do
        VCR.use_cassette 'get-invalid-api-token' do
          expect(lambda { PivotalTracker::Client.token('asdasd', 'asdasdasd') }).to raise_error PivotalTracker::Client::AuthenticationError
        end
        expect(PivotalTracker::Client.name).to be_nil
        expect(lambda { PivotalTracker::Client.connection } ).to raise_error PivotalTracker::Client::NoToken
      end
    end
    context 'when not passing any username nor password' do
      #TODO
    end
  end

end
