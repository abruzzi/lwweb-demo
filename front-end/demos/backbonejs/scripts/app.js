var Book = Backbone.Model.extend({
	defaults: {
		name: 'Notitle',
		author: 'Nobody',
		keywords: []
	}
});

var Books = Backbone.Collection.extend({
	model: Book,
	url: "/books"
});



var BooksView = Backbone.View.extend({
	tagName: "ul",

	className: "media-list",

	initialize: function() {
		this.render();
	},

	render: function() {
		var view;
		this.collection.forEach(function(book) {
			view = new BookView({model: book});
			this.$el.append(view.el);
		}, this);
	}
}); 

var BookView = Backbone.View.extend({
	tagName: "li",

	className: "media",

	tmpl: _.template($('#book-template').html()),

	initialize: function() {
		this.render();
	},

	render: function() {
		this.$el.html(this.tmpl(this.model.attributes));
		return this;
	}
});

var AboutView = Backbone.View.extend({
	el: "#about",
	tmpl: _.template($('#about-template').html()),
	
	initialize: function() {
		this.render();
	},

	render: function() {
		this.$el.html(this.tmpl());
		return this;
	}
});

var BookRouter = Backbone.Router.extend({
	routes: {
		"": "books",
		"about": "about",
		"search/:query": "search"		
	},

	books: function() {
		var books = new Books();
		books.fetch({
			success: function(books) {
				var view = new BooksView({
					collection: books
				});

				$("#about").hide();
				$("#books").html(view.el).show();				
			}
		});
	},

	about: function() {
		var view = new AboutView();

		$("#books").hide();
		$("#about").show();
	},

	search: function(query) {
		console.log(query);
	}
});


$(function() {	
	var bookRouter = new BookRouter();
	Backbone.history.start();
});