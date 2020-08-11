class BooksController < ApplicationController

  before_action :user_check, only: [:update, :edit]

  def new
    @book = Book.new
  end


  def index
    @user = current_user
    
  	@book = Book.new
  	@books = Book.all
  end

  def show
  	
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = @book_show.user
  end

  def create
  	     @book = Book.new(book_params)
         @book.user_id = current_user.id
        if @book.save
         redirect_to book_path(@book.id), notice: 'You have creatad book successfully.'
        else
          @user = current_user
          @books = Book.all
          render :index
        end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	   redirect_to book_path(@book.id), notice:'You have updated book successfully.'
    else
      render :edit
    end

  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end

  private
    def book_params
    	params.require(:book).permit(:title, :body)
    end

    def user_check
      @book = Book.find(params[:id])      # b_instance / u_instance
      if @book.user_id != current_user.id # b_instance.user_id == u_instance.id
      # if @book.user == current_user       # b_instance.u_instance == u_instance
      # if @book.user.id == current_user.id # b_instance.u_instance.id == u_instance
      
      
        redirect_to books_path
      end
    end
end
