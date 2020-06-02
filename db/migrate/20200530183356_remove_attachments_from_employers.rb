class RemoveAttachmentsFromEmployers < ActiveRecord::Migration[5.2]
  def change
    remove_column :employers, :avatar, :attachment
    remove_column :employers, :curriculum_vitae, :attachment
  end
end
