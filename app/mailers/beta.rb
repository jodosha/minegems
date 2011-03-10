class Beta < ActionMailer::Base
  default :from         => "no-reply@minege.ms",
          :content_type => "text/html"

  def registration_code(beta)
    @beta = beta

    mail({
      :to => beta.email,
      :subject => "[minegems] Registration code"
    })
  end
end
