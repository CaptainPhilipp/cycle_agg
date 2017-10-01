require_relative 'abstract/page_object'

class NewPricelistPage
  include PageObject

  file_field :attachment, id: :pricelist_attachment, name: 'pricelist[attachment]'
  submit 'Upload pricelist'
end
