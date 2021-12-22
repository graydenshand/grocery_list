<template>
  <div class="p-5">
    <div class="flex items-center">
      <h3 class="font-bold text-xl">Lists</h3>
      <button class="px-2" v-on:click="handleCreateList">
        <svg class="w-6 h-6 inline" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-11a1 1 0 10-2 0v2H7a1 1 0 100 2h2v2a1 1 0 102 0v-2h2a1 1 0 100-2h-2V7z" clip-rule="evenodd"></path></svg>
      </button>
    </div>
    <p class="text-red-700 font-bold" v-if="error">{{error}}</p>
    <p v-for="(list) in lists" v-bind:key="list.name" class="my-2"><router-link v-bind:to="`/list/${list.id}`" class="underline">{{list.name}}</router-link></p>
    
  </div>
</template>

<script>
  import { fetchLists, createList, createItem, deleteList } from '../requests.js';
  export default {
		data() {
			return { 
        lists: [],
        error: null
      }
		},
    beforeRouteEnter(to, from, next) {
      fetchLists()
        .then(function(response) {
          next(vm => vm.lists = response.data);
        })
        .catch(function(error) {
          next(vm => vm.error = "Something went wrong trying to load your lists");
        });
    },
    methods: {
      handleCreateList() {
          createList()
            .then(response=>{
              this.lists.push(response.data)
              createItem(response.data.id)
                .then(()=>{this.$router.push(`/list/${response.data.id}`)})
                .catch(error=>{
                  // Try to delete the list since it's not usable without the first item
                  deleteList(response.data.id);
                  this.error="Something went wrong trying to create a new list";
                })
            })
            .catch(error=>{this.error="Something went wrong trying to create a new list"})
      }
    }
	}
</script>
