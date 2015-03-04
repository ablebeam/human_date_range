require "human_date_range/version"
require "human_date_range/parser"

module HumanDateRange
  def self.parse(string, language=nil, format=nil)
    Parser.new(string, language, format).parse
  end
end
