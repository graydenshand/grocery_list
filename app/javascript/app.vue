<template>
  <div>
    <h1 class="text-6xl font-black text-green-600 leading-none mb-10 pt-5 text-center">Grocery List</h1>
    <form class="relative mb-10" v-on:submit.prevent="createItem">
      <input type="text" class="w-full p-2 bg-white shadow focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none focus:border-0" placeholder="Klondike Bars" v-model="itemInput" />
      <button class="absolute right-0 top-0 p-2 bg-blue-500 font-semibold text-white shadow focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none active:bg-blue-700" type="submit">Add item</button>
    </form>
    <div v-if="loading" class="flex justify-center">
      <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-black" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    </div>
    <ul> 
      <item v-for="(item, index) in items" :item="item" :index="index" v-bind:key="item.id" v-on:increment="incrementItem" v-on:decrement="decrementItem"></item>
    </ul>
  </div>
</template>

<script>
import Item from './item.vue'

export default {
  components: {
    Item
  },
  data: function() {
    return {
      items: [],
      itemInput: "",
      error: null,
      loading: false
    }
  },
  methods: {
    incrementItem: function(index) {
      this.updateItemQuantity(index, this.items[index].quantity + 1)
      
    },
    decrementItem: function(index) {
      const newQty = this.items[index].quantity - 1
      if (newQty <= 0) {
        this.deleteItem(index)
        this.items.splice(index, 1)
      } else {
        this.updateItemQuantity(index, newQty)
      }
    },
    fetchItems() {
      this.error = null
      this.loading = true

      const url = "/api/v1/items"
      fetch(url)
        .then(response => response.json())
        .then(json => {
          this.items = json
        })
      this.loading = false
    },
    updateItemQuantity(index, quantity) {
      this.loading = true
      const id = this.items[index].id
      const url = "/api/v1/items/" + id.toString()
      const data = {
        quantity: quantity
      }
      const headers = {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("[name='csrf-token']").getAttribute("content"),
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
      fetch(url, {
        method:"PUT", 
        body: JSON.stringify(data),
        headers: headers,
        credentials: "same-origin"
      })
      .then(response => response.json())
      .then(json => {
        this.items[index].quantity = quantity
      })
      this.loading = false
    },
    deleteItem(index) {
      const id = this.items[index].id
      const url = "/api/v1/items/" + id.toString()
      const headers = {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": document.head.querySelector("[name='csrf-token']").getAttribute("content"),
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
      fetch(url, {
        method:"DELETE",
        headers: headers,
        credentials: "same-origin"
      })
      .then(response => response.json())
      .then(json => {
        console.log(json)
      })
    },
    createItem(name, quantity) {
      if (this.itemInput !== "") {
        const url = "/api/v1/items"
        const headers = {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": document.head.querySelector("[name='csrf-token']").getAttribute("content"),
          "Content-Type": "application/json",
          "Accept": "application/json",
        }
        const data = {
          name: this.itemInput,
          quantity: 1
        }
        fetch(url, {
          method:"POST",
          headers: headers,
          body: JSON.stringify(data),
          credentials: "same-origin"
        })
        .then(response => response.json())
        .then(json => {
          if (json.error) {
            this.error = "Unable to add item"
          } else {
            this.items = [json, ...this.items]
            this.itemInput = ""    
          }
        })
      }
      
    }
  },
  created() {
    this.fetchItems();
  }

}
</script>

<style scoped>
</style>
