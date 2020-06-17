module EmployersHelper

  def time_formatter (time)
    time.nil? ? '12:00' : DateTime.parse(time.to_s).strftime('%H:%M')
  end

  def is_viewer (current_user)
    current_user.has_cached_role? :admin or current_user.has_cached_role? :employer_admin or
        current_user.has_cached_role? :employer_editor or current_user.has_cached_role? :employer_viewer
  end

  def is_editor (current_user)
    current_user.has_cached_role? :admin or current_user.has_cached_role? :employer_admin or current_user.has_cached_role? :employer_editor
  end

  def is_admin (current_user)
    current_user.has_cached_role? :admin or current_user.has_cached_role? :employer_admin
  end
end
