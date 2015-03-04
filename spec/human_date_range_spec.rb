require 'spec_helper'
describe HumanDateRange do
  before(:all) do
    @format     = "%d-%m-%Y"
    @language   = :russian
    @dates      = {
      russian: {
        "сегодня" => Date.today.strftime(@format),
        "завтра"  => ( Date.today + 1 ).strftime(@format),
        "С 1 мая по 3 мая" => [ "01-05-2015", "02-05-2015", "03-05-2015"]
      }
    }
  end

  it "parses required formats" do
    @dates[@language].each do |date,expected|
      expect(HumanDateRange.parse(date)).to eq expected
    end
  end
end