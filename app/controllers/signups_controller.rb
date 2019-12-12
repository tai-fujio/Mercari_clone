class SignupsController < ApplicationController
  before_action :save_to_session, only: :sms_confirmation
  # before_action :save_to_session2, only: :address


  def new

  end

  def registration
    @user = User.new
  end

  def sms_confirmation
    @user = User.new
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
  end

  def address
    @address = Address.new
    @user = User.new
    session[:phonenumber] = user_params[:phonenumber]
  end

  def payment_method
    @address = Address.new
    @user = User.new

    session[:postal_code] = address_params[:postal_code]
    session[:prefecture] = address_params[:prefecture]
    session[:city] = address_params[:city]
    session[:street] = address_params[:street]
    session[:building] = address_params[:building]

  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: session[:phonenumber]
    )
    if @user.save
      @address = Address.new(
        postal_code: session[:postal_code],
        prefecture: session[:prefecture],
        city: session[:city],
        street: session[:street],
        building: session[:building]
      )

      
      
       if @address.save
          session[:id] = @user.id
          redirect_to complete_signups_path
       else
          
           redirect_to root_path
       end    
    else
      render '/signups/registration'
    end
  end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

end

def save_to_session
  session[:nickname] = user_params[:nickname]
  session[:email] = user_params[:email]
  session[:password] = user_params[:password]
  session[:last_name] = user_params[:last_name]
  session[:first_name] = user_params[:first_name]
  session[:last_name_kana] = user_params[:last_name_kana]
  session[:first_name_kana] = user_params[:first_name_kana]
  session[:birthday_year] = user_params[:birthday_year]
  session[:birthday_month] = user_params[:birthday_month]
  session[:birthday_day] = user_params[:birthday_day]

  @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    password: session[:password],
    last_name: session[:last_name],
    first_name: session[:first_name],
    last_name_kana: session[:last_name_kana],
    first_name_kana: session[:first_name_kana],
    birthday_year: session[:birthday_year],
    birthday_month: session[:birthday_month],
    birthday_day: session[:birthday_day],
  )
  redirect_to registration_signups_path unless @user.valid?
end

# def save_to_session2
#   session[:phonenumber] = user_params[:phonenumber]

#   @user = User.new(
#     phonenumber: session[:phonenumber]
#   )
#   redirect_to sms_confirmation_signups_path unless @user.valid?
# end


private

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :phonenumber,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday_year,
      :birthday_month,
      :birthday_day
    )
  end
  def address_params
    
    params.require(:address).permit(
      :postal_code,
      :prefecture,
      :city,
      :street,
      :building
    )
  end
