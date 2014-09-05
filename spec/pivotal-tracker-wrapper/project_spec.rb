require "spec_helper"

describe PivotalTracker::Project do

  describe 'validations' do
    let(:project) { PivotalTracker::Project.new }
    context 'project does not have a name' do
      it 'is invalid' do
        expect(project.valid?).to eq false
      end
    end
    context 'it has name' do
      before do
        project.name = 'This is a test'
      end
      it 'is a valid object' do
        expect(project.valid?).to eq true
      end
    end
  end

  describe 'API calls' do
    before do
      PivotalTracker::Client.token(USERNAME, PASSWORD)
    end

    describe "#all" do
      before do
        VCR.use_cassette 'get-projects' do
          @projects = PivotalTracker::Project.all
        end
      end

      it "should return an array of available projects" do
        expect(@projects).to be_a(Array)
      end

      it "should be a project instance" do
        expect(@projects.first).to be_a(PivotalTracker::Project)
      end
    end
  end
end
