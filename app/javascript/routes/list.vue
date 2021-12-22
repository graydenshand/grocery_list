<template>
	<div class="p-5">
		<p class="text-gray-600 text-xs"><router-link to="/">Back</router-link></p>
		<div class="flex items-center">
			<input type="text" v-model="list.name" v-if="list" class="font-bold text-xl bg-gray-50 w-full border-b border-transparent focus:outline-none focus:border-blue-500" />
			<button class="p-2" v-on:click="deleteSelf">
				<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>
			</button>
		</div>
		<p class="text-red-700 font-bold" v-if="error">{{error}}</p>
  	<item v-for="(item) in items" v-bind:key="item.id" :item="item" v-on:update:error="error=$event" v-on:item-deleted="handleItemDeleted" v-on:create-item="handleCreateItem"></item>
	</div>
</template>

<script>
import { fetchList, createItem, renameList, deleteList } from '../requests.js';
import { debounce } from 'lodash';
import Item from "../components/item.vue";
export default {
	components: {
		Item
	},
	data() {
		return {
			items: [],
			list: null,
			error: null,	
		}
	},
	created: function() {
		this.debouncedRename = debounce(this.rename, 1000);
	},
	beforeRouteEnter(to, from, next) {
		fetchList(to.params.id)
			.then(function(response) {
				next(vm=>{
					vm.items = response.data.items;
					vm.list = response.data.list;
				})
			})
			.catch(function(error) {
				next(vm=>vm.error = "Something went wrong loading this list")
			});
	},
	methods: {
		handleItemDeleted(item_id) {
			const index = this.items.findIndex(item=>item.id == item_id)
			this.items.splice(index, 1)
			if (this.items.length == 0) {
				// If last item was deleted, create a new item. Ensures there is always at least one item in a list
				this.handleCreateItem(null);
			}
		},
		handleCreateItem(item_id) {
			const index = item_id ? this.items.findIndex(item=>item.id == item_id) : 0
			createItem(this.list.id)
				.then(response => {
					this.items.splice(index+1, 0, response.data);
					// Focus on newly created item
					setTimeout(()=>document.getElementById(`item-${response.data.id}-input`).focus(), 0);
				})
				.catch(error => {
					this.error = "Something went wrong creating a new item"
				})
		},
		rename() {
			console.log("rename firing")
			renameList(this.list.id, this.list.name)
				.catch(error=>{this.error="Something went wrong, your change was not saved"})
		},
		deleteSelf() {
			if (window.confirm("Are you sure you want to delete this list?")) {
				deleteList(this.list.id)
					.then(response=>{this.$router.push("/");})
					.catch(error=>{
						this.error = "Something went wrong, unable to delete list";
					});
				
			}
		}
	},
	watch: {
		"list.name": function(val, prevVal) {
			if (prevVal != null) {
				console.log("debouncing rename")
				this.debouncedRename();
			}
		}
	}
}
</script>