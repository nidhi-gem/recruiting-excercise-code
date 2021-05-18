require 'open-uri'

class Exchangeable
  def initialize(params)
    @params = params
  end

  def retrieve_exchange_rate
    doc = Nokogiri::XML(URI.open(eurofxref_url)).remove_namespaces!
    doc.xpath('//Cube/Cube').first.children.each do |cube|
      currency = @params[:currency]
      @values = currency_value(currency, cube)
      break if @values.present?
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

  private

  def eurofxref_url
    'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  end
end
