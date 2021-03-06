class ToysController < ApplicationController
  def index
    # /cats/:cat_id/toys
    cat = Cat.find(params[:cat_id])
    # This i part of it being a nested resource,
    # This way we first find the cat object from the params
    # and the render the toys in that object instead of the 
    # simple Toy.all as before 
    render json: cat.toys

  end

  def show
    # /toys/:id
    render json: Toy.find(self.params[:id])
    # This also work for nested resources. So it would work for a path like this:
    # /cats/:cat_id/toys/:id
  end

  def destroy
    # /toys/:id
    toy = Toy.find(params[:id])
    toy.destroy
    render json: toy
  end

  def update
    # /toys/:id
    toy = Toy.find(params[:id])

    success = toy.update(self.toy_params)
    if success
      render json: toy
    else
      render json: toy.errors.full_messages, status: :unprocessable_entity
    end
  end

  def create
    # POST /toys

    # Strong Parameters
    # self.params => Parameters < HashWithIndifferentAccess < Hash
    @toy = Toy.new(self.toy_params)
    @cat = @toy.cat

    if @toy.save
      redirect_to cat_url(@cat)
    else
      render :new
      # render json: toy.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @cat = Cat.find(params[:cat_id])
    @toy = Toy.new
    render :new
  end

  protected
  # we creat this method in order to keep the code dry 
  # it makes sense in most cases to be able to both create and update
  # the same attributes. This way we dry the code. 
  def toy_params
    self.params[:toy].permit(:cat_id, :name, :ttype)
    #self.params returns an object of type Paramters(HashWithDifferentAccess < Hash)
    # Like hash with some extra stuff
    # permit whitelist whitelist the attributes given so that ActiveRecord will set them 
    # when I mass assign. 
    # This method makes it so that only those things in my permit method 
    # can be updated 
  end
end
          