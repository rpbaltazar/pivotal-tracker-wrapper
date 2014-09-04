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
end
