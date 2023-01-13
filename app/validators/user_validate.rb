# frozen_string_literal: true

class UserValidate < ActiveModel::Validators
  PASSWORD_REGEX = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"

  def validate record
    if record.encrypted_password.blank? && record.encrypted_password !~ PASSWORD_REGEX
      record.errors[:メールアドレスとパスワード] << " を入力してください。"
      end
  end
end
