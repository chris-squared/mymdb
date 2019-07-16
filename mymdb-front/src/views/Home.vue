<template>
  <v-content>
    <v-layout row>
      <v-flex xs6 px-3 mx-3 pt-5 style="height: 100%">
        <span style="font-size: 28px"> NEED TO SEE </span>
        <category
          :length="getNotSeen.length"
          @search="createMovie">         
          <template v-slot:data>
            <movie class="pt-2" v-for="(movie) in getNotSeen" :key="movie.id"
              :movie="movie"
              
              @delete="deleteMovie"
              @update="updateMovie"/>
            </template>
          </category>
      </v-flex>
      <v-flex xs6 px-3 mx-3 pt-5 style=" height: 100%; "> 
        <span style="font-size: 28px"> SEEN </span>
        <v-layout pb-5 row style="width: 100% !important">  
          <category 
            :length="getSeen.length"
            seen
            @search="createMovie">
              <template v-slot:data>
                <movie class="pt-2" v-for="(movie) in getSeen" :key="movie.id"
                    :movie="movie"
                    @delete="deleteMovie"
                    @update="updateMovie"/>
              </template>
          </category>
        </v-layout>
        <span style="font-size: 28px"> FAVORITES </span>
        <v-layout row style="width: 100%">
          <category
           :length="getFavorites.length"
           seen
           favorite
           @search="createMovie">
              <template v-slot:data>
                 <movie class="pt-2" v-for="(movie) in getFavorites" :key="movie.id"
                    :movie="movie"
                    @delete="deleteMovie"
                    @update="updateMovie"/>
              </template>
          </category>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-content>
</template>

<script>
import movie from '../components/MovieCard.vue';
import category from '../components/Category.vue';
import axios from 'axios'
  export default{
    computed: {
      //TODO: Clean this up -- see if I can't use the Rails API For it; right now I don't think an update there will call computed functions, but maybe Vuex store?
      getSeen(){
        var seen = []
        if(this.movies)
          for (var i = 0; i < this.movies.length; i++)
            if (this.movies[i].seen)
              seen.push(this.movies[i])
        return seen
      },
      getNotSeen(){
        var notseen = []
        if(this.movies)
          for (var i = 0; i < this.movies.length; i++)
            if (!this.movies[i].seen)
              notseen.push(this.movies[i])
        return notseen
      },
      getFavorites(){
       var favorites = []
       if(this.movies)
          for (var i = 0; i < this.movies.length; i++)
            if (this.movies[i].favorite)
              favorites.push(this.movies[i])
       return favorites
      }
    },
    components: {
      movie,
      category,
    },
    data(){
      return {
        movies: [],
      }
    },
    mounted(){
      this.getMovies();
    },
    methods: {
      getMovies(){
        console.log('GETTIN');
        axios.get('http://localhost:3000/movies').then((response) => {
          console.log(response.data);
          this.movies = response.data
        })
      },
      deleteMovie(id){
        axios.delete('http://localhost:3000/movies/'+id).then((response) => {
        }).catch((error) => {
          console.log(error);
        });
       setTimeout(() => {this.getMovies()}, 100); 
       },
      updateMovie(id, seen, favorite){
        axios.put('http://localhost:3000/movies/'+id, {
          seen: seen, 
          favorite: favorite
        }).then((response) => {
          console.log(response);
        }).catch((error) => {
          console.log(error);
        })
        setTimeout(() => {this.getMovies()}, 100);
      },
      createMovie(search, seen, favorite){
        console.log('HERE');
        axios.post('http://localhost:3000/movies', {
            title: search,
            seen: seen,
            favorite: favorite,
        }).then((response) => {
            console.log(response)
            this.movies.push(response.data);
          }).catch((error) => {
            console.log(error);
          })
      },
    },
  }

</script>