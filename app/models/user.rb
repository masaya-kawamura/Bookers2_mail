class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :name,  presence: true, uniqueness: true, length: {minimum: 2, maximum: 20 }
    validates :email, presence: true
    validates :introduction, length: {maximum: 50}

    has_many :books, dependent: :destroy

    attachment :profile_image
    
    # 都道府県コードから当道府県名に自動で変換する。
    include JpPrefecture
    jp_prefecture :prefecture_code
    
    # ~.prefecture_nameで都道府県名を参照できるようにする。
    # @user.prefecture_nameで該当ユーザーの住所（都道府県）を表示できる。
    def prefecture_name
      JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
    end
    
    def prefecture_name=(prefecture_name)
      self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end
    
end
