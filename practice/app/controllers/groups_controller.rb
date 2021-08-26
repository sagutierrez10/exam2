class GroupsController < ApplicationController
  def index
    @user= User.find(session[:user_id])
    @groups= Group.all
    # @group = Group.find(params[:id])
  end
  def show
    @group = Group.find(params[:id])
    @users_joined = @group.users_joined
    @user_has_joined = @group.users_joined.include?(current_user)
    if @user_has_joined
      @join_id = Join.all.where(user_id: current_user.id, group_id: @group.id).first.id
    end
    @group_owner_text = "#{@group.user.first_name} #{@group.user.last_name}"
    if @group.user_id == current_user.id
      @group_owner_text = 'YOU'
    end

  end

  def create
    @group = Group.create(group_params)
    if @group.save
      Join.create(group: @group, user: current_user)
      redirect_to :back
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @this_group = Group.find_by(id: params[:id])
    if current_user == @this_group.user
      @this_group.destroy
      return redirect_to :back
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :description, :user_id)
  end

end
