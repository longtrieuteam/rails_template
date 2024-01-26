# frozen_string_literal: true

module Utils
  class FileHelper
    class << self
      def remove_file(file_path)
        FileUtils.rm_f(file_path) if File.file?(file_path)
      end

      def create_dir(dir_path)
        FileUtils.mkdir_p(dir_path) unless File.directory?(dir_path)
      end
    end
  end
end
