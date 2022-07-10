<script setup lang="ts">
import { ref } from 'vue'
import { RouterLink } from 'vue-router';
import { BlogsApi } from '@/../types/fetch/apis'
import type { Blog } from '@/../types/fetch/models'
import { DefaultConfig, Configuration } from '../../types/fetch/runtime'

DefaultConfig.config = new Configuration({
  basePath: import.meta.env.PROD ? "https://www.example.com" : "http://localhost:3000",
})

const blogs = ref<Blog[]>()
new BlogsApi().getBlogs().then(res => blogs.value = res)

// const getBlogs = async () => {
//   blogs.value = await new BlogsApi().getBlogs()
//   console.log("file")
// }
</script>

<script lang="ts">
export default {
  methods: {
    async getBlogs() {
      const data = await new BlogsApi().getBlogs()
      console.log(data)
    }
  }
}
</script>

<template>
  <div style="margin: auto; width: 1000px">
    <h1>ブログ一覧画面</h1>
      <p v-for="blog in blogs">{{blog.title}}</p>
    <div>
      <RouterLink to="/">TOP</RouterLink>
    </div>
    <div>
      <RouterLink to="/create">記事作成画面</RouterLink>
    </div>

    <button id="get-blogs" @click="getBlogs">ブログ取得</button>
  </div>
</template>
