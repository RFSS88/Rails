IntroRailsVideoDemo::Application.routes.draw do
  resources :cats do
    # /cats/:cat_id/toys
    # note tha this is a nested resource 
    resources :toys, only: [:index, :new]
    # The way to think about what to put in Only is that
    # if we start with all the routes and the get rid of the ones that pertain
    # to only an individual toy.
    # those one will be deal with by the resources call that I'm doing next.
  end

  # /toys/:id
  resources :toys, only: [:create, :show, :update, :destroy] do
    # /toys/:id/memories
    # 2 levels deep
    # resources :memories, only: :index
  end

  root to: redirect("/cats")
end


#Note that it's ok to have routes from different resources go to the same controller
# In here both cats and toys resources are going to the toys_controller

# Remember never to nest thing more than 2 levels deep. Above there's an example
# of a 2 level deep nest cats > toys > memories
# note that we did the nesting in two separate steps and not all in one. 