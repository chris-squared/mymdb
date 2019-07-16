<template>
<v-fade-transition>
 <v-card flat v-if="show" style="width: 100%;">
         <v-card-text>
            <v-layout row>
             <div style="height: 100px; width: 70px">
              <img style="max-height: 100%; max-width: 100%;" :src="movie.poster"/>
             </div>
             <v-flex>
               <v-layout row align-end style="height: 50%">
                 <span> <i> {{movie.title}} </i> </span>
               </v-layout>
               <v-layout row style="height: 25%">
                 <span> {{movie.studio}} </span>
               </v-layout>
               <v-layout row style="height: 25%">
                 
                  <span> {{movie.genre}}</span>
               
                 <span class="px-2"> {{movie.Rating}}/10 </span>
                 <div class="text-xs-center" style="height: 20px; width: 20px; background: green">
                      <span> {{movie.mc}} </span> 
                </div>
                <div class="px-2"> {{movie.rt}} </div>
               </v-layout>
             </v-flex>
             <v-flex>
                 <v-layout row style="height: 100%" justify-end align-center>
                     <v-icon @click="updateMovie" class="px-3" v-if="!movie.seen"> fas fa-eye </v-icon>
                     <v-icon @click="updateFavoriteMovie"  v-if="movie.seen" :color="(movie.favorite) ? 'yellow' : ''" class="pr-3"> fas fa-star </v-icon>
                     <v-icon @click="deleteMovie"> fas fa-trash </v-icon>
                 </v-layout>
             </v-flex>
            </v-layout>
          
         </v-card-text>
       </v-card>
</v-fade-transition>
</template>

<script>
    export default {
        data(){
           
        },
        methods: {
            updateFavoriteMovie(){
                setTimeout(() => {
                    this.$emit('update', this.movie.id, true, !this.movie.favorite);
                })
            },
            updateMovie(){
                setTimeout(() => {
                    this.$emit('update', this.movie.id, true, this.movie.favorite);
                })
            },
            deleteMovie(){
                this.show = false;
                setTimeout(() => {this.$emit('delete',  this.movie.id)}, 200);
            }
        },
        props: {
            movie: Object,
        }
    }

</script>