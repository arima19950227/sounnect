class Review < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum sauna_area: { small: 0, usually: 1, wide: 2 }, _prefix: true
  enum sauna_temperature: { cold: 0, mild: 1, usually: 2, hot:3 }, _prefix: true
  enum loryu_type: { auto: 0, normal: 1, nothing: 2 }, _prefix: true
  enum aufguss: { having: 0, nothing: 1 }, _prefix: true
  enum water_temperature: { hot: 0, usually: 1, cold: 2 }, _prefix: true
  enum water_area: { small: 0, usually: 1, wide: 2 }, _prefix: true
  enum chair_count: { few: 0, usually: 1, many: 2 }, _prefix: true
  enum sauna_time: { weekdaymorning: 0, weekdaynoon: 1, weekdaynight: 2, holidaymorning: 3, holidaynoon: 4, holidaynight: 5 }, _prefix: true
  enum congestion: { veryfew: 0, few: 1, usually: 2, many: 3, verymany: 4 }, _prefix: true

end
