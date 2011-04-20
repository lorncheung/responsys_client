module SunDawg
  module Responsys
    class User
      attr_accessor :attributes

      @@fields = []

      def initialize
        @attributes = {}
      end

      def values
        a = []
        @@fields.each do |field|
          a << attributes[field]
        end 
        a
      end

      class << self
        attr_reader :fields

        def clear_fields!
          @@fields.clear
        end

        def responsys_fields
          @@fields.map do |i|
            to_responsys_field(i)
          end
        end

        def add_field (f)
          @@fields << f

          define_method f do
            attributes[f]
          end 

          define_method to_responsys_field(f) do
            attributes[f]
          end
      
          define_method "#{f}=" do |v|
            attributes[f] = v
          end
        end

        protected

        # Turns all field attribute names into Responsys uppercase with _ i.e. foo => FOO_
        def to_responsys_field(s)
          s.to_s.upcase + "_"
        end
      end
    end
  end
end
