<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>Vuetify</span>
        <span class="font-weight-light">MATERIAL DESIGN</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn
        flat
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>fas fa-external-link-alt</v-icon>
      </v-btn>
    </v-toolbar>

    <v-content>
      <v-layout row>
     <v-flex xs6 px-3 mx-3 pt-5 style="height: 100%">
       <category @search="createMovie">
         <template v-slot:header>
           NEED TO SEE
         </template>
         <template v-slot:data>
            <movie class="pt-2" v-for="(movie, idx) in getNotSeen" :key="movie.id"
                :movie="movie"
                :index="idx"
                @delete="deleteMovie"
                @update="updateMovie"/>
         </template>
       </category>
     
      
      
     </v-flex>
        <v-flex xs6 px-3 mx-3 pt-5 style=" height: 100%">
       <category
       seen
       @search="createMovie">
       <template v-slot:header>
         SEEN
       </template>
         <template v-slot:data>
            <movie class="pt-2" v-for="(movie) in getSeen" :key="movie.id"
                :movie="movie"
                @delete="deleteMovie"
                @update="updateMovie"/>
         </template>
       </category>
     </v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs6/>
            <v-flex xs6 px-3 mx-3 pt-5 style=" height: 100%">
       <category
       seen
       favorite
       @search="createMovie">
       <template v-slot:header>
         FAVORITES
       </template>
         <template v-slot:data>
            <movie class="pt-2" v-for="(movie) in getFavorites" :key="movie.id"
                :movie="movie"
                @delete="deleteMovie"
                @update="updateMovie"/>
         </template>
       </category>
     </v-flex>
      </v-layout>
    </v-content>
   
  </v-app>
</template>

<script>
import movie from './components/MovieCard.vue';
import category from './components/Category.vue';
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
        movies: null,
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
    deleteMovie( id){
      
      axios.delete('http://localhost:3000/movies/'+id).then((response) => {
        console.log(response);
      }).catch((error) => {
        console.log(error);
      });
       setTimeout(() => {this.getMovies()}, 200);
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
      setTimeout(() => {this.getMovies()}, 200);
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
      }
    },
  }

</script>
