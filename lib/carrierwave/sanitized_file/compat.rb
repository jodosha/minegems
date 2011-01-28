module CarrierWave
  module SanitizedFileCompat
    def pos
      if is_path?
        @file = File.open(@file)
        pos
      else
        @file.pos
      end
    end

    def eof?
      if is_path?
        @file = File.open(@file)
        eof?
      else
        @file.eof?
      end
    end
  end

  SanitizedFile.class_eval do
    include SanitizedFileCompat

    def read(length = nil)
      if is_path?
        @file = File.open(@file, "rb")
        read(length)
      else
        @file.rewind if @file.respond_to?(:rewind)
        @file.read(length)
      end
    end
  end
end
