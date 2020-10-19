class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :book_comments, dependent: :destroy
         has_many :relationships
         has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
         has_many :followings, through: :active_relationships, source: :follower
         has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
         has_many :followers, through: :passive_relationships, source: :following

         #ユーザーをフォローする
         def follow(other_user)
            unless self == other_user
                self.relationships.find_or_create_by(follow_id: other_user.id)
            end
        end

        #ユーザーのフォローを解除する
        def unfollow(other_user)
            relationship = self.relationships.find_by(follow_id: other_user.id)
            relationship.destroy if relationship
        end

        #すでにフォロー済みであればtrueを返す
        def following?(other_user)
            self.followings.include?(other_user)
        end

         def followed_by?(user)
            # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
            passive_relationships.find_by(following_id: user.id).present?
         end


         attachment :profile_image, destroy: false

         validates :name, presence: true, uniqueness: true,
                            length: {minimum: 2,maximum: 20}

         validates :introduction, length: {maximum: 50}

end
