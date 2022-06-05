class RequestMailer < ApplicationMailer

  default from: 'test@gmail.com'

  def send_mail(to, type, word, category, results)
    @type = type
    @word = word
    @category = category
    @results = results

    mail(to: to, subject: 'Chuck Facts')
  end
end
