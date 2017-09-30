module HasShortTitle
  extend ActiveSupport::Concern

  included do
    before_save :change_short_title
  end

  private

  def change_short_title
    return unless short_title.nil?
    self.short_title = en_title.downcase.gsub(/\sand\s/, '-n-').tr(' ', '-')
  end
end
