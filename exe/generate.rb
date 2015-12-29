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
  class STRUCT<%= name %> < Struct
    pack 1
    layout \\
    <% struct.map do |name, size| %>
      :<%= name %>, [:char, <%= size || 1 %>],
    <% end %>
      :eos, [:char, 0]
  end
<% end %>
end
  EOS

  basename = File.basename(filename, '.h')
  output = "lib/xingAPI/data/#{basename}.rb"
  open(output, 'w') { |f| f.puts result }
  puts "#{output} generated."
end