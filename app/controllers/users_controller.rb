class UsersController < ApplicationController
  def index
    @contact = Contact.new 
  end

  def create
    @contact = Contact.new(message_params)
    @contact.request = request
    if @contact.deliver
      flash.now[:msg] = 'Thank you for your message. I will contact you shortly.'
    else 
      flash.now[:error] = 'Cannot send message. Please try again'
      render :index
    end 
  end 

  def download_pdf
  send_file(
    "#{Rails.root}/public/Jessica_Peng_Resume(2-10-15).pdf",
    filename: "Jessica_Peng_Resume(2-10-15).pdf",
    type: "application/pdf"
  )
  end


private
  def message_params
    params.require(:message).permit(:name, :email, :message, :nickname)
  end
end
