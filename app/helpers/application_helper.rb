module ApplicationHelper

  def current_employer(user_id)
    Employer.current_employer(user_id)
  end

  def current_employer_name(user_id)
    employer = self.current_employer(user_id)
    employer.nil? ? 'Unknown User' : employer.first_name + ' ' + employer.paternal_last_name
  end

  def has_employer_roles(current_user)
    current_user.has_cached_role? :admin or current_user.has_cached_role? :employer_admin or
        current_user.has_cached_role? :employer_editor or current_user.has_cached_role? :employer_viewer
  end

  def has_degree_roles(current_user)
    current_user.has_cached_role? :admin
  end

  def has_attendance_roles(current_user)
    current_user.has_cached_role? :admin
  end

  def has_accounting_roles(current_user)
    current_user.has_cached_role? :admin
  end

  def has_report_roles(current_user)
    current_user.has_cached_role? :admin
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? 'active' : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? 'active' : nil
  end
end
