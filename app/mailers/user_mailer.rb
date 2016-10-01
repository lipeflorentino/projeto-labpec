class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "LABPEC - Ativar sua conta."
  end
  
  def update_activation(user)
    @user = user
    mail to: user.new_email, subject: "LABPEC - Aletração de e-mail."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: "LABPEC - Esqueceu sua senha?"
  end
end
