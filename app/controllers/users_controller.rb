class UsersController < ApplicationController
	before_action :ensure_correct_user, only: [:edit, :update]

	def index
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	def following
		@user = User.find(params[:id])
		@users = @user.following.all
	end

	def followers
		@user = User.find(params[:id])
		@users = @user.followers.all
	end

	def ensure_correct_user
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
end

