class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :correct_user, only: [:update, :destroy]
  def index
    # @friends = Friend.all
    @friends = current_user.friends
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/news
  def new
    # @friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    # @friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    # @friend.destroy

    @friend = Friend.find(params[:id])
    @friend.destroy

    redirect_to friends_path, notice: "Friend was successfully removed from your list.", status: :see_other
  end

# def correct_user
#   @friend = correct_user.friends.find_by(id: params[:id])
# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
