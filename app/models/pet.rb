class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments

  validates :name, :species, :date_of_birth, :weight, :owner, presence: true
  validates :species, inclusion: { in: %w[dog cat rabbit bird reptile other] }
  validates :weight, numericality: { greater_than: 0 }

  validate :date_of_birth_cannot_be_in_future

  before_save :capitalize_name

  scope :by_species, ->(species) { where(species: species) }

  has_one_attached :photo

  validate :photo_validation
  
  private

  def date_of_birth_cannot_be_in_future
    return if date_of_birth.blank?

    errors.add(:date_of_birth, "cannot be in the future") if date_of_birth > Date.current
  end

  def capitalize_name
    self.name = name.to_s.capitalize
  end

  def photo_validation
    return unless photo.attached?

    unless photo.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:photo, "must be a JPEG, PNG, or WebP image")
    end

    if photo.byte_size > 5.megabytes
      errors.add(:photo, "must be less than 5 MB")
    end
  end

end