
DojoRoot = "/assets/javascripts/dojo_root"

window.dojoConfig = {
    async: true
    baseUrl: ''
    tlmSiblingOfDojo: false
    isDebug: true
    packages: [
        { name: 'dojo',  location: "#{DojoRoot}/dojo" }
        { name: 'dijit', location: "#{DojoRoot}/dijit" }
        { name: 'dojox', location: "#{DojoRoot}/dojox"}
        { name: 'todo',   location: "/assets/javascripts" }
        { name: 'bootstrap', location: "/versioned/lib/bootstrap/js/" }
        { name: 'handlebars', location: "/versioned/lib/handlebars/" }
    ]
    deps: [ 'todo' ]
    callback: (todo) ->
      todo.init()
}