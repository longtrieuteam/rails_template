# frozen_string_literal: true

module ImageHelpers
  def image(filename)
    File.open("#{Rails.root}/spec/fixtures/sample/#{filename}")
  end

  def upload_image(filename)
    fixture_file_upload(image(filename).path, 'image/jpg')
  end
end
