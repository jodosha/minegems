module CarrierWave
  module Uploader
    module Compat
      def pos
        file.pos
      end

      def eof?
        file.eof?
      end
    end

    class Base
      include Compat
    end
  end
end
