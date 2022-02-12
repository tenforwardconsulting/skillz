<script src="https://cdn.tailwindcss.com"></script>
<script>
export default {
  data() {
    return {
      currentWord: "",
      words: {
        "Computer Hardware": [
          "Hard Drive (Disk)",
          "Memory",
          "CPU Cache",
          "Processor (CPU)",
          "Graphics card (GPU)",
          "Motherboard"
        ],
        "Operating Systems": [
          "File",
          "Directory/Folder",
          "Command line/Terminal Emulator",
          "Socket"
        ]
      }
    }
  },
  mounted() {
    fetch("/words.json")
      .then( (response) => response.json())
      .then( (json) => this.words = json )
  }
}
</script>

<template>
  <div>
    <h1>Glossary Game</h1>
    <div v-for="(terms, category) in words" v-bind:key="category">
      <h2>{{category}}</h2>
      <ul>
        <li v-for="term in terms" v-bind:key="term" class="greeting">{{ term }}
            <div class="min-w-0 flex-1">
              <div class="border-b border-gray-200 focus-within:border-indigo-600">
                <label for="comment" class="sr-only">Add your comment</label>
                <textarea rows="3" name="comment" id="comment" class="block w-full border-0 border-b border-transparent p-0 pb-2 resize-none focus:ring-0 focus:border-indigo-600 sm:text-sm" placeholder="Add your comment..."></textarea>
              </div>
            </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<style>
  .greeting {
    color: red;
    font-weight: bold;
  }
</style>
