# frozen_string_literal: true

module YandexML
  class Offer < Element
    # https://yandex.ru/support/partnermarket/offers.html

    # for simple description
    str_attributes 'group_id' # only in YML
    str_parameters 'name',
                   'model',
                   'vendor',
                   'vendorCode'

    # standart
    str_attributes 'id'
    int_attributes 'cbid',
                   'bid',
                   'fee'

    str_parameters 'url',
                   'currencyId',
                   'categoryId', # only in YML
                   'picture',
                   'description', # only in YML
                   'sales_notes',
                   'country_of_origin',
                   'expiry',
                   'weight',
                   'dimensions',
                   'rec' # only in YML
    int_parameters 'price', # for check `<price from="true">` use #price_from?
                   'oldprice',
                   'outlets' # only in YML
    #              'local_delivery_days', # only in CSV
    #              'local_delivery_cost', # only in CSV
    bool_parameters nil,
                    'manufacturer_warranty',
                    'adult',
                    'downloadable'
    bool_parameters true,
                    'available',
                    'delivery',
                    'pickup',
                    'store'

    # <price from="true">
    def price_from?
      string_to_bool(children_by_name('price').str_attributes['from'], false)
    end

    def age
      # TODO: unit="year": 0, 6, 12, 16, 18; unit="month": 0..12
    end

    def barcodes
      # TODO: В YML элемент offer может содержать несколько элементов barcode
    end

    def min_quantity
      value = parameter('min-quantity').to_i || 1
      value.positive? ? value : 1
    end

    def params
      # TODO: В YML элемент offer может содержать несколько элементов param (один элемент param — одна характеристика).
    end

    def money
      @money ||= YandexML::Money.new(self, currency)
    end

    def currency
      shop.currencies[category_id]
    end

    def category
      # TODO: release for CSV (as attribute)
      shop.categories[category_id]
    end

    def category_id_type
      children_by_name('categoryId').str_attributes['type']
    end

    # only in YML
    def delivery_options
      @delivery_options ||=
        YandexML::DeliveryOptions.new(childrens_by_name('delivery-options'), self)
    end

    def shop
      offers_collection.shop
    end

    alias offers_collection parent_object
  end
end
