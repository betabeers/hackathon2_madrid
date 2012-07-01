class InviteMailer < ActionMailer::Base
  default from: "agrouper@itram.es"

   def invite_email(mail,order)
    @mail = mail
    @url  = url_for :controller => :order, :action => :join, :id => order, :only_path => true
    mail(:to => mail, :subject => "Te han invitado a una compra en grupo en Agrouper!")
  end

end
