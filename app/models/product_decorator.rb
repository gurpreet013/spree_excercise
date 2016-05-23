Spree::Product.class_eval do

  validates :published_at, :publisher_id, presence: true, if: :published

  before_validation :set_published_at, if: :published_changed?

  scope :published, -> {where(published: true)}

  def self.active(currency = nil)
    published.not_deleted.available(nil, currency)
  end

  protected

    def set_published_at
      self.published_at = published ? DateTime.current : nil
    end

end
