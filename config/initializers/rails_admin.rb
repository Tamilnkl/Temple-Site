RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = ["Image"]

  config.model 'Image' do
    exclude_fields :images

    configure :image_type do
      partial "image_type"
    end

    field :image do
      label "Select Parent image"
      associated_collection_cache_all false  # REQUIRED if you want to SORT the list as below
      associated_collection_scope do
        # bindings[:object] & bindings[:controller] are available, but not in scope's block!
        image = bindings[:object]
        Proc.new { |scope|
          # scoping all Players currently, let's limit them to the team's league
          # Be sure to limit if there are a lot of Players and order them by position
          scope = scope.eligible_parent("sivanmalai","person")
        }
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
