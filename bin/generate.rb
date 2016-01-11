require 'erb'
require 'logger'

$logger = Logger.new(STDERR)

class Headers
  def initialize(source)
    @headers = source[%r{// (.*) \( (.*?) \)\n#pragma pack\( push, 1 \)}, 2].split(',')
  end

  def to_ruby
    @headers.join(', ')
  end

  HEADTYPE_REGEXP = /^HEADTYPE=(.*?)$/

  def type_
    @headers.find { |header| header =~ HEADTYPE_REGEXP }
  end

  def type
    type_[HEADTYPE_REGEXP, 1]
  end
end

module StructureToRuby
  attr_reader :name

  def to_ruby
    <<-EOS
  class #{name} < Struct
    pack 1
    layout \\
#{@elements.map(&:to_ruby).map { |source| ' ' * 6 + source }.join("\n")}
      :eos, [:char, 0]

    def type
      @type ||= {
#{@elements.map(&:to_type).compact.map { |source| ' ' * 8 + source }.join(",\n")}
      }
    end
  end
    EOS
  end
end

class Structure
  include StructureToRuby

  class Element
    def self.list(source)
      source.split("\n").reject(&:empty?).map { |source_| new(source_) }
    end

    def initialize(source)
      @attr = source.match(
        %r{^\s*?char\s+?(?<name>\S+?)(?:\s+?\[\s*?(?<size>\d+?)\s*?\])?\s*?;\s*?(?:char\s+?(?<tname>\S+?)\s*?;)?\s*?//\s*?\[\s*?(?<ltype>\w+?)\s*?,\s*?(?<lsize>[\d\.]+?)\s*?\]\s*(?<desc>.+?)\s*?StartPos}
        )
    end

    def tvar
      return unless @attr[:tname]
      " :#{@attr[:tname]}, :char,"
    end

    def to_ruby
      ":#{@attr[:name]}, [:char, #{@attr[:size]}],#{tvar} \# #{@attr[:ltype]}, #{@attr[:lsize]}, #{@attr[:desc]}"
    end

    def to_type
      "#{@attr[:name]}: {type: :#{@attr[:ltype]}, size: '#{@attr[:lsize]}'}"
    end
  end

  def initialize(source)
    attributes = source.match(/typedef struct\s+?(?<name>\S+?)\s*?\{(?<elements>.*?)\}/m)
    @name = "STRUCT#{attributes[:name]}"
    @elements = Element.list(attributes[:elements])
  end
end

class MergedStructure
  include StructureToRuby

  class Element
    def self.list(names)
      names.map { |name| new(name) }
    end

    def initialize(name)
      @name = name
    end

    def to_ruby
      ":#{@name}, #{@name},"
    end

    def to_type
      "#{@name}: {type: :struct}"
    end
  end

  SMALL_BLOCK_REGEXP = /^(.*?Block)\d+$/

  def self.list(names)
    if names.any? { |name| name !~ SMALL_BLOCK_REGEXP }
      $logger.warn { "type: #{type}, names: #{names}" }
    end
    names.group_by { |name| name[SMALL_BLOCK_REGEXP, 1] }
      .reject { |k, _| k.nil? }
      .map { |name, elements| new(name, elements) }
  end

  def initialize(name, names)
    @name = name
    @elements = Element.list(names)
  end
end

class Source
  def initialize(filename)
    source = File.read(filename, encoding: 'cp949').encode('utf-8')
    @headers = Headers.new(source)

    @struct_list = source.scan(/typedef struct\s+?\S+?\s*?\{.*?\}/m).map do |source_|
      Structure.new(source_)
    end
  end

  def struct_names
    @struct_list.map(&:name)
  end

  def merge?
    case @headers.type
    when 'A'
      false
    when 'B'
      true
    else
      $logger.warn { "type: #{type}" }
      false
    end
  end

  def merged_struct_list
    merge? ? MergedStructure.list(struct_names) : []
  end

  def to_ruby
    <<-EOS
require 'ffi'

\# #{@headers.to_ruby}
module XingAPI
#{@struct_list.map(&:to_ruby).join("\n")}
#{merged_struct_list.map(&:to_ruby).join("\n")}
end
    EOS
  end
end

Dir['src/*.h'].each do |filename|
  source = Source.new(filename)

  basename = File.basename(filename, '.h')
  output = "lib/xingAPI/data/#{basename}.rb"
  open(output, 'w', encoding: 'utf-8') { |f| f.puts source.to_ruby }
  puts "#{output} generated."
end