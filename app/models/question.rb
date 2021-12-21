class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30}
  validates :content, presence: true
  validate :validate_name_not_including_comma

  belongs_to :user
  has_many :answers, dependent: :destroy

  scope :recent, -> {order(created_at: :desc)}

  #ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end
  def self.ransackable_associations(auth_object = nil)
    []
  end

  private
    def validate_name_not_including_comma
      errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
    end
end
