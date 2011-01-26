module CarrierWave
  module SanitizedFileCompat
    def pos
      if is_path?
        File.open(@file).pos
      else
        @file.pos
      end
    end

    def eof?
      if is_path?
        File.open(@file).eof?
      else
        @file.eof?
      end
    end
  end

  class SanitizedFile
    include SanitizedFileCompat
  end
end
