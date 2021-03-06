# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( upload_files/indicator.js )
Rails.application.config.assets.precompile += %w( home.js )

Rails.application.config.assets.precompile += %w( employers.css )
Rails.application.config.assets.precompile += %w( employers.js )

Rails.application.config.assets.precompile += %w( upload_files.css )

Rails.application.config.assets.precompile += %w( departments.js )
Rails.application.config.assets.precompile += %w( departments.css )

Rails.application.config.assets.precompile += %w( loans.js )
Rails.application.config.assets.precompile += %w( loans.css.scss )

Rails.application.config.assets.precompile += %w( dashboard.js )
Rails.application.config.assets.precompile += %w( dashboard.css.scss )

Rails.application.config.assets.precompile += %w( reports.js )
Rails.application.config.assets.precompile += %w( reports.css.scss )

Rails.application.config.assets.precompile += %w( clients.js )
Rails.application.config.assets.precompile += %w( clients.css.scss )

Rails.application.config.assets.precompile += %w( providers.js )
Rails.application.config.assets.precompile += %w( providers.css.scss )

Rails.application.config.assets.precompile += %w( accounts.js )
Rails.application.config.assets.precompile += %w( accounts.css.scss )

Rails.application.config.assets.precompile += %w( accountancy_reports.js )
Rails.application.config.assets.precompile += %w( accountancy_reports.css.scss )
