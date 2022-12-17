class User < ApplicationRecord

  has_one_attached :profile_image, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  #has_many :comment_favorites, dependent: :destroy
  # relationshipsはアソシエーションが繋がっているテーブル名、class_nameは実際のモデルの名前、foreign_keyは外部キーとして何を持つかを表している。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #一覧にフォロー、フォロワーの表示ができる、＠user.followeingsとすることで自分がフォローした人表示できる
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

   def active_for_authentication?
    super && (is_deleted == false)
   end

   # フォローしたときの処理
  def follow(user_id)
   relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
   relationships.find_by(followed_id: user_id).destroy
  end
# フォローしているか判定
  def following?(user)
   followings.include?(user)
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
    profile_image.attach(io: File.open(file_path), filename: 'no_image.jpeg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
 end

 def self.guest
  find_or_create_by!(email: 'test@test.com') do |user|
    user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    user.name = 'ゲストユーザー'
    user.phone_number = '12345678901'
   end
 end

  validates :name, presence: true
  validates :phone_number, presence: true, length: { is: 11 }, uniqueness: true, numericality: {only_integer: true}
  validates :introduction, length: { maximum: 200 }
  validates :profile_image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end