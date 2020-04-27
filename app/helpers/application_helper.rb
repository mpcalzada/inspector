module ApplicationHelper

  def current_employer(user_id)
    Employer.current_employer(user_id)
  end

  def current_employer_name(user_id)
    employer = self.current_employer(user_id)
    employer.nil? ? 'Unknown User' : employer.first_name + employer.last_name
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? 'active' : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? 'active' : nil
  end
end
