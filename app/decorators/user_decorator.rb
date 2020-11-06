# frozen_string_literal: true

module UserDecorator


  def avatar_image
    if current_user&.avatar&.attached?
      current_user.avatar
    else
      '頭のアイコン.png'
    end
  end



end
