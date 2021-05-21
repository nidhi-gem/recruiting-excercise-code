require 'open-uri'

class Exchangeable < StandardError
  def initialize(params)
    @params = params
  end

  def retrieve_exchange_rate
    begin
      doc = Nokogiri::XML(URI.parse(Settings.eurofxref_url).open).remove_namespaces!
      doc.xpath('//Cube/Cube').first.children.each do |cube|
        currency = @params[:currency]
        @values = currency_value(currency, cube)
        break if @values.present?
      end
    rescue StandardError
      @values = 'API Exchange rate is unavailable'
    end
    @values
  end

  def currency_value(currency, cube)
    if currency == 'EUR'
      %w[EUR 1]
    elsif currency == cube.values.first
      cube.values
    end
  end
end
