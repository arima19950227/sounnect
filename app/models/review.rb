class Review < ApplicationRecord

  has_one_attached :sauna_image, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  #has_many :comment_favorite, dependent: :destroy

  enum sauna_area: { small: 0, usually: 1, wide: 2 }, _prefix: true
  enum sauna_temperature: { cold: 0, mild: 1, usually: 2, hot:3 }, _prefix: true
  enum loryu_type: { auto: 0, normal: 1, nothing: 2 }, _prefix: true
  enum aufguss: { having: 0, nothing: 1 }, _prefix: true
  enum water_temperature: { hot: 0, usually: 1, cold: 2 }, _prefix: true
  enum water_area: { small: 0, usually: 1, wide: 2 }, _prefix: true
  enum chair_count: { few: 0, usually: 1, many: 2 }, _prefix: true
  enum sauna_time: { weekdaymorning: 0, weekdaynoon: 1, weekdaynight: 2, holidaymorning: 3, holidaynoon: 4, holidaynight: 5 }, _prefix: true
  enum congestion: { veryfew: 0, few: 1, usually: 2, many: 3, verymany: 4 }, _prefix: true


   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
   end

  def get_sauna_image(width, height)
  unless sauna_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
    sauna_image.attach(io: File.open(file_path), filename: 'no_image.jpeg', content_type: 'image/jpeg')
  end
    sauna_image.variant(resize_to_limit: [width, height]).processed
  end

  validates :name, presence: true, length: { maximum: 30 }
  validates :address, presence: true
  validates :sauna_area, presence: true
  validates :sauna_temperature, presence: true
  validates :loryu_type, presence: true
  validates :aufguss, presence: true
  validates :water_temperature, presence: true
  validates :water_area, presence: true
  validates :chair_count, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validates :body, presence: true
  validates :sauna_time, presence: true
  validates :congestion, presence: true
  validates :sauna_image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
  validates :evaluation, presence:true

  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(evaluation: :desc)}
end
