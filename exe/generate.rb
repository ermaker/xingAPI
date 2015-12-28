require 'erb'

Dir['src/*.h'].each do |filename|
  source = File.read(filename, encoding: 'cp949')

  struct_list = source.scan(/typedef struct\s+?(\S+?)\s*?\{(.*?)\}/m).map do |name, struct|
    [
      name,
      struct.scan(/char\s+?(\S+?)(?:\s+?\[\s*?(\d+?)\s*?\])?\s*?;/)
    ]
  end

  result = ERB.new(<<-EOS, 0, '>').result(binding)
require 'ffi'

module XingAPI
<% struct_list.each do |name, struct| %>
  class STRUCT<%= name %> < FFI::Struct
    pack 1
    layout \\
    <% struct.map do |name, size| %>
      :<%= name %>, [:char, <%= size || 1 %>],
    <% end %>
      :eos, [:char, 0]

    def self.of(pointer)
      new(FFI::Pointer.new(pointer))
    end

    def members
      super.reject do |member|
        member.to_s.start_with?('_') || member == :eos
      end
    end

    def try_string(value)
      case value
      when FFI::StructLayout::CharArray
        value.to_ptr.read_string.force_encoding('cp949')
      else
        value
      end
    end

    def to_hash
      Hash[
        members.map do |m|
          v = self[m]
          v = try_string(v)
          [m, v]
        end
      ]
    end
  end
<% end %>
end
  EOS

  basename = File.basename(filename, '.h')
  output = "lib/xingAPI/data/#{basename}.rb"
  open(output, 'w') { |f| f.puts result }
  puts "#{output} generated."
end