require 'uri'

module CarrierWave
  module Utilities
    module Uri
    # based on Ruby < 2.0's URI.encode
    SAFE_STRING = URI::REGEXP::PATTERN::UNRESERVED + '\/'
    UNSAFE = Regexp.new("[^#{SAFE_STRING}]", false)

    private
      def encode_path(path)
      	path
      end
    end # Uri
  end # Utilities
end # CarrierWave