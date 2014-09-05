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
      VCR.use_cassette 'get-valid-api-token' do
        PivotalTracker::Client.token(USERNAME, PASSWORD)
      end
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

      it "it returns valid projects with ids" do
        @projects.each do |proj|
          expect(proj.valid?).to eq true
          expect(proj.id).not_to be_nil
        end
      end
    end

    describe '#find(id)' do
      describe 'projects loaded previously' do
        before do
          VCR.use_cassette 'get-projects' do
            @projects = PivotalTracker::Project.all
          end
        end
        describe 'when getting a valid project id' do
          before do
            VCR.use_cassette "get-project-id-#{PROJECT_ID}" do
              @project = PivotalTracker::Project.find PROJECT_ID
            end
          end

          it 'does not make an HTTP request' do
            expect(a_request(:get, "https://www.pivotaltracker.com/services/v5/projects/#{PROJECT_ID}")).not_to have_been_made
          end

          it 'returns a project instance' do
            expect(@project).to be_a(PivotalTracker::Project)
          end

          it 'is a valid project' do
            expect(@project.valid?).to eq true
          end
        end
      end

      describe 'projects not loaded previously' do
        describe 'when getting a valid project id' do
          before do
            PivotalTracker::Project.reset
            VCR.use_cassette "get-project-id-#{PROJECT_ID}" do
              @project = PivotalTracker::Project.find PROJECT_ID
            end
          end

          it 'returns a project instance' do
            expect(@project).to be_a(PivotalTracker::Project)
          end

          it 'makes an HTTP request' do
            expect(a_request(:get, "https://www.pivotaltracker.com/services/v5/projects/#{PROJECT_ID}")).to have_been_made
          end

          it 'is a valid project' do
            expect(@project.valid?).to eq true
          end
        end

        describe 'when getting an invalid project id' do
          it 'Throws an Authentication Error' do
            VCR.use_cassette "get-project-id-invalid" do
              expect(lambda { PivotalTracker::Project.find 1} ).to raise_error RestClient::Forbidden
            end
          end
        end
      end
    end
  end
end
