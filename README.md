## README
With this app you can fetch information about movies stored in ["The Movie Database - registration required"](https://developer.themoviedb.org/reference/search-movie). The subscription limits how many requests we are allowed to send to "The Movie Database". To reduce the number of requests directly sent to the database this app stores the response information for a while and serves the requested information from it's store. Using this app please subscribe  to ["The Movie Database - registration required"](https://developer.themoviedb.org/reference/search-movie).
### Installation
* Clone this repo.
* Install required ruby and bundler.
* Run bundle install in the project directory.
* Pleas provide your subscripton's "API READ ACCESS TOKEN" to credentials.yml.enc file.
* You can edit credentials.yml.enc with:
> `EDITOR=nano rails credentials:edit`
* You can choose any other editor.
* Please add your token under `api_read_access_token:`:
> `api_read_access_token: [your private API READ ACCESS TOKEN]`
* Run the rails server from the project directory:
> `bundle exec rails server`
* You can reach the app in a browser at `http://localhost:3000/`
### Usage
Provide keywords in the text box and then click the 'Search' button. You are informed, that the request is provided by the store or the 3rd party API. The movies of the search result are listed in cards. You can find the title, an overview and a poster image about each movie.
### Test
You can run test by:
> `bundle exec rails test`
### Personal motivation
I decided using cache for solving this problem. Since Movie Database stores data, it is not neccessary to store data permanently in this project, that's why I did not add databse to the project.

Rails.cache is a great tool for this purpose. It stores data you put into the cache. After expiration it frees store. If the store runs out of the space it frees space automatically.
### Further improvements
* Worth considering if a cached page expires, all related cached pages with same search keywords should be deleted from cache store.
* The Movie Database API provides many other possibilities besides searching in titles. Generalize `Communicator` and then spezialize for each and every API endpoints expands our possibilities.
* Adding database
* Creating User model for storing personal preferences
* Handling authentication

