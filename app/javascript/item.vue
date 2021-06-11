<template>
	<li class="p-5 border shadow mb-5 flex justify-between items-center bg-white">
		<div>
			<span class="text-lg leading-7 font-medium text-gray-900">{{ item.name }} <span class="font-bold">x{{ item.quantity }}</span></span>
		</div>
		<div class="flex items-center">
			<button class="p-3 bg-red-500 ring-2 ring-red-500 ring-offset-2 text-white rounded-full mr-2 active:bg-red-700 focus:ring-blue-500 focus:outline-none" v-on:click="decrement">
				<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
			</button>
			<button class="p-3 bg-green-500 ring-2 ring-green-500 ring-offset-2 text-white rounded-full ml-2 active:bg-green-700 focus:ring-blue-500 focus:outline-none" v-on:click="increment">
				<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd"></path></svg>
			</button>
		</div>
	</li>
</template>

<script>
	export default {
		props: ["item", "index"],
		methods: {
			increment: function() {
				this.$emit('increment', this.index)
			},
			decrement: function() {
				this.$emit('decrement', this.index)
			}
		}
	}
</script>