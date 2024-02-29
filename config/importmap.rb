# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "tailwindcss-stimulus-components" # @4.0.4
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
# pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin_all_from "app/javascript/controllers", under: "controllers"