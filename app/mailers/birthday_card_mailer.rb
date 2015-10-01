#encoding: utf-8
require 'RMagick'
include Magick

class BirthdayCardMailer < ActionMailer::Base
  default from: "cimav@cimav.edu.mx"


  def birthday_card(user)
    @user = user
    @from = "CIMAV <cimav@cimav.edu.mx>"
    @to = @user.email
    subject = "¡Feliz cumpleaños!"
    reply_to = @from

    mes = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    
    #create card file
    cardtpl = "#{Rails.root}/private/birthday-card/card.png"
    cardfile = "#{Rails.root}/private/birthday-card/card_#{@user.username}.png"
    msg1 = "#{@user.alias}"
    msg2_1 = "Te deseamos el mejor" 
    msg2_2 = "         de los días"
    msg3 = "¡Muchas felicidades!"
    msg4 = "#{mes[@user.birth_date.month - 1]} #{Time.now.year}"
    img = ImageList.new(cardtpl)
    
    txt1 = Draw.new
    img.annotate(txt1, 0,0,350,100, msg1){
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 35
      self.fill = '#d2681a'
      self.font_family = "Arial"
      self.font_weight = Magick::BoldWeight
    }
    txt2_1 = Draw.new
    img.annotate(txt2_1, 0,0,350,180, msg2_1){
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 35
      self.fill = '#325487'
      self.font_family = "Arial"
      self.font_weight = Magick::BoldWeight
    }
    txt2_2 = Draw.new
    img.annotate(txt2_1, 0,0,350,230, msg2_2){
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 35
      self.fill = '#325487'
      self.font_family = "Arial"
      self.font_weight = Magick::BoldWeight
    }
    txt3 = Draw.new
    img.annotate(txt3, 0,0,350,300, msg3){
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 35
      self.fill = '#d2681a'
      self.font_family = "Arial"
      self.font_weight = Magick::BoldWeight
    }
    txt4 = Draw.new
    img.annotate(txt3, 0,0,480,380, msg4){
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 25
      self.fill = '#325487'
      self.font_family = "Arial"
      self.font_weight = Magick::NormalWeight
    }
    img.write cardfile

    attachments.inline['card.png'] = File.read(cardfile)
    puts "Tarjeta para: #{@to}"
    if mail(:to => @to, :from => @to, :reply_to => reply_to, :subject => subject)
      puts "OK"
    else 
      puts "Fallo"
    end
  end

end
