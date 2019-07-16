<template>
<v-card flat style="background: white">
         <v-card-text>
            <v-layout row justify-center>
              <span style="font-size: 28px"> <slot name="header"/> </span>
              
            </v-layout>
               <slot name="data"/>
            
            <v-layout row px-3 align-center justify-center>           
              <v-flex xs6>
                <v-text-field @keyup.enter="newMovie" append-icon="fas fa-search" v-model="search"/>
              </v-flex>
            <v-btn color="error" @click="newMovie"> Add Movie </v-btn>
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
        },
        methods: {
            newMovie(){
                this.$emit('search', this.search, this.seen, this.favorite);
            }
        }
    }

</script>

<style>

</style>