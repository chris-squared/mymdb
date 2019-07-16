<template>
<v-card flat style="background: white; width: 100%;">
         <v-card-text >
                      <div class="text-xs-center"> <span class="py-5" v-if="length <= 0"> No Movies Added! Type To Add a Movie! </span> </div>

               <slot name="data"/>
            
            <v-layout row px-3 align-center justify-center>           
              <v-flex xs6>
                <v-text-field @keyup.enter="newMovie" append-icon="fas fa-search" v-model="search"/>
              </v-flex>
            <v-btn color="success" @click="newMovie"> Add Movie </v-btn>
            </v-layout>
         </v-card-text>
       </v-card>
</template>

<script>
    export default{
        data(){
            return {
                search: ''
            }
        },
        props: {
            seen: Boolean,
            favorite: Boolean,
            length: Number,
        },
        methods: {
            newMovie(){
                this.$emit('search', this.search, this.seen, this.favorite);
                this.search = '';
            }
        }
    }

</script>

<style>

</style>