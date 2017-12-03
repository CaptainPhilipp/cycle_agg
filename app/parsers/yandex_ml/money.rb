# frozen_string_literal: true

module YandexML
  class Money
    RAW  = 'integer'
    CBRF = 'CBRF'
    NBU  = 'NBU'
    NBK  = 'NBK'
    CB   = 'CB'

    def initialize(offer, currency)
      @offer = offer
      @currency = currency
    end

    def price
      offer.price
    end

    def rate_type
      currency.rate.to_f.positive? ? RAW : currency.rate
    end

    def rate_by_rate_type(type)
      case type
      when CBRF then 1
      when NBU  then 1
      when NBK  then 1
      when CB   then 1
      end
    end
  end
end
