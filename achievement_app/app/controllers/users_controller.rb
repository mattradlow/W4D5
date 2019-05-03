class UsersController < ApplicationController 

    def new 
        @user = User.new
        render :new
    end 

    def create 
        @user = User.new(user_params)
        if @user.save
            # login!(@user)
            # redirect_to links_url
            return @user
        else
            flash[:errors] = @user.errors.full_messages 
            render :new 
            # debugger
        end 
    end 

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end 
