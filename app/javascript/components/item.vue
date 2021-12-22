<template>
	<!-- <p>{{name}}</p> -->
	<div class="my-1">
		<div class="flex items-center">
			<button class="h-4 w-4 mr-2 rounded-full bg-white border border-gray-300 flex justify-center items-center" v-on:click="deleteSelf">
				<svg v-if="isDeleting" class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>
			</button>
			<input v-model="name" v-bind:id="`item-${item.id}-input`" type="text" class="bg-gray-50 w-full border-b border-transparent rounded-none focus:outline-none focus:border-blue-500" v-on:keyup.enter="$emit('create-item', item.id)" />
		</div>
		<p class="text-xs text-red-500">{{error}}</p>
	</div>
</template>

<script>
	import { debounce } from 'lodash';
	import { renameItem, deleteItem } from "requests.js";
	export default {
		props: ["item"],
		data: function() {
			return {
				name: this.item.name,
				error: null,
				isDeleting: false,
			}
		},
		created: function() {
			this.debouncedRename = debounce(this.rename, 1000);
		},
		methods: {
			rename() {
				if (this.error) {
					// clear error if one is set
					this.error = null;
				}
				renameItem(this.item.id, this.name)
					.catch((error) => { 
						this.error = "Something went wrong, your change was not saved";
					})
			},
			deleteSelf() {
				this.isDeleting = true;
				deleteItem(this.item.id)
					.then((response) => {
						this.$emit("item-deleted", this.item.id);
					})
					.catch(error=> {
						this.error = "Something went wrong, your change was not saved";
					})
			}
		},
		watch: {
			name: function() { 
				this.debouncedRename();
			}
		}
	}
</script>