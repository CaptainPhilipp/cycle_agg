class SportGroup < ApplicationRecord
  include HasShortTitle
  include HasManyChildsPolymorphic
end
