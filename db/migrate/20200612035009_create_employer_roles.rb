class CreateEmployerRoles < ActiveRecord::Migration[5.2]
  def up
    %w[admin new_user employer_admin employer_editor employer_viewer].each do |role_name|
      Role.create! name: role_name
    end
  end
end
