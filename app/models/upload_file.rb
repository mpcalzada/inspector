class UploadFile < ActiveRecord::Base

  belongs_to :user

  has_attached_file :file, :default_url => '/system/:basename.:extension'

  validates_attachment_content_type :file, content_type: %w(application/vnd.openxmlformats-officedocument.wordprocessingml.document application/zip application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-excel application/xls application/xlsx application/octet-stream), message: ' Only EXCEL files are allowed.'
  validates_attachment_size :file, :less_than => 10.megabytes

end