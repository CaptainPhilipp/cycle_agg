# frozen_string_literal: true

module YandexML
  class Offers < Collection
    alias offers list
    alias shop parent_object

    private

    def elements_type
      'offer'
    end

    def elements_wrapper
      YandexML::Offer
    end
  end
end
