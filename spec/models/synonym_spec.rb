require 'rails_helper'

RSpec.describe Synonym, type: :model do
  it { should belong_to :owner }
end
