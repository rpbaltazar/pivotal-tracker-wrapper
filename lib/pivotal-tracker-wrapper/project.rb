module PivotalTracker
  class Project
    include ActiveModel::Validations

    validates_presence_of :name

    attr_accessor :name,
      :id,
      :version,
      :iteration_length,
      :week_start_day,
      :point_scale,
      :point_scale_is_custom,
      :bugs_and_chores_are_estimatable,
      :automatic_planning,
      :enable_following ,
      :enable_tasks,
      :start_date,
      :time_zone,
      :velocity_averaged_over,
      :shown_iterations_start_time,
      :start_time,
      :number_of_done_iterations_to_show,
      :has_google_domain,
      :description,
      :profile_content,
      :enable_incoming_emails,
      :initial_velocity,
      :public,
      :atom_enabled,
      :current_iteration_number,
      :current_velocity,
      :current_volatility,
      :account_id,
      :story_ids,
      :epic_ids,
      :membership_ids,
      :label_ids,
      :integration_ids,
      :iteration_override_numbers,
      :created_at,
      :updated_at,
      :kind

    def self.all
    end

    def initialize(attributes={})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
