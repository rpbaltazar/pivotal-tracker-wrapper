module PivotalTracker
  class Story
    include ActiveModel::Validations

    validates_presence_of :name

    attr_accessor :id,
    :project_id,
    :name,
    :description,
    :story_type,
    :current_state,
    :estimate,
    :accepted_at,
    :deadline,
    :requested_by_id,
    :owned_by_id,
    :owner_ids,
    :label_ids,
    :task_ids,
    :follower_ids,
    :comment_ids,
    :created_at,
    :updated_at,
    :before_id,
    :after_id,
    :integration_id,
    :external_id,
    :url,
    :kind

    def initialize(attributes={})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
