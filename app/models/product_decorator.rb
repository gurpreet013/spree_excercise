Spree::Product.class_eval do

  ##Association
  belongs_to :publisher, class_name: Spree.user_class.to_s

  ##Validation
  validates :published_at, :publisher_id, presence: true, if: :published

  ##Callback
  before_validation :set_published_at, if: :published_changed?

  ##Scopes
  scope :published, -> { where(published: true) }

  def self.active(currency = nil)
    published.not_deleted.available(nil, currency)
  end

  protected

    def set_published_at
      self.published_at = published ? DateTime.current : nil
    end

end
