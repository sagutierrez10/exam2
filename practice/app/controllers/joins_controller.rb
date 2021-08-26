class JoinsController < ApplicationController
  def create
    @join_group = Join.create(group: Group.find(params[:group_id]), user: current_user)
    if @join_group.valid?
      redirect_to :back
    end
  end

  def destroy
    @this_join = Join.find(params[:id])
    if @this_join
      @this_join.destroy
      redirect_to :back
    end
  end
end
