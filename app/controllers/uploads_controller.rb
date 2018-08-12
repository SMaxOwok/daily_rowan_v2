require "dotenv"

class UploadsController < ApplicationController
  http_basic_authenticate_with name: ENV["UPLOAD_AUTH_NAME"], password: ENV["UPLOAD_AUTH_PASSWORD"]

  def index; end

  def create
    file = params.dig(:upload, :file)

    upload = Upload.create do |record|
      record.file.attach file
    end

    if upload.persisted?
      ProcessUploadJob.perform_later upload
      redirect_to upload_path, notice: "Successfully queued file for processing."
    else
      errors = upload.errors.full_messages.join("<br/>")
      flash[:error] = "Could not queue file for processing.<br/></br>#{errors}".html_safe
      render :index
    end
  end
end