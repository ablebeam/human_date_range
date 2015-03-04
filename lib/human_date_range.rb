require 'date'
require 'unicode'

require "human_date_range/version"
require "human_date_range/parser"

module HumanDateRange
  def self.parse(string, language=:russian, format="%d-%m-%Y")
    Parser.new(string, language, format).parse
  end
end
