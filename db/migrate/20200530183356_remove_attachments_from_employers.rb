class RemoveAttachmentsFromEmployers < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :employers, :avatar
    remove_attachment :employers, :curriculum_vitae
  end
end
