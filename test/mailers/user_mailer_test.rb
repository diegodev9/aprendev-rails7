require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.last
  end

  test "welcome" do
    mail = UserMailer.with(user: @user).welcome
    assert_equal "Bienvenido a CompraVenta", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["no-reply@compraventa.com"], mail.from
    assert_match "Hola #{@user.username}, bienvenido a CompraVenta. Esperamos que vendas mucho", mail.body.encoded
  end

end
