# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "cytoscape" # @3.30.3
pin "graph/cytoscape", to: "graph/cytoscape.js"
pin "graph/click_node", to: "graph/click_node.js"
pin "calculation/distance", to: "calculation/distance.js"
