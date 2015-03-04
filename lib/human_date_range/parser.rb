module HumanDateRange
  class Parser
    # Порядок имеет значение
    NORMALIZERS = {
      russian: {
        /(января|январь|янв\.?|янвр\.?)/        => 'Jan',
        /(ферваль|февраля|фев\.?|февр\.?)/      => 'Feb',
        /(марта|март|мар\.?|март\.?)/           => 'Mar',
        /(апрель|апреля|апр\.?)/                => 'Apr',
        /(май|мая|май\.?)/                      => 'May',
        /(июнь|июня|июн\.?)/                    => 'Jun',
        /(июль|июля|июл\.?)/                    => 'Jul',
        /(августа|август|авг\.?)/               => 'Aug',
        /(сентябрь|сентября|сен\.?)/            => 'Sep',
        /(октябрь|октября|окт\.?)/              => 'Oct',
        /(ноябрь|ноября|ноя\.?)/                => 'Nov',
        /(декабрь|декабря|дек\.?)/              => 'Dec',
        /((в )?(\d\d\:\d\d))/                   => '',
        /\s(год|года)\s/                        => '',
        /\s(пнд|втр|срд|чтв|птц|сбт|вск)/       => '',
        /\s(пн|вт|ср|чт|пт|сб|вс)/              => '',
        /сегодня/                               => -> { Date.today.strftime("%d-%m-%Y") }.call ,
        /послезавтра/                           => -> { ( Date.today + 2 ).strftime("%d-%m-%Y") }.call ,
        /завтра/                                => -> { ( Date.today + 1 ).strftime("%d-%m-%Y") }.call ,
        /вчера/                                 => -> { ( Date.today - 1 ).strftime("%d-%m-%Y") }.call ,
        /с(?:о)?(.+)по(.+)/                     => '\1 - \2',
        /\s+/                                   => ' ',
        /[,|-]\s?+\z/                           => '',
        /(года|год|г)/                          => ''
      }
    }
    MONTHES_REGEXP = %w[jan feb mar apr may jun jul aug sep oct nov dec].join('|')

    def initialize(string, language=:russian, output_format="%d-%m-%Y")
      raise ArgumentError unless string.kind_of?(String)
      @string         = string
      @language       = language
      @output_format  = output_format
    end

    def parse
      normalize!
      begin
        perform(@string)
      rescue ArgumentError
        nil
      end
    end

    private

    def normalize!
      @string = Unicode.downcase(@string).strip
      NORMALIZERS[@language].each{ |k,v| @string.gsub!(k,v) }
      @string.strip
      @string = @string.split(',') if @string =~ /,/
    end

    # Здесь основная логика для специфичных случаев
    def perform( string )
      if string.kind_of?(Array)
         dates = []
         string.each{ |date| dates << perform(date) }
         dates.flatten.compact
      else
        case
        when string.match(/\A(\d{1,2}\.\d{1,2})\z/)
          # дд.мм
          # 12.03
          Date.parse("#{$1}.2015").strftime(@output_format)
        when string.match( /\A(\d{1,2})\s?+-\s?+(\d{1,2}) (#{MONTHES_REGEXP})\s?+(201[456])?\z/ )
          # дд-дд (мм) гг
          # 12-31 декабря 2015
          starts  = Date.parse("#$1 #$3 #$4")
          ends    = Date.parse("#$2 #$3 #$4")
          parse_range(starts, ends)
        when string.match( /(.*) - (.*)/ )
          # Дата - Дата
          # 1 декабря - 13 февраля 2016
          starts  = Date.parse(perform("#$1"))
          ends    = Date.parse(perform("#$2"))
          parse_range(starts, ends)
        else
          Date.parse(string).strftime(@output_format)
        end
      end
    end

    def parse_range( start_date, end_date )
      # Предполагаем, что дата начала указана для прошлого года,
      # если начало позже окончания.
      # Например, с 12 декабря по 1 февраля
      start_date  = start_date - 1.year if start_date > end_date
      (start_date..end_date).to_a.map{ |d| d.strftime(@output_format) }
    end

  end
end