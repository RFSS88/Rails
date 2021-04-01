# instance variable in the controllers (ie @cats)
# The reason we make the instance variables, is so that they are
# accessible in the views file 

class CatsController < ApplicationController
  # before_action do
  #   return if session[:notice].nil?
  #   msg, flag = session[:notice]
  #   session[:notice] = [msg, false]
  # end
  #
  # after_action do
  #   return if session[:notice].nil?
  #   msg, flag = session[:notice]
  #   return if flag
  #   session[:notice] = nil
  # end

  def index
    # (GET /cats)
    # This is the method that will run when we make a GET request
    
    if params[:tag]
      @cats = Tag.find_by(name: params[:tag]).cats
    else
      @cats = Cat.all
    end
    render :index
    # Render is a method in ApplicationController
    # here render = .self render
    # we can use render jason: cats to output jason.
    # This way we're rendering the index file in views. 
    # params is a method from ApplicationController
    # It fetches the :id from the path in the request.  
  end




  def show
    # GET /cats/123
    @cat = Cat.find(params[:id])
    render :show
    # NOte that in this line we're not calling the show method.
    # if we did we would be in a infinite loop
    # :show in here is calling calling the show views template
  end

  # 1. GET Request for blank /cats/new form
  # 2. POST to /cats
  # 3. Validation fails
  # 4. Server render new template again.
  # 5. The form is filled in with @cat data

  
  
  
  
  def create
    # POST /cats
    # This is how we'd do with another method. Maybe HTML?? 
    # Content-Length: ...
    #
    # { "cat": { "name": "Sally" } }

    @cat = Cat.new(cat_params)

    if @cat.save
      # cat_url(@cat) == /cats/...
      flash[:notice] = "Created #{@cat.name}"
      redirect_to cat_url(@cat)
    else #very common mistake here is not use else here. We can render or redirect. Not both. 
      # redirect_to new_cat_url
      render :new

      # render json: @cat.errors.full_messages, status: :unprocessable_entity
      # This line here is a basic way of doing. We go on to create a more advanced
      # version of this. 
    end
  end
  # steps that are being taken to create the cat.
  # 1. GET /cats/new to fetch a form
  # 2. User fills out form, clicks submit.
  # 3. POST /cats the data in the form
  # 4. Create action is invoked, cat is created.
  # 5. Send client a redirect to /cats/#{id}
  # 6. Client makes a GET request for /cats/#{id}
  # 7. Show action for newly created cat is invoked.

  
  
  
  def new
    # /cats/new
    # show a form to create a new object
    @cat = Cat.new
    render :new
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end



  def edit
    # /cats/:id/edit
    # show a form to edit an existing object
    @cat = Cat.find(params[:id])
    render :edit
  end




  def destroy
    # DELETE /cats/:id
    cat = Cat.find(params[:id])
    cat.destroy
    # session[:notice] = ["Deleted #{cat.name}", true]
    flash[:notice] = "Deleted #{cat.name}"
    redirect_to cats_url


    # steps to destroy a cat:
    # 1. GET /cats
    # 2. Click delete button
    # 3. Sends POST /cats/123; but _method="DELETE" so rails understands
    #    to do a destroy
    # 4. Destroys the cat. Issues a redirect to the client.
    # 5. Client GETs /cats again.
  end

  private
  def cat_params
    params[:cat].permit(
      :name, :skill, :coat_color, :description, tag_ids: []
    )
  end
end
